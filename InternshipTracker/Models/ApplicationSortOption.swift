//
//  ApplicationSortOption.swift
//  InternshipTracker
//

import Foundation

enum ApplicationSortOption: String, CaseIterable, Identifiable {
    case newest = "Newest"
    case deadline = "Deadline"
    case followUp = "Follow-up"

    var id: String { rawValue }

    var systemImage: String {
        switch self {
        case .newest:
            "clock.arrow.circlepath"
        case .deadline:
            "calendar"
        case .followUp:
            "bell"
        }
    }
}
