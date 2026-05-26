# Test Checklist

Use this checklist after Codex implements the app.

## Build

- [ ] App builds without compiler errors.
- [ ] No missing imports.
- [ ] SwiftData model container works.
- [ ] App launches on simulator.

## Create

- [ ] User can add an application.
- [ ] Company name validation works.
- [ ] Role title validation works.
- [ ] Optional fields can be empty.
- [ ] Created application appears in list.

## Read

- [ ] Applications list shows saved data.
- [ ] Detail screen opens correctly.
- [ ] URL link displays safely if available.
- [ ] Notes display correctly.

## Update

- [ ] User can edit an application.
- [ ] Edited data persists after app restart.
- [ ] Updated date changes.

## Delete

- [ ] User can delete an application.
- [ ] Deleted application disappears from list.
- [ ] Related notification is cancelled if applicable.

## Search/filter

- [ ] Search by company works.
- [ ] Search by role works.
- [ ] Status filter works.
- [ ] Search and status filter work together.

## Dashboard

- [ ] Total count is correct.
- [ ] Applied count is correct.
- [ ] Interview count is correct.
- [ ] Offer/Accepted count is correct.
- [ ] Rejected count is correct.
- [ ] Upcoming follow-up count is correct.

## Notifications

- [ ] Permission is requested only when needed.
- [ ] Follow-up notification can be scheduled.
- [ ] Notification updates when follow-up date changes.
- [ ] Notification is cancelled when follow-up date is removed.

## UI

- [ ] Light mode looks good.
- [ ] Dark mode looks good.
- [ ] Empty state appears when there are no applications.
- [ ] App is usable on smaller iPhone simulator.
