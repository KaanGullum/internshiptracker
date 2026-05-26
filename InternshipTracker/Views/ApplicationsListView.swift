//
//  ApplicationsListView.swift
//  InternshipTracker
//

import SwiftData
import SwiftUI

struct ApplicationsListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \InternshipApplication.createdAt, order: .reverse)
    private var applications: [InternshipApplication]

    @State private var searchText = ""
    @State private var selectedStatus: ApplicationStatus?
    @State private var showingForm = false

    var body: some View {
        NavigationStack {
            Group {
                if applications.isEmpty {
                    ContentUnavailableView(
                        "No applications yet",
                        systemImage: "tray",
                        description: Text("Add your first internship or junior job application to start tracking.")
                    )
                } else if filteredApplications.isEmpty {
                    ContentUnavailableView(
                        "No matching applications",
                        systemImage: "magnifyingglass",
                        description: Text("Try changing the search text or status filter.")
                    )
                } else {
                    List {
                        ForEach(filteredApplications) { application in
                            NavigationLink {
                                ApplicationDetailView(application: application)
                            } label: {
                                ApplicationRowView(application: application)
                            }
                        }
                        .onDelete(perform: deleteApplications)
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Applications")
            .searchable(text: $searchText, prompt: "Search company or role")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Picker("Status", selection: $selectedStatus) {
                        Text("All Statuses").tag(ApplicationStatus?.none)

                        ForEach(ApplicationStatus.allCases) { status in
                            Text(status.rawValue).tag(Optional(status))
                        }
                    }
                    .pickerStyle(.menu)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingForm = true
                    } label: {
                        Label("Add Application", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingForm) {
                NavigationStack {
                    ApplicationFormView()
                }
            }
        }
    }

    private var filteredApplications: [InternshipApplication] {
        let trimmedSearchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        return applications.filter { application in
            let matchesStatus = selectedStatus == nil || application.status == selectedStatus
            let matchesSearch = trimmedSearchText.isEmpty
                || application.companyName.localizedCaseInsensitiveContains(trimmedSearchText)
                || application.roleTitle.localizedCaseInsensitiveContains(trimmedSearchText)

            return matchesStatus && matchesSearch
        }
    }

    private func deleteApplications(at offsets: IndexSet) {
        for index in offsets {
            let application = filteredApplications[index]
            NotificationManager.shared.cancelFollowUpNotification(applicationID: application.id)
            modelContext.delete(application)
        }
    }
}

#Preview {
    ApplicationsListView()
        .modelContainer(for: InternshipApplication.self, inMemory: true)
}
