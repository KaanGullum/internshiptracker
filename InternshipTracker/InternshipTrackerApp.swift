//
//  InternshipTrackerApp.swift
//  InternshipTracker
//
//  Created by Kaan Güllü on 26.05.2026.
//

import SwiftUI
import SwiftData

@main
struct InternshipTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: InternshipApplication.self)
    }
}
