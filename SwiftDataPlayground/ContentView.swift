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

    var body: some View {
        NavigationStack(path: $path) {
            UsersView(
                minimumJoinDate: showingUpcomingOnly ? .now : .distantPast
            )
            .navigationTitle("Users")
            .navigationDestination(for: User.self) { user in
                EditUserView(user: user, isEditing: user.isUserValid)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(
                        showingUpcomingOnly ? "Show Everyone" : "Show Upcoming"
                    ) {
                        showingUpcomingOnly.toggle()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add User", systemImage: "plus") {
                        let user = User(name: "", city: "", joinDate: .now)

                        modelContext.insert(user)

                        path = [user]
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
