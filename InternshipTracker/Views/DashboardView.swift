//
//  DashboardView.swift
//  InternshipTracker
//

import SwiftData
import SwiftUI

struct DashboardView: View {
    @Query(sort: \InternshipApplication.createdAt, order: .reverse)
    private var applications: [InternshipApplication]

    @State private var showingForm = false

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                if activeApplications.isEmpty {
                    dashboardEmptyState
                        .padding()
                } else {
                    VStack(alignment: .leading, spacing: 20) {
                        statsGrid

                        applicationSection(
                            title: "Overdue Follow-ups",
                            emptyTitle: "Nothing overdue",
                            emptyDescription: "Follow-up reminders that pass their scheduled time will appear here.",
                            applications: overdueFollowUps
                        )

                        applicationSection(
                            title: "Upcoming Follow-ups",
                            emptyTitle: "No upcoming follow-ups",
                            emptyDescription: "Follow-ups in the next 7 days will appear here.",
                            applications: upcomingFollowUps
                        )
                    }
                    .padding()
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Dashboard")
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
        }
    }

    private var dashboardEmptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "briefcase")
                .font(.system(size: 52))
                .foregroundStyle(.tint)
                .padding(.top, 32)

            VStack(spacing: 8) {
                Text("Start tracking your search")
                    .font(.title3.weight(.semibold))

                Text("Add your first internship or junior job application to see dashboard stats and follow-up reminders.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            Button {
                showingForm = true
            } label: {
                Label("Add Application", systemImage: "plus")
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }

    private var statsGrid: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            DashboardStatCard(
                title: "Active",
                value: activeApplications.count,
                systemImage: "tray.full",
                color: .blue
            )

            DashboardStatCard(
                title: "Applied",
                value: count(for: .applied),
                systemImage: ApplicationStatus.applied.systemImage,
                color: .blue
            )

            DashboardStatCard(
                title: "Interview",
                value: count(for: .interview) + count(for: .technicalTest),
                systemImage: ApplicationStatus.interview.systemImage,
                color: .indigo
            )

            DashboardStatCard(
                title: "Offers",
                value: count(for: .offer) + count(for: .accepted),
                systemImage: ApplicationStatus.offer.systemImage,
                color: .orange
            )

            DashboardStatCard(
                title: "Rejected",
                value: count(for: .rejected),
                systemImage: ApplicationStatus.rejected.systemImage,
                color: .red
            )

            DashboardStatCard(
                title: "Follow-ups",
                value: upcomingFollowUps.count,
                systemImage: "bell.badge",
                color: .teal
            )

            DashboardStatCard(
                title: "Overdue",
                value: overdueFollowUps.count,
                systemImage: "exclamationmark.triangle",
                color: .red
            )
        }
    }

    private func applicationSection(
        title: String,
        emptyTitle: String,
        emptyDescription: String,
        applications: [InternshipApplication]
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)

            if applications.isEmpty {
                ContentUnavailableView(
                    emptyTitle,
                    systemImage: "checkmark.circle",
                    description: Text(emptyDescription)
                )
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
            } else {
                ForEach(applications) { application in
                    NavigationLink {
                        ApplicationDetailView(application: application)
                    } label: {
                        ApplicationRowView(application: application)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.background, in: RoundedRectangle(cornerRadius: 8))
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.separator.opacity(0.25), lineWidth: 1)
                            }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var activeApplications: [InternshipApplication] {
        applications.filter { $0.status != .archived }
    }

    private var upcomingFollowUps: [InternshipApplication] {
        activeApplications
            .filter { application in
                application.followUpDate?.isUpcomingInNextSevenDays == true
            }
            .sorted { first, second in
                (first.followUpDate ?? .distantFuture) < (second.followUpDate ?? .distantFuture)
            }
    }

    private var overdueFollowUps: [InternshipApplication] {
        activeApplications.filter { application in
            application.followUpDate?.isPastDue == true
        }
    }

    private func count(for status: ApplicationStatus) -> Int {
        activeApplications.filter { $0.status == status }.count
    }
}

#Preview {
    DashboardView()
        .modelContainer(PreviewData.previewContainer)
}
