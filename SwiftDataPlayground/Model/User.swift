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
    var name: String
    var city: String
    var joinDate: Date
    var jobs = [Job]()

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
