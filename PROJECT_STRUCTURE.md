# Project Structure

## File Organization

```
FelixPersonalHub/
├── FelixPersonalHub/
│   ├── App/
│   │   └── FelixPersonalHubApp.swift          # App entry point
│   │
│   ├── Features/
│   │   └── Study/
│   │       ├── IELTSView.swift                # IELTS main view
│   │       ├── AddIELTSTestView.swift         # Add test result form
│   │       ├── HSKView.swift                  # HSK main view
│   │       ├── HSKQuizView.swift              # Daily quiz interface
│   │       ├── FlashcardListView.swift        # Flashcard management
│   │       ├── AddFlashcardView.swift         # Create new flashcard
│   │       └── FlashcardStudyView.swift       # Study flashcards
│   │
│   ├── Models/
│   │   └── CoreDataModel.xcdatamodeld/        # Core Data model
│   │       └── CoreDataModel.xcdatamodel/
│   │           └── contents                    # Entity definitions
│   │
│   ├── Services/
│   │   ├── PersistenceService.swift           # Core Data operations
│   │   ├── ProgressCalculator.swift           # Progress calculations
│   │   └── NotificationService.swift          # Local notifications
│   │
│   ├── Views/
│   │   ├── ContentView.swift                  # Main tab view
│   │   ├── OnboardingView.swift              # First launch onboarding
│   │   ├── DashboardView.swift               # Dashboard screen
│   │   ├── StudyView.swift                    # Study module container
│   │   ├── HealthView.swift                  # Health stub (Commit 4)
│   │   ├── WorkoutView.swift                 # Workout stub (Commit 5)
│   │   ├── FinanceView.swift                 # Finance stub (Commit 5)
│   │   ├── SettingsView.swift                # Settings stub (Commit 6)
│   │   └── GraduationView.swift              # Graduation stub (Commit 5)
│   │
│   ├── ViewModels/
│   │   ├── DashboardViewModel.swift          # Dashboard logic
│   │   ├── IELTSViewModel.swift              # IELTS state management
│   │   └── HSKViewModel.swift                # HSK state management
│   │
│   ├── Utils/
│   │   ├── SeedDataGenerator.swift           # Dev seed data
│   │   └── String+Localized.swift            # Localization helper
│   │
│   ├── Resources/
│   │   ├── vi.lproj/
│   │   │   └── Localizable.strings            # Vietnamese strings
│   │   └── en.lproj/
│   │       └── Localizable.strings          # English strings
│   │
│   ├── Assets.xcassets/                       # App icons, colors
│   ├── Info.plist                            # App configuration
│   └── Preview Content/                       # SwiftUI preview assets
│
├── Tests/
│   └── FelixPersonalHubTests/
│       ├── ProgressCalculatorTests.swift      # Progress calc tests
│       └── PersistenceServiceTests.swift      # Core Data tests
│
├── .github/
│   └── workflows/
│       └── ci.yml                            # GitHub Actions CI
│
├── README.md                                  # Main documentation
├── SETUP.md                                   # Setup instructions
├── PROJECT_STRUCTURE.md                       # This file
└── .gitignore                                # Git ignore rules
```

## Commit Structure

### Commit 1: Project Scaffold ✅
- Xcode project setup
- Core Data model with all entities
- PersistenceService with CRUD operations
- Basic app structure

### Commit 2: Dashboard + Stub Views ✅
- Main tab navigation
- Onboarding flow
- Dashboard with progress cards
- Stub views for all modules

### Commit 3: Study Module ✅
- IELTS module:
  - Progress tracking
  - Test result logging
  - Flashcard system
- HSK module:
  - Vocabulary progress
  - Daily quiz (10 questions)
  - Flashcard system with SRS
- ViewModels for state management

### Commit 4: Health Module (Planned)
- Sleep logging
- Recovery score calculation
- Night study sessions
- Pomodoro timer

### Commit 5: Workout + Finance + Graduation (Planned)
- Workout session logging
- Expense tracking with CSV export
- Graduation course tracking

### Commit 6: Settings + Localization + Notifications (Planned)
- User settings
- Study schedule configuration
- Notification preferences
- Full localization

### Commit 7: Tests + CI + README ✅
- Unit tests
- CI workflow
- Complete documentation

## Core Data Entities

1. **User**: User preferences, goals, settings
2. **IELTSTest**: Test results with 4 skills
3. **Flashcard**: IELTS/HSK vocabulary cards
4. **HSKQuizResult**: Daily quiz scores
5. **Course**: Graduation requirements
6. **SleepLog**: Sleep tracking with recovery
7. **NightStudySession**: Study sessions with Pomodoro
8. **WorkoutSession**: Exercise records
9. **Expense**: Financial transactions

## Key Services

- **PersistenceService**: Core Data operations, singleton pattern
- **ProgressCalculator**: Static methods for progress calculations
- **NotificationService**: Local notification scheduling

## Architecture Patterns

- **MVVM**: ViewModels manage state, Views are declarative
- **Dependency Injection**: Services via @EnvironmentObject
- **Repository Pattern**: PersistenceService abstracts Core Data
- **Singleton**: PersistenceService.shared for app-wide access

## Localization

- Default: Vietnamese (vi)
- Fallback: English (en)
- Uses NSLocalizedString with .strings files
- Helper extension: `String.localized`

## Testing

- Unit tests for business logic (ProgressCalculator)
- Integration tests for Core Data (PersistenceService)
- In-memory store for test isolation

