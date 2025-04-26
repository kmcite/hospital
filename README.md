# Hospital Game

## Overview

This project is a hospital simulation game built using Flutter. The game allows players to manage a hospital by admitting patients, hiring doctors, managing resources, and ensuring the smooth operation of the facility. The game incorporates reactive state management, ObjectBox for data persistence, and a modular architecture for scalability.

---

## Project Structure

### Domain Layer

- **Models** (`/lib/domain/models/`):

  - Defines the core entities of the game, such as `Patient`, `Doctor`, `Resource`, and `Facility`.
  - Example:
    - `Patient` includes properties like `name`, `admissionTime`, `remainingTime`, `satisfaction`, and relationships with `Doctor` and `Symptom`.
    - `Facility` tracks hospital-level attributes like `waitingAreaBeds`, `admissionBeds`, `nursesCapacity`, and `doctorsCapacity`.

- **APIs/Repositories** (`/lib/domain/api/`):
  - Implements the repository pattern for data access and manipulation.
  - Example:
    - `DoctorsRepository` manages doctor-related operations like assigning doctors to patients.
    - `SettingsRepository` handles global settings like funds and dark mode preferences.

---

### UI Layer

- **Pages** (`/lib/ui/`):

  - Organized by feature, such as `admitted`, `waiting`, and `hospital`.
  - Example:
    - `AdmittedPatientsPage` displays a list of admitted patients and allows actions like discharge or referral.
    - `WaitingPatientsPage` shows patients waiting for admission and provides options to admit, refer, or discharge them.

- **Components**:
  - Reusable UI components like `FundsBadge`, `CharityBadge`, and `HospitalBanner`.

---

### Utils

- **Utility Functions** (`/lib/utils/`):
  - Contains helper functions and shared logic used across the application.

---

## Key Features

### Patient Management

- Patients are generated with attributes like urgency, satisfaction, and payment ability.
- Players can admit, refer, or discharge patients based on hospital resources.

### Resource Management

- Resources like beds, doctors, and equipment are tracked and updated in real-time.
- The `Facility` model defines the hospital's capacity for resources.

### Doctor Management

- Doctors can be hired, assigned to patients, or put on leave.
- The `DoctorsLounge` UI provides an overview of doctors' statuses.

### State Management

- Uses `states_rebuilder` for reactive state updates.
- Repositories provide a centralized way to access and manipulate state.

### Data Persistence

- ObjectBox is used for storing game data, including patients, doctors, and resources.
- Relationships between entities (e.g., `Patient` and `Doctor`) are managed using ObjectBox's `ToOne` and `ToMany` relations.

---

## Gameplay Flow

1. **Waiting Room**:

   - Patients arrive and wait for admission.
   - Players can admit patients if resources are available.

2. **Admitted Patients**:

   - Admitted patients are treated by doctors.
   - Players can discharge or refer patients based on their status.

3. **Resource Management**:

   - Players must manage resources like beds and staff to ensure smooth operations.

4. **Progression**:
   - Players earn points and funds based on successful treatments.
   - Funds can be used to hire doctors or upgrade the facility.

---

## Development Guidelines

### Coding Style

- **Variables, Functions, Methods**: camelCase
- **Classes, Interfaces, Enums**: PascalCase
- **Files**: snake_case (e.g., `admitted_patients_page.dart`)

### Architecture Patterns

- Repository pattern for data access.
- Separation of UI and business logic using mixins and blocs.

### State Management

- Reactive programming with `Injected<T>` from `states_rebuilder`.
- State updates are triggered through repository methods.

---

## Future Enhancements

- Add progression mechanics like hospital upgrades and new features.
- Enhance UI/UX with animations and sound effects.
- Implement offline save and resume functionality.

---

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK

### Installation

1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Run `flutter run` to start the application.

---

## Contributors

- DrAdn

---

## License

This project is licensed under the MIT License.
