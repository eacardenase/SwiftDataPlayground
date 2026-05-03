//
//  SwiftDataPlaygroundApp.swift
//  SwiftDataPlayground
//
//  Created by Edwin Cardenas on 5/3/26.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataPlaygroundApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
