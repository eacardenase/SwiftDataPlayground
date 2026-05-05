//
//  UsersView.swift
//  SwiftDataPlayground
//
//  Created by Edwin Cardenas on 5/5/26.
//

import SwiftData
import SwiftUI

struct UsersView: View {
    @Query(sort: \User.name) var users: [User]
    @Environment(\.modelContext) var modelContext

    var body: some View {
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
    }

    func deleteUser(at offsets: IndexSet) {
        for offset in offsets {
            let user = users[offset]

            modelContext.delete(user)
        }
    }
}

#Preview {
    UsersView()
        .modelContainer(for: User.self)
}
