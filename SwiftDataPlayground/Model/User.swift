//
//  User.swift
//  SwiftDataPlayground
//
//  Created by Edwin Cardenas on 5/3/26.
//

import Foundation
import SwiftData

@Model
class User {
    var name: String = "Anonymous"
    var city: String = "Unknown"
    var joinDate: Date = Date.now
    @Relationship(deleteRule: .cascade) var jobs: [Job]? = [Job]()

    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }

    var isUserValid: Bool {
        return !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && !city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
