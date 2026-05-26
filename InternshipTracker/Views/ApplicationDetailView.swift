//
//  ApplicationDetailView.swift
//  InternshipTracker
//

import SwiftData
import SwiftUI

struct ApplicationDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    let application: InternshipApplication

    @State private var showingEditForm = false
    @State private var showingDeleteConfirmation = false

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 10) {
                    Text(application.companyName)
                        .font(.title2.weight(.bold))

                    Text(application.roleTitle)
                        .font(.headline)
                        .foregroundStyle(.secondary)

                    StatusBadge(status: application.status)
                }
                .padding(.vertical, 6)
            }

            Section("Application") {
                DetailRow(title: "Status", value: application.status.rawValue)
                DetailRow(title: "Location", value: displayValue(application.location))
                DetailRow(title: "Work mode", value: application.workMode.rawValue)

                if let url = application.applicationLinkURL {
                    Link(destination: url) {
                        DetailRow(title: "Application URL", value: url.absoluteString)
                    }
                } else {
                    DetailRow(title: "Application URL", value: "Not provided")
                }
            }

            Section("Dates") {
                DetailRow(title: "Applied", value: application.appliedDate?.applicationDateText ?? "Not set")
                DetailRow(title: "Deadline", value: application.deadlineDate?.applicationDateText ?? "Not set")
                DetailRow(title: "Follow-up", value: application.followUpDate?.reminderDateText ?? "Not set")
            }

            Section("Contact") {
                DetailRow(title: "Name", value: displayValue(application.contactName))
                DetailRow(title: "Email", value: displayValue(application.contactEmail))
            }

            Section("Notes") {
                Text(displayValue(application.notes))
                    .foregroundStyle(application.notes.isEmpty ? .secondary : .primary)
            }

            Section("History") {
                DetailRow(title: "Created", value: application.createdAt.reminderDateText)
                DetailRow(title: "Updated", value: application.updatedAt.reminderDateText)
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") {
                    showingEditForm = true
                }
            }

            ToolbarItem(placement: .bottomBar) {
                Button(role: .destructive) {
                    showingDeleteConfirmation = true
                } label: {
                    Label("Delete Application", systemImage: "trash")
                }
            }
        }
        .sheet(isPresented: $showingEditForm) {
            NavigationStack {
                ApplicationFormView(application: application)
            }
        }
        .confirmationDialog(
            "Delete this application?",
            isPresented: $showingDeleteConfirmation,
            titleVisibility: .visible
        ) {
            Button("Delete", role: .destructive, action: deleteApplication)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("This cannot be undone.")
        }
    }

    private func displayValue(_ value: String) -> String {
        let trimmedValue = value.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedValue.isEmpty ? "Not provided" : trimmedValue
    }

    private func deleteApplication() {
        NotificationManager.shared.cancelFollowUpNotification(applicationID: application.id)
        modelContext.delete(application)
        dismiss()
    }
}

private struct DetailRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
                .foregroundStyle(.secondary)

            Spacer(minLength: 16)

            Text(value)
                .multilineTextAlignment(.trailing)
        }
    }
}

#Preview {
    NavigationStack {
        ApplicationDetailView(
            application: InternshipApplication(
                companyName: "Apple",
                roleTitle: "iOS Software Engineering Intern",
                status: .applied,
                location: "Cupertino, CA",
                workMode: .hybrid,
                applicationURL: "https://apple.com/careers",
                appliedDate: .now,
                deadlineDate: .now.addingTimeInterval(604_800),
                followUpDate: .now.addingTimeInterval(172_800),
                contactName: "Recruiting Team",
                contactEmail: "careers@example.com",
                notes: "Follow up after the first screening call."
            )
        )
    }
    .modelContainer(for: InternshipApplication.self, inMemory: true)
}
