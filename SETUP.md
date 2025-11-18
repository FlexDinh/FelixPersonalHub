# Setup Instructions

## Important: Adding Files to Xcode Project

The Xcode project file (`project.pbxproj`) is a basic skeleton. You need to add all source files to the project in Xcode:

### Steps:

1. Open `FelixPersonalHub.xcodeproj` in Xcode
2. Right-click on the `FelixPersonalHub` folder in the Project Navigator
3. Select "Add Files to FelixPersonalHub..."
4. Navigate to and select the following folders/files (make sure "Create groups" is selected, not "Create folder references"):

**Folders to add:**
- `FelixPersonalHub/App/`
- `FelixPersonalHub/Features/`
- `FelixPersonalHub/Models/`
- `FelixPersonalHub/Services/`
- `FelixPersonalHub/Views/`
- `FelixPersonalHub/ViewModels/`
- `FelixPersonalHub/Utils/`
- `FelixPersonalHub/Resources/`

**Files to add:**
- `FelixPersonalHub/Info.plist`
- `FelixPersonalHub/Assets.xcassets/`

5. For the Core Data model:
   - Add `FelixPersonalHub/Models/CoreDataModel.xcdatamodeld/` to the project
   - Make sure it's added to the target

6. For Tests:
   - Add `Tests/FelixPersonalHubTests/` folder
   - Make sure test files are added to the test target

### Alternative: Use Xcode's "Add Files" Feature

1. In Xcode, go to File → Add Files to "FelixPersonalHub"...
2. Select the entire `FelixPersonalHub` directory
3. Make sure:
   - "Copy items if needed" is **unchecked** (files are already in place)
   - "Create groups" is **selected**
   - "Add to targets: FelixPersonalHub" is **checked**

## After Adding Files

1. Build the project (Cmd+B) to check for any missing imports or issues
2. Run the app (Cmd+R) to test
3. Run tests (Cmd+U) to verify unit tests pass

## Core Data Model

The Core Data model file is located at:
`FelixPersonalHub/Models/CoreDataModel.xcdatamodeld/CoreDataModel.xcdatamodel/contents`

In Xcode, this should appear as a visual data model editor. If it doesn't:
1. Select the `.xcdatamodeld` file
2. Xcode should show the visual editor
3. If not, you can edit the `contents` file directly (XML format)

## Localization

Localization files are in:
- `FelixPersonalHub/Resources/vi.lproj/Localizable.strings`
- `FelixPersonalHub/Resources/en.lproj/Localizable.strings`

Make sure these are added to the project and included in the app target.

## Seed Data

To generate seed data for development, temporarily add this to `FelixPersonalHubApp.swift` in the `body`:

```swift
var body: some Scene {
    WindowGroup {
        ContentView()
            .environment(\.managedObjectContext, persistenceService.container.viewContext)
            .environmentObject(persistenceService)
            .onAppear {
                // Remove this in production!
                let generator = SeedDataGenerator(persistenceService: persistenceService)
                generator.generateSeedData()
            }
    }
}
```

**Remember to remove this before production builds!**

## Troubleshooting

### "Cannot find type 'X' in scope"
- Make sure all Swift files are added to the target
- Check that imports are correct
- Clean build folder (Cmd+Shift+K) and rebuild

### Core Data errors
- Make sure the `.xcdatamodeld` file is added to the target
- Check that the model name in `PersistenceService.swift` matches the model file name

### Localization not working
- Verify `.strings` files are added to the project
- Check that they're included in the app target
- Ensure the correct locale is set in device/simulator settings

