# Feature Specification

## MVP Features

### Application tracking

Each application should include:

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
- Created date
- Updated date

### Status system

Statuses:

- Draft
- Applied
- Interview
- Technical Test
- Offer
- Rejected
- Accepted
- Archived

### Work mode

Work modes:

- On-site
- Hybrid
- Remote
- Unknown

### Dashboard

Dashboard cards:

- Total
- Applied
- Interview
- Offers
- Rejected
- Upcoming follow-ups

Optional section:

- “Needs attention” list for applications with follow-up dates in the next 7 days.

### List

The list must support:

- Search by company
- Search by role
- Filter by status
- Sort by newest first
- Delete application

### Detail screen

The detail screen should show all stored information in a readable layout.

If application URL exists, show a tappable Link.

### Add/Edit form

The form should be beginner-friendly:

- Sections
- Pickers
- DatePickers
- TextField/TextEditor
- Save and Cancel buttons
- Basic validation

### Local reminders

When a follow-up date is set:

- Ask for permission if not granted
- Schedule notification
- Reschedule notification if date changes
- Cancel notification if application is deleted or date removed

## Nice-to-have after MVP

Do not implement until MVP works:

- CSV export
- PDF summary
- iCloud sync
- Home screen widgets
- Interview preparation checklist
- Cover letter checklist
- App icon and launch screen polish
