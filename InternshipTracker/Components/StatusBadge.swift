//
//  StatusBadge.swift
//  InternshipTracker
//

import SwiftUI

struct StatusBadge: View {
    let status: ApplicationStatus

    var body: some View {
        Label(status.rawValue, systemImage: status.systemImage)
            .font(.caption.weight(.semibold))
            .lineLimit(1)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .foregroundStyle(status.tintColor)
            .background(status.tintColor.opacity(0.14), in: Capsule())
            .accessibilityLabel("Status: \(status.rawValue)")
    }
}

private extension ApplicationStatus {
    var tintColor: Color {
        switch self {
        case .draft:
            .secondary
        case .applied:
            .blue
        case .interview:
            .indigo
        case .technicalTest:
            .teal
        case .offer:
            .orange
        case .rejected:
            .red
        case .accepted:
            .green
        case .archived:
            .gray
        }
    }
}

#Preview {
    VStack(alignment: .leading) {
        ForEach(ApplicationStatus.allCases) { status in
            StatusBadge(status: status)
        }
    }
    .padding()
}
