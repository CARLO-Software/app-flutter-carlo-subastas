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

**Photo Capture** (`lib/features/photos/`): Two camera screen types:
- `GuidedCaptureScreen` — exterior photos with car silhouette overlay, ML Kit vehicle detection, and Gemini AI angle validation. 8 angles defined by `PhotoAngle` enum (`lib/models/photo_position.dart`). Uses landscape orientation.
- `OverlayCaptureScreen` — generic camera for interior, wheels, and damage photos. `overlayAsset` is optional (damage photos skip the overlay). Returns `Map<String, String>` (positionId → filePath).

Both screens wrap photo review in `InteractiveViewer` for pinch-to-zoom.

**Damage Locator** (`lib/features/condition_damage/presentation/damage_locator_screen.dart`): Interactive vehicle silhouette for marking damage locations. Flow: take damage photo → navigate to locator → tap zone on SVG silhouette → pick damage size → review. Uses `CustomPainter` with polygon hit-testing (`Path.contains()`) on SVG viewBox coordinates (2880×1620). Four views (frontal, rear, left side, right side) with per-view zoom via `Transform.scale` and inverse coordinate compensation for hit detection. Zone polygons are defined relative to real SVG path landmarks.

**Theme**: Custom design system in `lib/core/theme/`. Use `AppColors` for static colors, `AppSpacing` for layout constants, `AppTypography` for text styles. For theme-aware colors use `context.colors` extension (e.g., `context.colors.surface`, `context.colors.textPrimary`) — defined via `AdaptiveColors` in `app_colors.dart`.

## Environment

Create `.env` file in project root:
```
GEMINI_API_KEY=your_api_key_here
```

## Language

UI strings are in Spanish. Keep new strings in Spanish to match.
