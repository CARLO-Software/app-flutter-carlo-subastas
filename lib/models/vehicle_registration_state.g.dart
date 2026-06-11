// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_registration_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VehicleRegistrationStateImpl _$$VehicleRegistrationStateImplFromJson(
  Map<String, dynamic> json,
) => _$VehicleRegistrationStateImpl(
  vehicle: json['vehicle'] == null
      ? null
      : Vehicle.fromJson(json['vehicle'] as Map<String, dynamic>),
  mileage: (json['mileage'] as num?)?.toInt() ?? 0,
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
  interiorPhotos:
      (json['interiorPhotos'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  damagePhotos:
      (json['damagePhotos'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
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
  conditionDamageConfirmed: json['conditionDamageConfirmed'] as bool? ?? false,
  serviceHistoryConfirmed: json['serviceHistoryConfirmed'] as bool? ?? false,
);

Map<String, dynamic> _$$VehicleRegistrationStateImplToJson(
  _$VehicleRegistrationStateImpl instance,
) => <String, dynamic>{
  'vehicle': instance.vehicle,
  'mileage': instance.mileage,
  'extraFeatures': instance.extraFeatures,
  'numberOfKeys': instance.numberOfKeys,
  'hasFinance': instance.hasFinance,
  'runningCondition': _$RunningConditionEnumMap[instance.runningCondition],
  'mechanicalIssues': instance.mechanicalIssues,
  'exteriorPhotos': instance.exteriorPhotos,
  'interiorPhotos': instance.interiorPhotos,
  'damagePhotos': instance.damagePhotos,
  'damages': instance.damages,
  'serviceHistoryType':
      _$ServiceHistoryTypeEnumMap[instance.serviceHistoryType],
  'serviceDocuments': instance.serviceDocuments,
  'submissionStatus': _$SubmissionStatusEnumMap[instance.submissionStatus]!,
  'vehicleDetailsConfirmed': instance.vehicleDetailsConfirmed,
  'extraFeaturesConfirmed': instance.extraFeaturesConfirmed,
  'keysConfirmed': instance.keysConfirmed,
  'financeConfirmed': instance.financeConfirmed,
  'runningConditionConfirmed': instance.runningConditionConfirmed,
  'mechanicalIssuesConfirmed': instance.mechanicalIssuesConfirmed,
  'photosConfirmed': instance.photosConfirmed,
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

_$DamageItemImpl _$$DamageItemImplFromJson(Map<String, dynamic> json) =>
    _$DamageItemImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      location: json['location'] as String,
      description: json['description'] as String?,
      photoPath: json['photoPath'] as String?,
    );

Map<String, dynamic> _$$DamageItemImplToJson(_$DamageItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'location': instance.location,
      'description': instance.description,
      'photoPath': instance.photoPath,
    };
