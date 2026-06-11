import 'package:freezed_annotation/freezed_annotation.dart';
import 'vehicle.dart';

part 'vehicle_registration_state.freezed.dart';
part 'vehicle_registration_state.g.dart';

enum SubmissionStatus {
  draft,
  submitted,
  underReview,
  approved,
  rejected,
  published,
}

enum RunningCondition {
  startsAndDrivesSmoothly,
  startsAndDrivesWithIssues,
  doesNotStart,
}

enum ServiceHistoryType {
  full,
  partial,
  none,
}

@freezed
class VehicleRegistrationState with _$VehicleRegistrationState {
  const factory VehicleRegistrationState({
    // Vehicle Information
    Vehicle? vehicle,
    @Default(0) int mileage,

    // Extra Features
    @Default([]) List<String> extraFeatures,

    // Keys
    @Default(1) int numberOfKeys,

    // Finance
    @Default(false) bool hasFinance,

    // Running Condition
    RunningCondition? runningCondition,

    // Mechanical Issues
    @Default([]) List<String> mechanicalIssues,

    // Photos
    @Default([]) List<String> exteriorPhotos,
    @Default([]) List<String> interiorPhotos,
    @Default([]) List<String> damagePhotos,

    // Condition & Damage
    @Default([]) List<DamageItem> damages,

    // Service History
    ServiceHistoryType? serviceHistoryType,
    @Default([]) List<String> serviceDocuments,

    // Submission
    @Default(SubmissionStatus.draft) SubmissionStatus submissionStatus,

    // Progress tracking
    @Default(false) bool vehicleDetailsConfirmed,
    @Default(false) bool extraFeaturesConfirmed,
    @Default(false) bool keysConfirmed,
    @Default(false) bool financeConfirmed,
    @Default(false) bool runningConditionConfirmed,
    @Default(false) bool mechanicalIssuesConfirmed,
    @Default(false) bool photosConfirmed,
    @Default(false) bool conditionDamageConfirmed,
    @Default(false) bool serviceHistoryConfirmed,
  }) = _VehicleRegistrationState;

  factory VehicleRegistrationState.fromJson(Map<String, dynamic> json) =>
      _$VehicleRegistrationStateFromJson(json);
}

@freezed
class DamageItem with _$DamageItem {
  const factory DamageItem({
    required String id,
    required String type,
    required String location,
    String? description,
    String? photoPath,
  }) = _DamageItem;

  factory DamageItem.fromJson(Map<String, dynamic> json) => _$DamageItemFromJson(json);
}
