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
    @Query(
        filter: #Predicate<User> { user in
            user.name.localizedStandardContains("R")
        },
        sort: \User.name
    ) var users: [User]
    @State private var path = [User]()

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(users) { user in
                    NavigationLink(value: user) {
                        HStack(alignment: .lastTextBaseline) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(user.name)
                                    .font(.headline)

                                Text(user.city)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()

                            Text(user.joinDate, style: .date)
                                .font(.callout)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteUser)
            }
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
            }
        }
    }

    func deleteUser(at offsets: IndexSet) {
        for offset in offsets {
            let user = users[offset]

            modelContext.delete(user)
        }
    }
}

#Preview {
    ContentView()
}
