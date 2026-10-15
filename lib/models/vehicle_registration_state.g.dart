// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_registration_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VehicleRegistrationState _$VehicleRegistrationStateFromJson(
  Map<String, dynamic> json,
) => _VehicleRegistrationState(
  vehicle: json['vehicle'] == null
      ? null
      : Vehicle.fromJson(json['vehicle'] as Map<String, dynamic>),
  mileage: (json['mileage'] as num?)?.toDouble() ?? 0,
  extraFeatures:
      (json['extraFeatures'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  numberOfKeys: (json['numberOfKeys'] as num?)?.toInt() ?? 1,
  hasFinance: json['hasFinance'] as bool? ?? false,
  runningCondition: $enumDecodeNullable(
    _$RunningConditionEnumMap,
    json['runningCondition'],
  ),
  mechanicalIssues:
      (json['mechanicalIssues'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  exteriorPhotos:
      (json['exteriorPhotos'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  exteriorPhotosMap:
      (json['exteriorPhotosMap'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  interiorPhotos:
      (json['interiorPhotos'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  interiorPhotosMap:
      (json['interiorPhotosMap'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  damagePhotos:
      (json['damagePhotos'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  wheelsPhotosMap:
      (json['wheelsPhotosMap'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  tireCondition: json['tireCondition'] as String?,
  seatMaterial: json['seatMaterial'] as String?,
  seatMaterialConfirmed: json['seatMaterialConfirmed'] as bool? ?? false,
  paintworkMarks:
      (json['paintworkMarks'] as List<dynamic>?)
          ?.map((e) => PaintworkMark.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  paintworkConfirmed: json['paintworkConfirmed'] as bool? ?? false,
  brokenFittingsPhotos:
      (json['brokenFittingsPhotos'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  hasBrokenFittings: json['hasBrokenFittings'] as bool? ?? false,
  brokenFittingsConfirmed: json['brokenFittingsConfirmed'] as bool? ?? false,
  wheelDamageMap:
      (json['wheelDamageMap'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as bool),
      ) ??
      const {},
  wheelDamageConfirmed: json['wheelDamageConfirmed'] as bool? ?? false,
  hasToolPack: json['hasToolPack'] as bool? ?? false,
  toolPackConfirmed: json['toolPackConfirmed'] as bool? ?? false,
  hasLockingWheelNut: json['hasLockingWheelNut'] as bool? ?? false,
  lockingWheelNutConfirmed: json['lockingWheelNutConfirmed'] as bool? ?? false,
  damages:
      (json['damages'] as List<dynamic>?)
          ?.map((e) => DamageItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  serviceHistoryType: $enumDecodeNullable(
    _$ServiceHistoryTypeEnumMap,
    json['serviceHistoryType'],
  ),
  serviceDocuments:
      (json['serviceDocuments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  hasProofOfPurchase: json['hasProofOfPurchase'] as bool? ?? false,
  proofOfPurchaseConfirmed: json['proofOfPurchaseConfirmed'] as bool? ?? false,
  hasBeenSmokedIn: json['hasBeenSmokedIn'] as bool? ?? false,
  smokingConfirmed: json['smokingConfirmed'] as bool? ?? false,
  hasPrivatePlate: json['hasPrivatePlate'] as bool? ?? false,
  privatePlateConfirmed: json['privatePlateConfirmed'] as bool? ?? false,
  submissionStatus:
      $enumDecodeNullable(
        _$SubmissionStatusEnumMap,
        json['submissionStatus'],
      ) ??
      SubmissionStatus.draft,
  vehicleDetailsConfirmed: json['vehicleDetailsConfirmed'] as bool? ?? false,
  extraFeaturesConfirmed: json['extraFeaturesConfirmed'] as bool? ?? false,
  keysConfirmed: json['keysConfirmed'] as bool? ?? false,
  financeConfirmed: json['financeConfirmed'] as bool? ?? false,
  runningConditionConfirmed:
      json['runningConditionConfirmed'] as bool? ?? false,
  mechanicalIssuesConfirmed:
      json['mechanicalIssuesConfirmed'] as bool? ?? false,
  photosConfirmed: json['photosConfirmed'] as bool? ?? false,
  interiorPhotosConfirmed: json['interiorPhotosConfirmed'] as bool? ?? false,
  wheelsPhotosConfirmed: json['wheelsPhotosConfirmed'] as bool? ?? false,
  tireConditionConfirmed: json['tireConditionConfirmed'] as bool? ?? false,
  conditionDamageConfirmed: json['conditionDamageConfirmed'] as bool? ?? false,
  serviceHistoryConfirmed: json['serviceHistoryConfirmed'] as bool? ?? false,
);

Map<String, dynamic> _$VehicleRegistrationStateToJson(
  _VehicleRegistrationState instance,
) => <String, dynamic>{
  'vehicle': instance.vehicle,
  'mileage': instance.mileage,
  'extraFeatures': instance.extraFeatures,
  'numberOfKeys': instance.numberOfKeys,
  'hasFinance': instance.hasFinance,
  'runningCondition': _$RunningConditionEnumMap[instance.runningCondition],
  'mechanicalIssues': instance.mechanicalIssues,
  'exteriorPhotos': instance.exteriorPhotos,
  'exteriorPhotosMap': instance.exteriorPhotosMap,
  'interiorPhotos': instance.interiorPhotos,
  'interiorPhotosMap': instance.interiorPhotosMap,
  'damagePhotos': instance.damagePhotos,
  'wheelsPhotosMap': instance.wheelsPhotosMap,
  'tireCondition': instance.tireCondition,
  'seatMaterial': instance.seatMaterial,
  'seatMaterialConfirmed': instance.seatMaterialConfirmed,
  'paintworkMarks': instance.paintworkMarks,
  'paintworkConfirmed': instance.paintworkConfirmed,
  'brokenFittingsPhotos': instance.brokenFittingsPhotos,
  'hasBrokenFittings': instance.hasBrokenFittings,
  'brokenFittingsConfirmed': instance.brokenFittingsConfirmed,
  'wheelDamageMap': instance.wheelDamageMap,
  'wheelDamageConfirmed': instance.wheelDamageConfirmed,
  'hasToolPack': instance.hasToolPack,
  'toolPackConfirmed': instance.toolPackConfirmed,
  'hasLockingWheelNut': instance.hasLockingWheelNut,
  'lockingWheelNutConfirmed': instance.lockingWheelNutConfirmed,
  'damages': instance.damages,
  'serviceHistoryType':
      _$ServiceHistoryTypeEnumMap[instance.serviceHistoryType],
  'serviceDocuments': instance.serviceDocuments,
  'hasProofOfPurchase': instance.hasProofOfPurchase,
  'proofOfPurchaseConfirmed': instance.proofOfPurchaseConfirmed,
  'hasBeenSmokedIn': instance.hasBeenSmokedIn,
  'smokingConfirmed': instance.smokingConfirmed,
  'hasPrivatePlate': instance.hasPrivatePlate,
  'privatePlateConfirmed': instance.privatePlateConfirmed,
  'submissionStatus': _$SubmissionStatusEnumMap[instance.submissionStatus]!,
  'vehicleDetailsConfirmed': instance.vehicleDetailsConfirmed,
  'extraFeaturesConfirmed': instance.extraFeaturesConfirmed,
  'keysConfirmed': instance.keysConfirmed,
  'financeConfirmed': instance.financeConfirmed,
  'runningConditionConfirmed': instance.runningConditionConfirmed,
  'mechanicalIssuesConfirmed': instance.mechanicalIssuesConfirmed,
  'photosConfirmed': instance.photosConfirmed,
  'interiorPhotosConfirmed': instance.interiorPhotosConfirmed,
  'wheelsPhotosConfirmed': instance.wheelsPhotosConfirmed,
  'tireConditionConfirmed': instance.tireConditionConfirmed,
  'conditionDamageConfirmed': instance.conditionDamageConfirmed,
  'serviceHistoryConfirmed': instance.serviceHistoryConfirmed,
};

const _$RunningConditionEnumMap = {
  RunningCondition.startsAndDrivesSmoothly: 'startsAndDrivesSmoothly',
  RunningCondition.startsAndDrivesWithIssues: 'startsAndDrivesWithIssues',
  RunningCondition.doesNotStart: 'doesNotStart',
};

const _$ServiceHistoryTypeEnumMap = {
  ServiceHistoryType.full: 'full',
  ServiceHistoryType.partial: 'partial',
  ServiceHistoryType.none: 'none',
};

const _$SubmissionStatusEnumMap = {
  SubmissionStatus.draft: 'draft',
  SubmissionStatus.submitted: 'submitted',
  SubmissionStatus.underReview: 'underReview',
  SubmissionStatus.approved: 'approved',
  SubmissionStatus.rejected: 'rejected',
  SubmissionStatus.published: 'published',
};

_DamageItem _$DamageItemFromJson(Map<String, dynamic> json) => _DamageItem(
  id: json['id'] as String,
  type: json['type'] as String,
  location: json['location'] as String,
  description: json['description'] as String?,
  photoPath: json['photoPath'] as String?,
);

Map<String, dynamic> _$DamageItemToJson(_DamageItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'location': instance.location,
      'description': instance.description,
      'photoPath': instance.photoPath,
    };

_PaintworkMark _$PaintworkMarkFromJson(Map<String, dynamic> json) =>
    _PaintworkMark(
      id: json['id'] as String,
      view: json['view'] as String,
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      size: json['size'] as String,
    );

Map<String, dynamic> _$PaintworkMarkToJson(_PaintworkMark instance) =>
    <String, dynamic>{
      'id': instance.id,
      'view': instance.view,
      'x': instance.x,
      'y': instance.y,
      'size': instance.size,
    };
