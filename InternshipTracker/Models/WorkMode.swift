//
//  WorkMode.swift
//  InternshipTracker
//

import Foundation

enum WorkMode: String, CaseIterable, Identifiable {
    case onSite = "On-site"
    case hybrid = "Hybrid"
    case remote = "Remote"
    case unknown = "Unknown"

    var id: String { rawValue }

    var systemImage: String {
        switch self {
        case .onSite:
            "building.2"
        case .hybrid:
            "arrow.triangle.2.circlepath"
        case .remote:
            "house.lodge"
        case .unknown:
            "questionmark.circle"
        }
    }
}
