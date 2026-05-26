# Implementation Plan for Codex

## Phase 1 – Project foundation

Create folders:

```text
Models/
Views/
Components/
Services/
Utilities/
```

Create:

- `InternshipTrackerApp.swift`
- SwiftData model container setup
- Main `ContentView` with `TabView`

## Phase 2 – Models

Create:

- `InternshipApplication.swift`
- `ApplicationStatus.swift`
- `WorkMode.swift`

## Phase 3 – List and form

Create:

- `ApplicationsListView.swift`
- `ApplicationRowView.swift`
- `ApplicationFormView.swift`

Implement add, edit, delete.

## Phase 4 – Detail view

Create:

- `ApplicationDetailView.swift`
- Reusable detail rows if useful

## Phase 5 – Dashboard

Create:

- `DashboardView.swift`
- `DashboardStatCard.swift`

Compute stats from `@Query`.

## Phase 6 – Search and filter

Add:

- `.searchable`
- Status picker
- Filtering logic
- Sorting logic

## Phase 7 – Local notifications

Create:

- `NotificationManager.swift`

Functions:

- request permission
- schedule follow-up notification
- cancel notification

## Phase 8 – polish

Add:

- Empty states
- Better status colors
- Preview sample data
- AboutView
- Accessibility labels where reasonable
