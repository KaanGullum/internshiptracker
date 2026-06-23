//
//  PreviewData.swift
//  InternshipTracker
//

import Foundation
import SwiftData

@MainActor
enum PreviewData {
    static var sampleApplication: InternshipApplication {
        InternshipApplication(
            companyName: "Apple",
            roleTitle: "iOS Software Engineering Intern",
            status: .interview,
            location: "Cupertino, CA",
            workMode: .hybrid,
            applicationURL: "https://apple.com/careers",
            appliedDate: .now.addingTimeInterval(-345_600),
            deadlineDate: .now.addingTimeInterval(604_800),
            followUpDate: .now.addingTimeInterval(172_800),
            contactName: "Recruiting Team",
            contactEmail: "careers@example.com",
            notes: "Prepare portfolio notes before the next call."
        )
    }

    static var sampleApplications: [InternshipApplication] {
        [
            sampleApplication,
            InternshipApplication(
                companyName: "Figma",
                roleTitle: "Product Engineering Intern",
                status: .applied,
                location: "San Francisco, CA",
                workMode: .remote,
                applicationURL: "figma.com/careers",
                appliedDate: .now.addingTimeInterval(-172_800),
                deadlineDate: .now.addingTimeInterval(432_000),
                followUpDate: .now.addingTimeInterval(86_400),
                contactName: "University Recruiting",
                contactEmail: "internships@example.com",
                notes: "Mention design systems project if they reply."
            ),
            InternshipApplication(
                companyName: "Stripe",
                roleTitle: "New Grad Software Engineer",
                status: .technicalTest,
                location: "Dublin, Ireland",
                workMode: .hybrid,
                applicationURL: "https://stripe.com/jobs",
                appliedDate: .now.addingTimeInterval(-604_800),
                deadlineDate: .now.addingTimeInterval(259_200),
                followUpDate: .now.addingTimeInterval(-21_600),
                contactName: "Alex Morgan",
                contactEmail: "alex@example.com",
                notes: "Technical assessment due this week."
            ),
            InternshipApplication(
                companyName: "Notion",
                roleTitle: "Mobile Engineer Intern",
                status: .offer,
                location: "New York, NY",
                workMode: .onSite,
                applicationURL: "",
                appliedDate: .now.addingTimeInterval(-1_036_800),
                deadlineDate: nil,
                followUpDate: nil,
                contactName: "",
                contactEmail: "",
                notes: "Review offer details and ask about mentorship."
            ),
            InternshipApplication(
                companyName: "Meta",
                roleTitle: "Software Engineer Intern",
                status: .archived,
                location: "London, UK",
                workMode: .unknown,
                applicationURL: "https://www.metacareers.com",
                appliedDate: .now.addingTimeInterval(-1_209_600),
                deadlineDate: nil,
                followUpDate: nil,
                contactName: "",
                contactEmail: "",
                notes: "Archived after the hiring season ended."
            )
        ]
    }

    static var previewContainer: ModelContainer {
        let schema = Schema([InternshipApplication.self])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

        do {
            let container = try ModelContainer(for: schema, configurations: [configuration])

            for application in sampleApplications {
                container.mainContext.insert(application)
            }

            return container
        } catch {
            preconditionFailure("Could not create preview container: \(error)")
        }
    }
}
