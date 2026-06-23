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
    @State private var showingDeleteError = false
    @State private var showingUpdateError = false

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
                        Label("Open Application Page", systemImage: "safari")
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

                if let emailURL {
                    Link(destination: emailURL) {
                        Label(application.contactEmail, systemImage: "envelope")
                    }
                } else {
                    DetailRow(title: "Email", value: displayValue(application.contactEmail))
                }
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
                if application.status != .archived {
                    Button {
                        archiveApplication()
                    } label: {
                        Label("Archive", systemImage: "archivebox")
                    }
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
        .alert("Could not delete", isPresented: $showingDeleteError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Something went wrong while deleting this application. Please try again.")
        }
        .alert("Could not update", isPresented: $showingUpdateError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Something went wrong while updating this application. Please try again.")
        }
    }

    private func displayValue(_ value: String) -> String {
        let trimmedValue = value.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedValue.isEmpty ? "Not provided" : trimmedValue
    }

    private var emailURL: URL? {
        let trimmedEmail = application.contactEmail.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedEmail.isEmpty else {
            return nil
        }

        return URL(string: "mailto:\(trimmedEmail)")
    }

    private func archiveApplication() {
        application.status = .archived
        application.updatedAt = .now

        do {
            try modelContext.save()
            NotificationManager.shared.cancelFollowUpNotification(applicationID: application.id)
        } catch {
            showingUpdateError = true
        }
    }

    private func deleteApplication() {
        let applicationID = application.id

        modelContext.delete(application)

        do {
            try modelContext.save()
            NotificationManager.shared.cancelFollowUpNotification(applicationID: applicationID)
            dismiss()
        } catch {
            showingDeleteError = true
        }
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
        ApplicationDetailView(application: PreviewData.sampleApplication)
    }
    .modelContainer(PreviewData.previewContainer)
}
