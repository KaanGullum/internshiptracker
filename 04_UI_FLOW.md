# UI Flow

## App structure

Use `TabView` with three tabs:

1. Dashboard
2. Applications
3. About / Settings

## Navigation

Use `NavigationStack`.

### Dashboard tab

DashboardView

- Stats cards
- Upcoming follow-ups
- Add button opens ApplicationFormView sheet

### Applications tab

ApplicationsListView

- Search bar
- Status filter picker
- List of applications
- Add button
- Tap item -> ApplicationDetailView

### Application detail

ApplicationDetailView

- Shows all info
- Edit button opens ApplicationFormView
- Delete option

### Add/Edit form

ApplicationFormView

- Same form for create and edit
- Cancel button
- Save button
- Validation alert if company/role empty

## Suggested components

### StatusBadge

A small capsule showing the status.

### DashboardStatCard

A reusable card showing title, number, and SF Symbol.

### ApplicationRowView

Shows:

- Company
- Role
- Status badge
- Follow-up/deadline date if available

## Visual direction

- Clean and native
- Card-based dashboard
- System grouped background
- SF Symbols
- Good spacing
- Dark mode support
