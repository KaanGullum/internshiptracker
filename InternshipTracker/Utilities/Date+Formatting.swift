//
//  Date+Formatting.swift
//  InternshipTracker
//

import Foundation

extension Date {
    var applicationDateText: String {
        formatted(date: .abbreviated, time: .omitted)
    }

    var reminderDateText: String {
        formatted(date: .abbreviated, time: .shortened)
    }

    var isUpcomingInNextSevenDays: Bool {
        let now = Date()

        guard let sevenDaysFromNow = Calendar.current.date(byAdding: .day, value: 7, to: now) else {
            return false
        }

        return self >= now && self <= sevenDaysFromNow
    }

    var isPastDue: Bool {
        self < Date()
    }
}
