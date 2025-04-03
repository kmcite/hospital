# Hospital Project Architecture Guidelines

## Project Structure
- **Domain Layer**
  - **Models** (`/lib/domain/models/`)
    - Plain data classes representing business entities (e.g., `Patient`, `Doctor`, `Symptom`)
    - Use enum types for statuses and categories
    - Follow ObjectBox persistence patterns for database entities
  - **APIs/Repositories** (`/lib/domain/api/`)
    - Repository pattern for data access
    - Singleton instances (e.g., `final repository = Repository()`)
    - CRUD operations for entity management

- **UI Layer**
  - Place UI components in `/lib/ui/` directory
  - Group related UI components in subdirectories by feature
  - Feature organization (`/lib/ui/feature_name/`)
    - Pages organized by functional area (e.g., `waiting`, `admitted`, `hospital`)
    - Each page has its own file with naming convention `feature_page.dart`

- **Utils**
  - Place utility functions in `/lib/utils/`

## Coding Style & Naming Conventions
- **Variables, Functions, Methods**: camelCase
- **Classes, Interfaces, Enums**: PascalCase
- **Files**: snake_case (e.g., `feature_name_page.dart`)
- Maximum line length: 80 characters
- Group related files in feature-specific directories
- **UI Components**: `FeatureNamePage`
- **Business Logic Mixins**: `FeatureNameBloc`
- **Models**: PascalCase singular nouns (e.g., `Patient`, `Doctor`)
- **Methods**:
  - Action methods: verb-based names (e.g., `admit()`, `discharge()`)
  - Getters: noun-based names (e.g., `patients`, `admittedPatients`)

## Architecture Patterns
- Use mixin classes for shared functionality (e.g., `*Bloc` mixins)
- Follow repository pattern for data access
- Use dependency injection with `Injected<T>` pattern
- Create UI classes that extend the `UI` base class
- Separate business logic from UI components

## Flutter UI Patterns
- **Widget Structure**
  - Use custom ForUI components (e.g., `FScaffold`, `FButton`, `FHeader`)
  - Use `FScaffold` with `FHeader` for consistent layout
  - Consistent navigation with back buttons in nested pages
  - Create responsive layouts with `LayoutBuilder`
  - Use `GridView` for card-based layouts
  - Follow custom styling conventions (e.g., padding: `8.0`, `16.0`)
  - Use `Container` with `BoxDecoration` for custom cards/panels

- **Page Structure Example**:
  ```dart
  class FeaturePage extends UI with FeatureBloc {
    @override
    Widget build(BuildContext context) {
      return FScaffold(
        header: FHeader.nested(
          title: 'Feature Name',
          prefixActions: [FHeaderAction.back(onPress: navigator.back)],
        ),
        content: // Page content
      );
    }
  }
  ```

- **Business Logic**
  - Keep UI-related logic in bloc mixins
  - Use getter methods for computed properties
  - Action methods should be clear and focused on single responsibilities

- **Bloc Pattern Example**:
  ```dart
  mixin FeatureBloc {
    // State access
    Iterable<Entity> get entities => repository.getAll();

    // Actions
    void performAction(Entity entity) {
      repository.update(entity);
    }
  }
  ```

## State Management
- **Reactive Programming**
  - Use `Injected<T>` for reactive state from the `states_rebuilder` package
  - Access repositories through dependency injection
  - Use state objects for maintaining component state
  - Follow the established pattern for updating state
  - Repository classes provide state access and manipulation methods
  - Update models through repository methods, not directly
  - Use proper state notification after model updates

## Data Flow
- Access repositories through global instances (e.g., `patientsRepository`)
- Update models through repository methods, not directly
- Use proper state notification after model updates

## Testing
- Mock external dependencies
- Follow AAA pattern (Arrange, Act, Assert)
- Write tests using Jest

## Comments and Documentation
- Document public APIs and non-obvious implementations
- Use descriptive method names and comments for complex logic

## Error Handling
- Handle empty states explicitly (e.g., "No doctors available")
- Use appropriate error messages for user feedback
- Log errors before handling them
- Return `Result<T>` objects for operations that can fail
- Use `try-catch` blocks for external API calls

## Navigation
- Handle back navigation with `navigator.back`
- Call `navigator.back()` for returning to previous screens
- Call `navigator.to(NewPage())` for navigation
- Use the custom navigator singleton for navigation
