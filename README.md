# Felix Personal Hub

A production-ready iOS app for personal productivity tracking, built with Swift 5.9+ and SwiftUI, targeting iOS 16+.

## ⚠️ Windows Users

**Xcode chỉ chạy trên macOS!** Nếu bạn dùng Windows, xem:
- **[QUICK_START_WINDOWS.md](QUICK_START_WINDOWS.md)** - Hướng dẫn nhanh
- **[WINDOWS_SETUP.md](WINDOWS_SETUP.md)** - Hướng dẫn chi tiết các options

**Tóm tắt options:**
- ✅ **GitHub Actions** (miễn phí) - Cho CI/CD
- ✅ **Cloud Mac** ($20-50/tháng) - Full development
- ✅ **Mac thật** ($600+) - Tốt nhất lâu dài

## Features

- **IELTS Progress Tracker**: Track listening, reading, writing, and speaking scores with flashcards and test history
- **HSK Progress Tracker**: Vocabulary flashcards, daily quizzes, and progress tracking
- **Graduation Tracker**: Monitor remaining courses, GPA, and graduation timeline
- **Sleep & Night Study Tracker**: Log sleep sessions, compute recovery scores, track night study with Pomodoro
- **Workout Tracker**: Record swim, cardio, and gym sessions
- **Finance Tracker**: Quick expense entry, categories, monthly reports, CSV export
- **Offline-First**: All data stored locally using Core Data
- **Local Notifications**: Reminders for study sessions, sleep, and workouts
- **Localization**: Vietnamese (default) and English support

## Architecture

- **MVVM**: ViewModels handle business logic and state management
- **SwiftUI**: Modern declarative UI framework
- **Core Data**: Local persistence with CloudKit-ready stubs
- **Combine/async-await**: For async operations
- **Dependency Injection**: Services injected via environment objects

## Project Structure

```
FelixPersonalHub/
├── App/
│   └── FelixPersonalHubApp.swift
├── Features/
│   └── Study/
│       ├── IELTSView.swift
│       ├── AddIELTSTestView.swift
│       ├── HSKView.swift
│       ├── HSKQuizView.swift
│       ├── FlashcardListView.swift
│       ├── AddFlashcardView.swift
│       └── FlashcardStudyView.swift
├── Models/
│   └── CoreDataModel.xcdatamodeld/
├── Services/
│   ├── PersistenceService.swift
│   ├── ProgressCalculator.swift
│   └── NotificationService.swift
├── Views/
│   ├── ContentView.swift
│   ├── OnboardingView.swift
│   ├── DashboardView.swift
│   ├── StudyView.swift
│   ├── HealthView.swift
│   ├── WorkoutView.swift
│   ├── FinanceView.swift
│   └── SettingsView.swift
├── ViewModels/
│   ├── DashboardViewModel.swift
│   ├── IELTSViewModel.swift
│   └── HSKViewModel.swift
└── Utils/
    └── SeedDataGenerator.swift
```

## Requirements

- Xcode 15.0+
- iOS 16.0+
- Swift 5.9+

## Setup & Build

### 1. Clone the Repository

```bash
git clone <repository-url>
cd FelixPersonalHub
```

### 2. Open in Xcode

```bash
open FelixPersonalHub.xcodeproj
```

### 3. Configure Signing

1. Select the project in Xcode
2. Go to "Signing & Capabilities"
3. Select your development team
4. Ensure bundle identifier is unique (currently: `com.felix.personalhub`)

### 4. Build & Run

```bash
# Using Xcode
# Press Cmd+R or click Run

# Or using command line
xcodebuild -scheme FelixPersonalHub -destination 'platform=iOS Simulator,name=iPhone 15' build
```

### 5. Run Tests

```bash
xcodebuild -scheme FelixPersonalHub -destination 'platform=iOS Simulator,name=iPhone 15' test
```

### 6. Generate Seed Data

To populate the app with sample data for development:

1. Open the app in Xcode
2. Add a call to `SeedDataGenerator` in `FelixPersonalHubApp.swift` (temporary, for dev only):

```swift
let generator = SeedDataGenerator(persistenceService: persistenceService)
generator.generateSeedData()
```

