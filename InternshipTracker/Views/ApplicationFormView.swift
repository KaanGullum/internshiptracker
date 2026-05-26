//
//  ApplicationFormView.swift
//  InternshipTracker
//

import SwiftData
import SwiftUI

struct ApplicationFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    private let application: InternshipApplication?

    @State private var companyName: String
    @State private var roleTitle: String
    @State private var status: ApplicationStatus
    @State private var location: String
    @State private var workMode: WorkMode
    @State private var applicationURL: String
    @State private var hasAppliedDate: Bool
    @State private var appliedDate: Date
    @State private var hasDeadlineDate: Bool
    @State private var deadlineDate: Date
    @State private var hasFollowUpDate: Bool
    @State private var followUpDate: Date
    @State private var contactName: String
    @State private var contactEmail: String
    @State private var notes: String
    @State private var showingValidationAlert = false

    init(application: InternshipApplication? = nil) {
        self.application = application

        _companyName = State(initialValue: application?.companyName ?? "")
        _roleTitle = State(initialValue: application?.roleTitle ?? "")
        _status = State(initialValue: application?.status ?? .draft)
        _location = State(initialValue: application?.location ?? "")
        _workMode = State(initialValue: application?.workMode ?? .unknown)
        _applicationURL = State(initialValue: application?.applicationURL ?? "")
        _hasAppliedDate = State(initialValue: application?.appliedDate != nil)
        _appliedDate = State(initialValue: application?.appliedDate ?? .now)
        _hasDeadlineDate = State(initialValue: application?.deadlineDate != nil)
        _deadlineDate = State(initialValue: application?.deadlineDate ?? .now)
        _hasFollowUpDate = State(initialValue: application?.followUpDate != nil)
        _followUpDate = State(initialValue: application?.followUpDate ?? .now.addingTimeInterval(86_400))
        _contactName = State(initialValue: application?.contactName ?? "")
        _contactEmail = State(initialValue: application?.contactEmail ?? "")
        _notes = State(initialValue: application?.notes ?? "")
    }

    var body: some View {
        Form {
            Section("Required") {
                TextField("Company name", text: $companyName)
                    .textContentType(.organizationName)

                TextField("Role title", text: $roleTitle)

                Picker("Status", selection: $status) {
                    ForEach(ApplicationStatus.allCases) { status in
                        Label(status.rawValue, systemImage: status.systemImage)
                            .tag(status)
                    }
                }
            }

            Section("Details") {
                TextField("Location", text: $location)

                Picker("Work mode", selection: $workMode) {
                    ForEach(WorkMode.allCases) { mode in
                        Label(mode.rawValue, systemImage: mode.systemImage)
                            .tag(mode)
                    }
                }

                TextField("Application URL", text: $applicationURL)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.URL)
                    .autocorrectionDisabled()
            }

            Section("Dates") {
                Toggle("Applied date", isOn: $hasAppliedDate)

                if hasAppliedDate {
                    DatePicker("Applied", selection: $appliedDate, displayedComponents: .date)
                }

                Toggle("Deadline date", isOn: $hasDeadlineDate)

                if hasDeadlineDate {
                    DatePicker("Deadline", selection: $deadlineDate, displayedComponents: .date)
                }

                Toggle("Follow-up reminder", isOn: $hasFollowUpDate)

                if hasFollowUpDate {
                    DatePicker(
                        "Follow up",
                        selection: $followUpDate,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                }
            }

            Section("Contact") {
                TextField("Contact name", text: $contactName)
                    .textContentType(.name)

                TextField("Contact email", text: $contactEmail)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
            }

            Section("Notes") {
                TextEditor(text: $notes)
                    .frame(minHeight: 120)
            }
        }
        .navigationTitle(application == nil ? "Add Application" : "Edit Application")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }

            ToolbarItem(placement: .confirmationAction) {
                Button("Save", action: saveApplication)
            }
        }
        .alert("Missing required information", isPresented: $showingValidationAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please enter both a company name and a role title.")
        }
    }

    private func saveApplication() {
        let trimmedCompanyName = companyName.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedRoleTitle = roleTitle.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedCompanyName.isEmpty, !trimmedRoleTitle.isEmpty else {
            showingValidationAlert = true
            return
        }

        let savedApplication: InternshipApplication

        if let application {
            application.companyName = trimmedCompanyName
            application.roleTitle = trimmedRoleTitle
            application.status = status
            application.location = trimmed(location)
            application.workMode = workMode
            application.applicationURL = trimmed(applicationURL)
            application.appliedDate = hasAppliedDate ? appliedDate : nil
            application.deadlineDate = hasDeadlineDate ? deadlineDate : nil
            application.followUpDate = hasFollowUpDate ? followUpDate : nil
            application.contactName = trimmed(contactName)
            application.contactEmail = trimmed(contactEmail)
            application.notes = notes.trimmingCharacters(in: .whitespacesAndNewlines)
            application.updatedAt = .now
            savedApplication = application
        } else {
            let newApplication = InternshipApplication(
                companyName: trimmedCompanyName,
                roleTitle: trimmedRoleTitle,
                status: status,
                location: trimmed(location),
                workMode: workMode,
                applicationURL: trimmed(applicationURL),
                appliedDate: hasAppliedDate ? appliedDate : nil,
                deadlineDate: hasDeadlineDate ? deadlineDate : nil,
                followUpDate: hasFollowUpDate ? followUpDate : nil,
                contactName: trimmed(contactName),
                contactEmail: trimmed(contactEmail),
                notes: notes.trimmingCharacters(in: .whitespacesAndNewlines)
            )
            modelContext.insert(newApplication)
            savedApplication = newApplication
        }

        updateNotification(for: savedApplication)
        dismiss()
    }

    private func updateNotification(for application: InternshipApplication) {
        guard let followUpDate = application.followUpDate else {
            NotificationManager.shared.cancelFollowUpNotification(applicationID: application.id)
            return
        }

        let applicationID = application.id
        let companyName = application.companyName
        let roleTitle = application.roleTitle

        Task {
            await NotificationManager.shared.scheduleFollowUpNotification(
                applicationID: applicationID,
                companyName: companyName,
                roleTitle: roleTitle,
                followUpDate: followUpDate
            )
        }
    }

    private func trimmed(_ value: String) -> String {
        value.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

#Preview {
    NavigationStack {
        ApplicationFormView()
    }
    .modelContainer(for: InternshipApplication.self, inMemory: true)
}
