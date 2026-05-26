//
//  DashboardStatCard.swift
//  InternshipTracker
//

import SwiftUI

struct DashboardStatCard: View {
    let title: String
    let value: Int
    let systemImage: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: systemImage)
                    .font(.title3)
                    .foregroundStyle(color)

                Spacer()

                Text(value.formatted())
                    .font(.title2.weight(.bold))
                    .monospacedDigit()
            }

            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.background, in: RoundedRectangle(cornerRadius: 8))
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(.separator.opacity(0.25), lineWidth: 1)
        }
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    DashboardStatCard(title: "Total", value: 12, systemImage: "tray.full", color: .blue)
        .padding()
        .background(Color(.systemGroupedBackground))
}
