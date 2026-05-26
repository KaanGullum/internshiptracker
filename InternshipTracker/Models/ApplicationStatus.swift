//
//  ApplicationStatus.swift
//  InternshipTracker
//

import Foundation

enum ApplicationStatus: String, CaseIterable, Identifiable {
    case draft = "Draft"
    case applied = "Applied"
    case interview = "Interview"
    case technicalTest = "Technical Test"
    case offer = "Offer"
    case rejected = "Rejected"
    case accepted = "Accepted"
    case archived = "Archived"

    var id: String { rawValue }

    var systemImage: String {
        switch self {
        case .draft:
            "doc.text"
        case .applied:
            "paperplane"
        case .interview:
            "person.2"
        case .technicalTest:
            "laptopcomputer"
        case .offer:
            "sparkles"
        case .rejected:
            "xmark.circle"
        case .accepted:
            "checkmark.seal"
        case .archived:
            "archivebox"
        }
    }
}