Or run it once from a view's `onAppear`:

```swift
.onAppear {
    let generator = SeedDataGenerator(persistenceService: persistenceService)
    generator.generateSeedData()
}
```

**Note**: Remove seed data generation before production builds.

## Sample Seed Data

The seed data generator creates:
- 2 IELTS test results
- 50 HSK flashcards (common words)
- 10 IELTS flashcards (academic vocabulary)
- 2 HSK quiz results
- 3 remaining courses (Bơi, Kỹ năng sống, Tự chọn 2)
- 5 sample expenses
- 1 sleep log entry

## Localization

The app defaults to Vietnamese (`vi`) with English (`en`) fallback. Localization files are located in:
- `Resources/vi.lproj/Localizable.strings`
- `Resources/en.lproj/Localizable.strings`

To add new strings:
1. Add to both localization files
2. Use `NSLocalizedString("key", comment: "")` in code

## Core Data Model

Entities:
- `User`: User preferences and goals
- `IELTSTest`: IELTS test results
- `Flashcard`: Flashcards for IELTS/HSK
- `HSKQuizResult`: HSK quiz results
- `Course`: Graduation courses
- `SleepLog`: Sleep tracking
- `NightStudySession`: Night study sessions
- `WorkoutSession`: Workout records
- `Expense`: Financial expenses

## CloudKit Sync (Future)

The app is prepared for CloudKit sync:
- Uses `NSPersistentCloudKitContainer`
- CloudKit container identifier can be enabled in `PersistenceService.swift`
- Uncomment the CloudKit options line to enable sync

## Notifications

Local notifications are scheduled for:
- Daily study reminders (evening, respecting excluded days)
- Sleep wind-down reminders

Permissions are requested during onboarding.

## Testing

Unit tests are located in `Tests/FelixPersonalHubTests/`:
- `ProgressCalculatorTests`: Tests progress calculation logic
- `PersistenceServiceTests`: Tests Core Data CRUD operations (in-memory store)

Run tests:
```bash
xcodebuild test -scheme FelixPersonalHub -destination 'platform=iOS Simulator,name=iPhone 15'
```

## CI/CD

A GitHub Actions workflow template is provided in `.github/workflows/ci.yml` (to be added in future commits) for:
- Building the project
- Running tests
- Code quality checks

## Deployment

### TestFlight

1. Archive the app in Xcode (Product → Archive)
2. Upload to App Store Connect
3. Add to TestFlight for beta testing

### App Store

1. Complete App Store Connect metadata
2. Submit for review
3. Ensure all required screenshots and descriptions are provided

## Next Steps

### Planned Features (Future Commits)

1. **Health Module** (Commit 4):
   - Sleep logging with recovery score calculation
   - Night study sessions with Pomodoro timer
   - Weekly trends visualization

2. **Workout Module** (Commit 5):
   - Session logging (swim, cardio, gym)
   - Distance/time/reps tracking
   - Weekly summaries

3. **Finance Module** (Commit 5):
   - Quick expense entry (one-tap UI)
   - Category management
   - Monthly summary charts
   - CSV export functionality

4. **Graduation Module** (Commit 5):
   - Course list with completion status
   - Grade entry
   - GPA calculation
   - Expected graduation date tracking

5. **Settings Module** (Commit 6):
   - User profile editing
   - Study free times configuration
   - Excluded days (Thursday & Sunday)
   - Notification preferences
   - Data backup/export

6. **Enhancements**:
   - CloudKit sync implementation
   - HealthKit integration (optional)
   - Analytics (privacy-focused)
   - Widget support
   - Apple Watch companion app

## Architecture Decisions

- **MVVM**: Separates UI from business logic, testable ViewModels
- **Core Data**: Native iOS persistence, CloudKit-ready
- **SwiftUI**: Modern, declarative UI framework
- **Offline-First**: All features work without internet
- **Dependency Injection**: Services injected via environment for testability

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new features
5. Submit a pull request

## License

[Add your license here]

## Contact

[Add contact information here]

---

**Version**: 1.0.0  
**Last Updated**: 2024  
**Minimum iOS**: 16.0  
**Swift Version**: 5.9+

