//
//  NotificationManager.swift
//  InternshipTracker
//

import Foundation
import UserNotifications

final class NotificationManager {
    static let shared = NotificationManager()

    private let notificationCenter = UNUserNotificationCenter.current()

    private init() { }

    func notificationIdentifier(for applicationID: UUID) -> String {
        "follow-up-\(applicationID.uuidString)"
    }

    func scheduleFollowUpNotification(
        applicationID: UUID,
        companyName: String,
        roleTitle: String,
        followUpDate: Date
    ) async -> Bool {
        cancelFollowUpNotification(applicationID: applicationID)

        guard followUpDate > Date() else {
            return false
        }

        guard await requestPermissionIfNeeded() else {
            return false
        }

        let content = UNMutableNotificationContent()
        content.title = "Follow up with \(companyName)"
        content.body = "Check in about your \(roleTitle) application."
        content.sound = .default

        let dateComponents = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: followUpDate
        )
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(
            identifier: notificationIdentifier(for: applicationID),
            content: content,
            trigger: trigger
        )

        do {
            try await notificationCenter.add(request)
            return true
        } catch {
            return false
        }
    }

    func cancelFollowUpNotification(applicationID: UUID) {
        let identifier = notificationIdentifier(for: applicationID)
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.removeDeliveredNotifications(withIdentifiers: [identifier])
    }

    func permissionStatusDescription() async -> String {
        let settings = await notificationCenter.notificationSettings()

        switch settings.authorizationStatus {
        case .authorized, .provisional, .ephemeral:
            return "Reminders are allowed"
        case .notDetermined:
            return "Reminders are not set up yet"
        case .denied:
            return "Reminders are turned off"
        @unknown default:
            return "Reminder status is unavailable"
        }
    }

    private func requestPermissionIfNeeded() async -> Bool {
        let settings = await notificationCenter.notificationSettings()

        switch settings.authorizationStatus {
        case .authorized, .provisional, .ephemeral:
            return true
        case .notDetermined:
            do {
                return try await notificationCenter.requestAuthorization(options: [.alert, .sound, .badge])
            } catch {
                return false
            }
        case .denied:
            return false
        @unknown default:
            return false
        }
    }
}
