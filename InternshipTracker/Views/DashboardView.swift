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
                VStack(alignment: .leading, spacing: 20) {
                    LazyVGrid(columns: columns, spacing: 12) {
                        DashboardStatCard(
                            title: "Total",
                            value: applications.count,
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
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Needs Attention")
                            .font(.headline)

                        if upcomingFollowUps.isEmpty {
                            ContentUnavailableView(
                                "No upcoming follow-ups",
                                systemImage: "checkmark.circle",
                                description: Text("Applications with follow-up reminders in the next 7 days will appear here.")
                            )
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                        } else {
                            ForEach(upcomingFollowUps) { application in
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
                .padding()
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

    private var upcomingFollowUps: [InternshipApplication] {
        applications
            .filter { application in
                application.followUpDate?.isInNextSevenDays == true
            }
            .sorted { first, second in
                (first.followUpDate ?? .distantFuture) < (second.followUpDate ?? .distantFuture)
            }
    }

    private func count(for status: ApplicationStatus) -> Int {
        applications.filter { $0.status == status }.count
    }
}

#Preview {
    DashboardView()
        .modelContainer(for: InternshipApplication.self, inMemory: true)
}
