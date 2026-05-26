//
//  AboutView.swift
//  InternshipTracker
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Label("InternshipTracker", systemImage: "briefcase")
                            .font(.title3.weight(.semibold))

                        Text("Keep your internship and junior job applications organized in one place.")
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }

                Section("What You Can Do") {
                    Label("Save applications", systemImage: "tray.and.arrow.down")
                    Label("Track each status", systemImage: "checklist")
                    Label("Set follow-up reminders", systemImage: "bell")
                    Label("Add notes, links, and contacts", systemImage: "square.and.pencil")
                }

                Section("Privacy") {
                    Text("Your application data stays on this device. You do not need an account to use the app.")
                }
            }
            .navigationTitle("About")
        }
    }
}

#Preview {
    AboutView()
}
