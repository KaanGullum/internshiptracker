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
    @State private var sortOption: ApplicationSortOption = .newest
    @State private var showingForm = false
    @State private var showingDeleteError = false

    var body: some View {
        NavigationStack {
            Group {
                if applications.isEmpty {
                    ContentUnavailableView(
                        "No applications yet",
                        systemImage: "tray",
                        description: Text("Add your first internship or junior job application to start tracking.")
                    )
                } else {
                    VStack(spacing: 0) {
                        filterSortBar

                        if sortedApplications.isEmpty {
                            ContentUnavailableView(
                                "No matching applications",
                                systemImage: "magnifyingglass",
                                description: Text(emptyFilterDescription)
                            )
                        } else {
                            List {
                                ForEach(sortedApplications) { application in
                                    NavigationLink {
                                        ApplicationDetailView(application: application)
                                    } label: {
                                        ApplicationRowView(application: application)
                                    }
                                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                        if application.status != .archived {
                                            Button {
                                                archiveApplication(application)
                                            } label: {
                                                Label("Archive", systemImage: "archivebox")
                                            }
                                            .tint(.gray)
                                        }
                                    }
                                }
                                .onDelete(perform: deleteApplications)
                            }
                            .listStyle(.insetGrouped)
                        }
                    }
                }
            }
            .navigationTitle("Applications")
            .searchable(text: $searchText, prompt: "Search company or role")
            .toolbar {
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
            .alert("Could not update applications", isPresented: $showingDeleteError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Something went wrong while updating the selected application. Please try again.")
            }
        }
    }

    private var filterSortBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                Menu {
                    Picker("Status", selection: $selectedStatus) {
                        Text("Active").tag(ApplicationStatus?.none)

                        ForEach(ApplicationStatus.allCases) { status in
                            Text(status.rawValue).tag(Optional(status))
                        }
                    }
                } label: {
                    Label(selectedStatus?.rawValue ?? "Active", systemImage: "line.3.horizontal.decrease.circle")
                }
                .buttonStyle(.bordered)

                Menu {
                    Picker("Sort", selection: $sortOption) {
                        ForEach(ApplicationSortOption.allCases) { option in
                            Label(option.rawValue, systemImage: option.systemImage)
                                .tag(option)
                        }
                    }
                } label: {
                    Label(sortOption.rawValue, systemImage: sortOption.systemImage)
                }
                .buttonStyle(.bordered)

                Text("\(sortedApplications.count) shown")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .monospacedDigit()

                if hasActiveFilters {
                    Button {
                        clearFilters()
                    } label: {
                        Label("Clear", systemImage: "xmark.circle")
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
        .background(Color(.systemGroupedBackground))
    }

    private var filteredApplications: [InternshipApplication] {
        let trimmedSearchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        return applications.filter { application in
            let matchesStatus: Bool

            if let selectedStatus {
                matchesStatus = application.status == selectedStatus
            } else {
                matchesStatus = application.status != .archived
            }

            let matchesSearch = trimmedSearchText.isEmpty
                || application.companyName.localizedCaseInsensitiveContains(trimmedSearchText)
                || application.roleTitle.localizedCaseInsensitiveContains(trimmedSearchText)

            return matchesStatus && matchesSearch
        }
    }

    private var sortedApplications: [InternshipApplication] {
        filteredApplications.sorted { first, second in
            switch sortOption {
            case .newest:
                return first.createdAt > second.createdAt
            case .deadline:
                return compareOptionalDates(first.deadlineDate, second.deadlineDate, fallback: first.createdAt > second.createdAt)
            case .followUp:
                return compareOptionalDates(first.followUpDate, second.followUpDate, fallback: first.createdAt > second.createdAt)
            }
        }
    }

    private func deleteApplications(at offsets: IndexSet) {
        let applicationsToDelete = offsets.map { sortedApplications[$0] }

        for application in applicationsToDelete {
            modelContext.delete(application)
        }

        do {
            try modelContext.save()

            for application in applicationsToDelete {
                NotificationManager.shared.cancelFollowUpNotification(applicationID: application.id)
            }
        } catch {
            showingDeleteError = true
        }
    }

    private func archiveApplication(_ application: InternshipApplication) {
        application.status = .archived
        application.updatedAt = .now

        do {
            try modelContext.save()
            NotificationManager.shared.cancelFollowUpNotification(applicationID: application.id)
        } catch {
            showingDeleteError = true
        }
    }

    private var hasActiveFilters: Bool {
        !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            || selectedStatus != nil
            || sortOption != .newest
    }

    private var emptyFilterDescription: String {
        if selectedStatus == nil {
            "Archived applications are hidden by default. Clear filters or choose Archived to view them."
        } else {
            "Try changing the search text, status filter, or sort option."
        }
    }

    private func clearFilters() {
        searchText = ""
        selectedStatus = nil
        sortOption = .newest
    }

    private func compareOptionalDates(_ firstDate: Date?, _ secondDate: Date?, fallback: Bool) -> Bool {
        switch (firstDate, secondDate) {
        case let (firstDate?, secondDate?):
            return firstDate < secondDate
        case (.some, .none):
            return true
        case (.none, .some):
            return false
        case (.none, .none):
            return fallback
        }
    }
}

#Preview {
    ApplicationsListView()
        .modelContainer(PreviewData.previewContainer)
}
