# Data Model

## Main SwiftData model

Model name: `InternshipApplication`

Suggested properties:

```swift
@Model
final class InternshipApplication {
    var id: UUID
    var companyName: String
    var roleTitle: String
    var statusRawValue: String
    var location: String
    var workModeRawValue: String
    var applicationURL: String
    var appliedDate: Date?
    var deadlineDate: Date?
    var followUpDate: Date?
    var contactName: String
    var contactEmail: String
    var notes: String
    var createdAt: Date
    var updatedAt: Date

    init(...)
}
```

## Status enum

```swift
enum ApplicationStatus: String, CaseIterable, Identifiable {
    case draft = "Draft"
    case applied = "Applied"
    case interview = "Interview"
    case technicalTest = "Technical Test"
    case offer = "Offer"
    case rejected = "Rejected"
    case accepted = "Accepted"
    case archived = "Archived"

    var id: String { rawValue }
}
```

## Work mode enum

```swift
enum WorkMode: String, CaseIterable, Identifiable {
    case onSite = "On-site"
    case hybrid = "Hybrid"
    case remote = "Remote"
    case unknown = "Unknown"

    var id: String { rawValue }
}
```

## Computed properties idea

If storing enums directly creates issues, store strings and use computed properties:

```swift
var status: ApplicationStatus {
    get { ApplicationStatus(rawValue: statusRawValue) ?? .draft }
    set { statusRawValue = newValue.rawValue }
}
```

## Validation rules

- `companyName.trimmingCharacters(in: .whitespacesAndNewlines)` must not be empty.
- `roleTitle.trimmingCharacters(in: .whitespacesAndNewlines)` must not be empty.
- URL can be optional/empty.
- Dates can be optional.
