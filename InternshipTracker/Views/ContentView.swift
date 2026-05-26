//
//  ContentView.swift
//  InternshipTracker
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "chart.bar")
                }

            ApplicationsListView()
                .tabItem {
                    Label("Applications", systemImage: "tray.full")
                }

            AboutView()
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(PreviewData.previewContainer)
}
