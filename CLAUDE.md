# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Run Commands

```bash
# Run (photo validation requires the .env file with GEMINI_API_KEY)
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

**State Management**: Riverpod with `Notifier` pattern. All registration wizard state lives in a single `vehicleRegistrationProvider` (`lib/shared/providers/vehicle_registration_provider.dart`) backed by a freezed `VehicleRegistrationState`. Each wizard step calls methods on the notifier and sets a `*Confirmed` flag. Progress is derived from how many flags are true (10 steps total).

**Routing**: go_router with flat routes (no nesting). Routes defined in `lib/core/router/app_routes.dart`, router config in `app_router.dart`.

**Models**: Use freezed for immutable data classes (`lib/models/`). After editing model files, run build_runner. Generated files: `*.freezed.dart`, `*.g.dart`.

**Barrel exports**: Each layer has barrel files (`core.dart`, `shared.dart`, `models.dart`, `widgets.dart`). Import from barrels, not individual files.

**Feature Structure**: Each feature in `lib/features/<name>/` contains:
- `presentation/` — screens
- `providers/` — feature-specific Riverpod providers (if needed)
- `services/` — business logic (if needed)
- `widgets/` — feature-specific widgets

## Key Systems

**Registration Wizard Flow**: Splash → Vehicle Lookup → Dashboard (hub) → 10 steps (vehicle details, extra features, keys, finance, running condition, mechanical issues, exterior photos, interior photos, condition/damage, service history) → Review → Submission. The dashboard shows completion progress; each step navigates back to dashboard after confirming.

**Photo Capture Flow** (`lib/features/photos/`):
- `GuidedCaptureScreen` — camera preview with car silhouette overlay
- `VehicleDetectorService` — ML Kit object detection for real-time vehicle alignment
- `AngleValidatorService` — Gemini API (`gemini-2.5-flash`) validation of photo angle correctness
- 8 exterior photos at specific angles defined by `PhotoAngle` enum (`lib/models/photo_position.dart`)
- Interior photos and damage photos stored as `Map<String, String>` (positionId → filePath)

**Theme**: Custom design system in `lib/core/theme/`. Use `AppColors`, `AppSpacing`, `AppTypography` instead of raw values.

## Environment

Create `.env` file in project root:
```
GEMINI_API_KEY=your_api_key_here
```

## Language

UI strings are in Spanish. Keep new strings in Spanish to match.
