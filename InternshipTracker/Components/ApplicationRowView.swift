//
//  ApplicationRowView.swift
//  InternshipTracker
//

import SwiftUI

struct ApplicationRowView: View {
    let application: InternshipApplication

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .firstTextBaseline) {
                Text(application.companyName)
                    .font(.headline)
                    .lineLimit(1)

                Spacer(minLength: 12)

                StatusBadge(status: application.status)
            }

            Text(application.roleTitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)

            HStack(spacing: 12) {
                Label(application.workMode.rawValue, systemImage: application.workMode.systemImage)
                    .foregroundStyle(.secondary)

                if let followUpDate = application.followUpDate {
                    Label(followUpDate.reminderDateText, systemImage: "bell")
                        .foregroundStyle(followUpDate.isPastDue ? .red : .secondary)
                } else if let deadlineDate = application.deadlineDate {
                    Label(deadlineDate.applicationDateText, systemImage: "calendar")
                        .foregroundStyle(.secondary)
                }
            }
            .font(.caption)
            .lineLimit(1)
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    List {
        ApplicationRowView(application: PreviewData.sampleApplication)
    }
}
