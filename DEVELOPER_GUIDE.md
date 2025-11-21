# Hospital Simulation Game - Developer Guide

This guide provides an overview of the project structure, architecture, and instructions for building and extending the hospital simulation game.

## Project Overview

This is a hospital simulation game built with Flutter where players manage patient admissions, staff, resources, and facility operations. The game allows players to:

- Manage patient admissions, referrals, and discharges
- Track and allocate hospital resources (beds, doctors, nurses, equipment)
- Hire and manage medical staff
- Progress through the game by earning funds and points to upgrade the hospital

## Technology Stack

- **Framework**: Flutter
- **Language**: Dart
- **State Management**: Rearch with NotifierProvider
- **Data Persistence**: In-memory collections (extensible to ObjectBox)
- **UI Components**: ForUI library
- **Architecture Pattern**: Repository pattern with layered architecture

## Project Structure

```
lib/
├── application/          # UI screens and features
│   ├── departments/      # Department-specific views
│   ├── main_menu/       # Main menu and settings
│   ├── patient_management/ # Patient CRUD operations
│   └── splash/          # Splash screen
├── domain/
│   ├── models/          # Core data models
│   └── repositories/    # Data access logic
└── utils/               # Helper classes and utilities
```

### Key Directories and Files

1. **`lib/application/`** - Contains all UI-related code organized by feature
   - `departments/` - Different hospital departments (reception, ward, pharmacy, etc.)
   - `main_menu/` - Main menu and game settings
   - `patient_management/` - Patient-related UI components

2. **`lib/domain/`** - Business logic and data models
   - `models/` - Data models (Patient, Staff, MedicalRecord, etc.)
   - `repositories/` - Data repositories (Games, SettingsRepository)

3. **`lib/utils/`** - Utility classes and helper functions
   - Collection management utilities
   - Navigation helpers
   - Context extensions

## Architecture

The project follows a layered architecture with clear separation of concerns:

### Domain Layer
- Contains business logic and data models
- Models extend the `Model` abstract class with an `id` property
- Uses repository pattern for data access

### Application Layer
- Contains UI components and feature implementations
- Uses state management with Rearch's NotifierProvider
- Organized by features/modules

### Utils Layer
- Provides common utilities and helper classes
- Implements collection management with `InMemoryCollection`
- Contains navigation and context utilities

## State Management

The project uses Rearch for state management with NotifierProvider:

1. **Notifiers** - Handle business logic and state
2. **NotifierProvider** - Provides notifiers to the widget tree
3. **Context Extensions** - Access dependencies and state through context

Example:
```dart
class StaffsNotifier extends Notifier {
  StaffsNotifier(super.context);

  late final Staffs staffs = context.of(); // Access repository
  
  List<StaffModel> listOfStaffs = [];
  
  Future<void> loadStaff() async {
    listOfStaffs = staffs.getAll(); // Load data
    notifyListeners(); // Notify UI
  }
}
```

## Data Management

The project uses in-memory collections for data storage:

1. **Models** - Extend `Model` with an `id` field
2. **Collections** - Extend `InMemoryCollection` for CRUD operations
3. **Repositories** - Provide domain-specific data access

Example model:
```dart
class PatientModel extends Model {
  @override
  PatientId id;
  final String name;
  final int age;
  final String gender;
  final DateTime registrationDate;
  
  PatientModel({
    this.id = 0,
    required this.name,
    required this.age,
    required this.gender,
    DateTime? registrationDate,
  }) : registrationDate = registrationDate ?? DateTime.now();
}
```

Example collection:
```dart
class Patients extends InMemoryCollection<PatientModel> {}
```

## Building the Project

### Prerequisites
- Flutter SDK (version 3.10.0 or higher)
- Dart SDK

### Setup Instructions
1. Clone the repository
2. Navigate to the project directory
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the application

### Dependencies
Key dependencies include:
- `forui` - UI component library
- `flutter_rearch` - State management
- `provider` - Dependency injection
- `uuid` - Unique ID generation
- `faker` - Test data generation

## Extending the Application

### Adding New Features

1. **Create a new feature module** in `lib/application/`
2. **Define data models** in `lib/domain/models/`
3. **Implement repositories** in `lib/domain/repositories/`
4. **Register dependencies** in `lib/main.dart`

### Adding New Departments

1. Create a new directory in `lib/application/departments/`
2. Implement department UI components
3. Add department logic in a notifier class
4. Register the department in the main navigation

### Adding New Data Models

1. Create a new model in `lib/domain/models/`
2. Extend the `Model` class
3. Create a corresponding collection class
4. Register the collection in `lib/main.dart`

### Customizing UI

The project uses the ForUI library for components. To customize:
1. Modify theme in `lib/application/application.dart`
2. Create custom widgets in feature directories
3. Use FTheme and FThemes for consistent styling

## Testing

Currently, the project has minimal testing infrastructure. To add tests:

1. Create test files in the `test/` directory
2. Use `flutter_test` for unit and widget tests
3. Mock dependencies using dependency injection

## Deployment

To build for different platforms:

1. **Android**: `flutter build apk`
2. **iOS**: `flutter build ios`
3. **Web**: `flutter build web`
4. **Desktop**: `flutter build windows` (or macos, linux)

## Future Improvements

1. **Persistence**: Implement ObjectBox for persistent storage
2. **Testing**: Add comprehensive unit and integration tests
3. **Performance**: Optimize UI rendering and state updates
4. **Features**: Add more hospital management capabilities

## Code Generation

Some commented code suggests plans for ObjectBox integration:
- Uncomment ObjectBox annotations in models
- Run `flutter pub run build_runner build` to generate required code

## Contributing

1. Fork the repository
2. Create a feature branch
3. Implement your changes
4. Write appropriate tests
5. Submit a pull request

## Troubleshooting

Common issues:
1. **Dependency issues**: Run `flutter pub get` to resolve
2. **Build errors**: Check Flutter SDK compatibility
3. **Runtime errors**: Verify model IDs are unique and properly initialized