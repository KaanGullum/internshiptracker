# Main Codex Prompt

I am building an iOS app called **InternshipTracker** with SwiftUI.

Please read the project instruction files in the root folder first:

- `AGENTS.md`
- `01_PRODUCT_BRIEF.md`
- `02_FEATURE_SPEC.md`
- `03_DATA_MODEL.md`
- `04_UI_FLOW.md`
- `05_IMPLEMENTATION_PLAN.md`
- `06_TEST_CHECKLIST.md`

Then implement the MVP version.

## App goal

InternshipTracker helps university students track internship and junior job applications. The app should feel useful, clean, and portfolio-ready.

## Technical requirements

- Use SwiftUI.
- Use SwiftData for local persistence.
- Target iOS 17+.
- Use `NavigationStack`, `TabView`, `List`, `Form`, `.searchable`, and SwiftUI-native patterns.
- Add local notification support for optional reminder dates using `UserNotifications`.
- Do not add Firebase, backend, login, or external packages.
- Keep the code understandable for a beginner-intermediate SwiftUI learner.

## Required MVP screens

### 1. DashboardView

Show simple statistics:

- Total applications
- Applied count
- Interview count
- Offer/Accepted count
- Rejected count
- Applications with upcoming follow-up dates
- A small “quick action” button to add a new application

### 2. ApplicationsListView

Show all applications in a list.

Features:

- Search by company name or role title.
- Filter by status.
- Sort by newest first or deadline/follow-up date when available.
- Empty state when there are no applications.
- Tapping an item opens detail view.
- Swipe delete or toolbar edit/delete support.

### 3. ApplicationDetailView

Show full details:

- Company name
- Role title
- Status
- Location
- Work mode
- Application URL
- Applied date
- Deadline date
- Follow-up date
- Contact person/email if available
- Notes
- Edit button

### 4. ApplicationFormView

Used for both adding and editing.

Fields:

- Company name
- Role title
- Status
- Location
- Work mode
- Application URL
- Applied date
- Deadline date
- Follow-up date
- Contact name
- Contact email
- Notes

Validation:

- Company name cannot be empty.
- Role title cannot be empty.
- URL may be empty, but if filled, it should be stored as a string and displayed safely.

### 5. Settings/AboutView

Simple screen explaining the app and version. Include a portfolio-friendly text like:
“Built with SwiftUI and SwiftData.”

## Data model

Create a SwiftData model named `InternshipApplication`.

Use simple stored properties. If enum persistence is risky, store raw strings and expose computed properties.

Suggested statuses:

- Draft
- Applied
- Interview
- Technical Test
- Offer
- Rejected
- Accepted
- Archived

Suggested work modes:

- On-site
- Hybrid
- Remote
- Unknown

## Notification behavior

If `followUpDate` exists, allow the app to schedule a local notification.

Notification title example:
“Follow up with [Company]”

Notification body example:
“Check your application for [Role].”

Ask for notification permission only when needed.

## UI design direction

- Clean student productivity style.
- Use cards for dashboard.
- Use status badges with system colors.
- Support dark mode.
- Avoid overcomplicated UI.
- Prefer native iOS feel.

## Deliverable

Please create or update all needed Swift files. Make sure the project builds successfully.

After coding, provide:

1. A short summary of what you implemented.
2. The file structure.
3. Any manual steps I need to do in Xcode.
4. Any known limitations.
