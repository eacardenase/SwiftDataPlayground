//
//  EditUserView.swift
//  SwiftDataPlayground
//
//  Created by Edwin Cardenas on 5/3/26.
//

import SwiftData
import SwiftUI

struct EditUserView: View {
    @Bindable var user: User

    var body: some View {
        Form {
            TextField("Name", text: $user.name)
                .textInputAutocapitalization(.words)

            TextField("City", text: $user.city)
            DatePicker(
                "Join Date",
                selection: $user.joinDate,
                displayedComponents: .date
            )
        }
        .navigationTitle("Edit User")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(
            for: User.self,
            configurations: config
        )
        let user = User(name: "Edwin", city: "Bogota", joinDate: .now)

        return EditUserView(user: user)
            .modelContainer(container)
    } catch {
        return Text(
            "Failed to create container with error: \(error.localizedDescription)"
        )
    }

}
