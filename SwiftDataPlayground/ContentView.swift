//
//  ContentView.swift
//  SwiftDataPlayground
//
//  Created by Edwin Cardenas on 5/3/26.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = [User]()
    @State private var showingUpcomingOnly = false
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate),
    ]

    var body: some View {
        NavigationStack(path: $path) {
            UsersView(
                minimumJoinDate: showingUpcomingOnly ? .now : .distantPast,
                sortOrder: sortOrder
            )
            .navigationTitle("Users")
            .navigationDestination(for: User.self) { user in
                EditUserView(user: user, isEditing: user.isUserValid)
            }
            .toolbar {
                Button("Add User", systemImage: "plus") {
                    let user = User(name: "", city: "", joinDate: .now)

                    modelContext.insert(user)

                    path = [user]
                }

                Menu("Filter", systemImage: "line.3.horizontal.decrease") {
                    Button(
                        showingUpcomingOnly ? "Show Everyone" : "Show Upcoming"
                    ) {
                        showingUpcomingOnly.toggle()
                    }
                }

                Menu("Sort", systemImage: "arrow.up.arrow.down") {

                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\User.name),
                                SortDescriptor(\User.joinDate),
                            ])

                        Text("Sort by Date")
                            .tag([
                                SortDescriptor(\User.joinDate),
                                SortDescriptor(\User.name),
                            ])
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
