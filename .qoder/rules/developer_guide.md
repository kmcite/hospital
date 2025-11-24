---
trigger: always_on
alwaysApply: true
---
# Dart MCP Tool
- use it for code modifications
# Architecture Rules

## Project Structure
- Follow **feature-first** structure.
- Each feature folder contains one `StatelessWidget` and its matching `Notifier` in the same file.
- Domain layer contains `models/` and `repositories/`.

## State Management
- Use **Notifier** and **NotifierProvider** from `/utils`.
- One-to-one relation between `StatelessWidget` and its `Notifier`.
- Never use `StatefulWidget` or `State`.

## Dependency Injection
- Use `Provider` and `ListenableProvider` in `main()` to inject repositories.
- Access dependencies using `context.of<T>()` everywhere.
- Repositories must never be created inside widgets or notifiers.

## Repositories
- Use **Collection** or **InMemoryCollection<T>** for data storage.
- Repositories live in `domain/repositories`.
- Repositories may communicate via `event_bus` for cross-cutting concerns.

## Models
- Models live in `domain/models`.
- Models extend `Model` from `/utils`.
- Models are plain data objects without business logic.

## Navigation
- Use the `navigator` utility for all navigation.
- Do not use Flutter’s `Navigator.of(context)` APIs.

## Event Bus
- Use `event_bus` only for communication between repositories.
- Do not use event bus for UI interaction.

## UI Rules
- UI must use `StatelessWidget` only.
- All logic lives in the `Notifier`.
- Build method stays declarative and clean.

## Notifier Rules
- Each feature has exactly one `Notifier`.
- Notifier accesses repositories using `context.of<T>()`.
- Notifier contains all logic for the feature.
- Notifier is disposed automatically by NotifierProvider.
