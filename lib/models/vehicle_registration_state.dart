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
abstract class VehicleRegistrationState with _$VehicleRegistrationState {
  const factory VehicleRegistrationState({
    // Vehicle Information
    Vehicle? vehicle,
    @Default(0) double mileage,

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
    @Default({}) Map<String, String> exteriorPhotosMap,
    @Default([]) List<String> interiorPhotos,
    @Default({}) Map<String, String> interiorPhotosMap,
    @Default([]) List<String> damagePhotos,

    // Wheels Photos
    @Default({}) Map<String, String> wheelsPhotosMap,

    // Tire Photos
    @Default({}) Map<String, String> tirePhotosMap,
    @Default(false) bool tirePhotosConfirmed,

    // Tire Damage (which tires are damaged)
    @Default({}) Map<String, bool> tireDamageMap,

    // Tire Condition
    String? tireCondition,

    // Seat Material
    String? seatMaterial,
    @Default(false) bool seatMaterialConfirmed,

    // Paintwork Problems
    @Default([]) List<PaintworkMark> paintworkMarks,
    @Default(false) bool paintworkConfirmed,

    // Broken or Missing Fittings
    @Default([]) List<String> brokenFittingsPhotos,
    @Default([]) List<BrokenFittingMark> brokenFittingMarks,
    @Default(false) bool hasBrokenFittings,
    @Default(false) bool brokenFittingsConfirmed,

    // Wheel Damage
    @Default({}) Map<String, bool> wheelDamageMap,
    @Default(false) bool wheelDamageConfirmed,

    // Tool Pack
    @Default(false) bool hasToolPack,
    @Default(false) bool toolPackConfirmed,

    // Locking Wheel Nut
    @Default(false) bool hasLockingWheelNut,
    @Default(false) bool lockingWheelNutConfirmed,

    // Warning Lights
    @Default([]) List<String> warningLights,
    @Default(false) bool warningLightsConfirmed,

    // Condition & Damage
    @Default([]) List<DamageItem> damages,

    // Service History
    ServiceHistoryType? serviceHistoryType,
    @Default([]) List<String> serviceDocuments,

    // Proof of Purchase
    @Default(false) bool hasProofOfPurchase,
    @Default(false) bool proofOfPurchaseConfirmed,

    // Smoking
    @Default(false) bool hasBeenSmokedIn,
    @Default(false) bool smokingConfirmed,

    // Private Plate
    @Default(false) bool hasPrivatePlate,
    @Default(false) bool privatePlateConfirmed,

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
    @Default(false) bool interiorPhotosConfirmed,
    @Default(false) bool wheelsPhotosConfirmed,
    @Default(false) bool tireConditionConfirmed,
    @Default(false) bool conditionDamageConfirmed,
    @Default(false) bool serviceHistoryConfirmed,
  }) = _VehicleRegistrationState;

  factory VehicleRegistrationState.fromJson(Map<String, dynamic> json) =>
      _$VehicleRegistrationStateFromJson(json);
}

@freezed
abstract class DamageItem with _$DamageItem {
  const factory DamageItem({
    required String id,
    required String type,
    required String location,
    String? description,
    String? photoPath,
  }) = _DamageItem;

  factory DamageItem.fromJson(Map<String, dynamic> json) => _$DamageItemFromJson(json);
}

@freezed
abstract class PaintworkMark with _$PaintworkMark {
  const factory PaintworkMark({
    required String id,
    required String view,
    required double x,
    required double y,
    required String size,
  }) = _PaintworkMark;

  factory PaintworkMark.fromJson(Map<String, dynamic> json) => _$PaintworkMarkFromJson(json);
}

@freezed
abstract class BrokenFittingMark with _$BrokenFittingMark {
  const factory BrokenFittingMark({
    required String id,
    required String view,
    required double x,
    required double y,
    required String label,
    String? photoPath,
  }) = _BrokenFittingMark;

  factory BrokenFittingMark.fromJson(Map<String, dynamic> json) => _$BrokenFittingMarkFromJson(json);
}
