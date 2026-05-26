# InternshipTracker

InternshipTracker is a SwiftUI iOS app for students who want to track internship and junior job applications in one place.

## Features

- Dashboard statistics for total applications, active stages, offers, rejected applications, and follow-ups
- Searchable application list
- Status filtering
- Sorting by newest, deadline, or follow-up date
- Add, edit, and delete applications
- Detail screen with dates, notes, contact info, email links, and application links
- Optional local follow-up reminders
- Overdue follow-up tracking
- Local persistence with SwiftData
- Light and Dark Mode support

## Tech Stack

- SwiftUI
- SwiftData
- UserNotifications
- iOS 17+
- No backend or external dependencies

## Project Structure

```text
InternshipTracker/
  InternshipTrackerApp.swift
  Models/
  Views/
  Components/
  Services/
  Utilities/
```

The project intentionally keeps the MVP architecture simple and beginner-friendly. Views use SwiftUI directly, data is stored with SwiftData, and notification logic lives in a small service.

## Build

Open `InternshipTracker.xcodeproj` in Xcode and run the `InternshipTracker` scheme on an iOS 17+ simulator.
