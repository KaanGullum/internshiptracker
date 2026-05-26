//
//  InternshipApplication.swift
//  InternshipTracker
//

import Foundation
import SwiftData

@Model
final class InternshipApplication: Identifiable {
    var id: UUID
    var companyName: String
    var roleTitle: String
    var statusRawValue: String
    var location: String
    var workModeRawValue: String
    var applicationURL: String
    var appliedDate: Date?
    var deadlineDate: Date?
    var followUpDate: Date?
    var contactName: String
    var contactEmail: String
    var notes: String
    var createdAt: Date
    var updatedAt: Date

    init(
        id: UUID = UUID(),
        companyName: String,
        roleTitle: String,
        status: ApplicationStatus = .draft,
        location: String = "",
        workMode: WorkMode = .unknown,
        applicationURL: String = "",
        appliedDate: Date? = nil,
        deadlineDate: Date? = nil,
        followUpDate: Date? = nil,
        contactName: String = "",
        contactEmail: String = "",
        notes: String = "",
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) {
        self.id = id
        self.companyName = companyName
        self.roleTitle = roleTitle
        self.statusRawValue = status.rawValue
        self.location = location
        self.workModeRawValue = workMode.rawValue
        self.applicationURL = applicationURL
        self.appliedDate = appliedDate
        self.deadlineDate = deadlineDate
        self.followUpDate = followUpDate
        self.contactName = contactName
        self.contactEmail = contactEmail
        self.notes = notes
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    var status: ApplicationStatus {
        get { ApplicationStatus(rawValue: statusRawValue) ?? .draft }
        set { statusRawValue = newValue.rawValue }
    }

    var workMode: WorkMode {
        get { WorkMode(rawValue: workModeRawValue) ?? .unknown }
        set { workModeRawValue = newValue.rawValue }
    }

    var applicationLinkURL: URL? {
        Self.normalizedURL(from: applicationURL)
    }

    static func normalizedURL(from value: String) -> URL? {
        let trimmedURL = value.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedURL.isEmpty else {
            return nil
        }

        if let url = URL(string: trimmedURL), url.scheme != nil, url.host != nil {
            return url
        }

        guard let url = URL(string: "https://\(trimmedURL)"), url.host != nil else {
            return nil
        }

        return url
    }
}
