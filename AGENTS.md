# AGENTS.md – InternshipTracker Project Instructions

You are working on an iOS app named **InternshipTracker**.

## Developer level

The human developer is a beginner-intermediate SwiftUI learner. Write clean, readable, maintainable Swift code. Avoid unnecessary complexity.

## Main goal

Build a portfolio-quality SwiftUI application that helps students track internship and junior job applications.

## Technical stack

- SwiftUI
- SwiftData
- iOS 17+
- UserNotifications for local reminders
- No backend in MVP
- No third-party dependencies unless explicitly requested

## Coding style

- Prefer simple SwiftUI views.
- Use `NavigationStack`, `TabView`, `List`, `Form`, `.searchable`, `.toolbar`, and sheets where appropriate.
- Use SwiftData `@Model`, `@Query`, `@Environment(\.modelContext)`.
- Keep files small and organized.
- Use clear names. Do not create generic names like `Manager2`, `HelperNew`, `TestViewFinal`.
- Add comments only where they explain non-obvious logic.
- Keep UI clean and close to Apple Human Interface Guidelines.

## Architecture preference

Use a simple structure:

```text
InternshipTracker/
  InternshipTrackerApp.swift
  Models/
  Views/
  Components/
  Services/
  Utilities/
```

Do not over-engineer with repositories, protocols, factories, or complex dependency injection for the MVP.

## Data rules

The main model is `InternshipApplication`.

Avoid storing Swift enums directly in SwiftData if it creates migration or persistence issues. Prefer storing raw `String` values and exposing computed enum properties if necessary.

## MVP features

Implement these first:

1. Dashboard screen
2. Applications list screen
3. Add/Edit application form
4. Application detail screen
5. Status filtering
6. Search by company or role
7. SwiftData persistence
8. Optional local reminder date
9. Clean empty states

## Notification rules

- Ask notification permission only when the user enables or schedules a reminder, not immediately at launch.
- Local reminders should be cancellable or rescheduled when an application is edited/deleted.
- Use stable notification identifiers derived from the application ID.

## UI rules

- Use system colors and SF Symbols.
- Use semantic colors where possible.
- Support Light and Dark Mode.
- Avoid hardcoded massive padding or fixed screen sizes.
- Respect Dynamic Type as much as possible.
- Use simple cards for dashboard stats.

## Testing / quality

After implementation:

- Make sure the app builds.
- Make sure adding, editing, deleting applications works.
- Make sure filtering and search work together.
- Make sure empty states show correctly.
- Make sure previews compile when reasonable.

## Do not do this in MVP

- Do not add login.
- Do not add Firebase.
- Do not add CloudKit unless requested later.
- Do not add AI features yet.
- Do not create a complex onboarding flow.
- Do not add networking.
