# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Run Commands

```bash
# Run on connected device/emulator
flutter run

# Run with Gemini API key (required for photo validation)
flutter run --dart-define-from-file=.env

# Code generation (after modifying freezed/json_serializable models)
dart run build_runner build --delete-conflicting-outputs

# Analyze
flutter analyze

# Run tests
flutter test

# Single test file
flutter test test/widget_test.dart
```

## Architecture

**State Management**: Riverpod with `Notifier` pattern. Central state lives in `vehicleRegistrationProvider` (`lib/shared/providers/vehicle_registration_provider.dart`).

**Routing**: go_router. Routes defined in `lib/core/router/app_routes.dart`, router config in `app_router.dart`.

**Models**: Use freezed for immutable data classes. After editing `*.dart` model files, run build_runner.

**Feature Structure**: Each feature in `lib/features/<name>/` contains:
- `presentation/` — screens
- `providers/` — feature-specific Riverpod providers (if needed)
- `services/` — business logic (if needed)
- `widgets/` — feature-specific widgets

## Key Systems

**Photo Capture Flow** (`lib/features/photos/`):
- `GuidedCaptureScreen` — camera preview with overlay
- `VehicleDetectorService` — ML Kit object detection for real-time vehicle alignment
- `AngleValidatorService` — Gemini API validation of photo angle correctness
- Requires 8 exterior photos at specific angles (front, rear, sides, corners)

**Theme**: Custom design system in `lib/core/theme/`. Use `AppColors`, `AppSpacing`, `AppTypography` instead of raw values.

## Environment

Create `.env` file in project root:
```
GEMINI_API_KEY=your_api_key_here
```

## Language

UI strings are in Spanish. Keep new strings in Spanish to match.
