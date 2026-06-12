// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle_registration_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

VehicleRegistrationState _$VehicleRegistrationStateFromJson(
  Map<String, dynamic> json,
) {
  return _VehicleRegistrationState.fromJson(json);
}

/// @nodoc
mixin _$VehicleRegistrationState {
  // Vehicle Information
  Vehicle? get vehicle => throw _privateConstructorUsedError;
  int get mileage => throw _privateConstructorUsedError; // Extra Features
  List<String> get extraFeatures => throw _privateConstructorUsedError; // Keys
  int get numberOfKeys => throw _privateConstructorUsedError; // Finance
  bool get hasFinance =>
      throw _privateConstructorUsedError; // Running Condition
  RunningCondition? get runningCondition =>
      throw _privateConstructorUsedError; // Mechanical Issues
  List<String> get mechanicalIssues =>
      throw _privateConstructorUsedError; // Photos
  List<String> get exteriorPhotos => throw _privateConstructorUsedError;
  Map<String, String> get exteriorPhotosMap =>
      throw _privateConstructorUsedError;
  List<String> get interiorPhotos => throw _privateConstructorUsedError;
  List<String> get damagePhotos =>
      throw _privateConstructorUsedError; // Condition & Damage
  List<DamageItem> get damages =>
      throw _privateConstructorUsedError; // Service History
  ServiceHistoryType? get serviceHistoryType =>
      throw _privateConstructorUsedError;
  List<String> get serviceDocuments =>
      throw _privateConstructorUsedError; // Submission
  SubmissionStatus get submissionStatus =>
      throw _privateConstructorUsedError; // Progress tracking
  bool get vehicleDetailsConfirmed => throw _privateConstructorUsedError;
  bool get extraFeaturesConfirmed => throw _privateConstructorUsedError;
  bool get keysConfirmed => throw _privateConstructorUsedError;
  bool get financeConfirmed => throw _privateConstructorUsedError;
  bool get runningConditionConfirmed => throw _privateConstructorUsedError;
  bool get mechanicalIssuesConfirmed => throw _privateConstructorUsedError;
  bool get photosConfirmed => throw _privateConstructorUsedError;
  bool get conditionDamageConfirmed => throw _privateConstructorUsedError;
  bool get serviceHistoryConfirmed => throw _privateConstructorUsedError;

  /// Serializes this VehicleRegistrationState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VehicleRegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VehicleRegistrationStateCopyWith<VehicleRegistrationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VehicleRegistrationStateCopyWith<$Res> {
  factory $VehicleRegistrationStateCopyWith(
    VehicleRegistrationState value,
    $Res Function(VehicleRegistrationState) then,
  ) = _$VehicleRegistrationStateCopyWithImpl<$Res, VehicleRegistrationState>;
  @useResult
  $Res call({
    Vehicle? vehicle,
    int mileage,
    List<String> extraFeatures,
    int numberOfKeys,
    bool hasFinance,
    RunningCondition? runningCondition,
    List<String> mechanicalIssues,
    List<String> exteriorPhotos,
    Map<String, String> exteriorPhotosMap,
    List<String> interiorPhotos,
    List<String> damagePhotos,
    List<DamageItem> damages,
    ServiceHistoryType? serviceHistoryType,
    List<String> serviceDocuments,
    SubmissionStatus submissionStatus,
    bool vehicleDetailsConfirmed,
    bool extraFeaturesConfirmed,
    bool keysConfirmed,
    bool financeConfirmed,
    bool runningConditionConfirmed,
    bool mechanicalIssuesConfirmed,
    bool photosConfirmed,
    bool conditionDamageConfirmed,
    bool serviceHistoryConfirmed,
  });

  $VehicleCopyWith<$Res>? get vehicle;
}

/// @nodoc
class _$VehicleRegistrationStateCopyWithImpl<
  $Res,
  $Val extends VehicleRegistrationState
>
    implements $VehicleRegistrationStateCopyWith<$Res> {
  _$VehicleRegistrationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VehicleRegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vehicle = freezed,
    Object? mileage = null,
    Object? extraFeatures = null,
    Object? numberOfKeys = null,
    Object? hasFinance = null,
    Object? runningCondition = freezed,
    Object? mechanicalIssues = null,
    Object? exteriorPhotos = null,
    Object? exteriorPhotosMap = null,
    Object? interiorPhotos = null,
    Object? damagePhotos = null,
    Object? damages = null,
    Object? serviceHistoryType = freezed,
    Object? serviceDocuments = null,
    Object? submissionStatus = null,
    Object? vehicleDetailsConfirmed = null,
    Object? extraFeaturesConfirmed = null,
    Object? keysConfirmed = null,
    Object? financeConfirmed = null,
    Object? runningConditionConfirmed = null,
    Object? mechanicalIssuesConfirmed = null,
    Object? photosConfirmed = null,
    Object? conditionDamageConfirmed = null,
    Object? serviceHistoryConfirmed = null,
  }) {
    return _then(
      _value.copyWith(
            vehicle: freezed == vehicle
                ? _value.vehicle
                : vehicle // ignore: cast_nullable_to_non_nullable
                      as Vehicle?,
            mileage: null == mileage
                ? _value.mileage
                : mileage // ignore: cast_nullable_to_non_nullable
                      as int,
            extraFeatures: null == extraFeatures
                ? _value.extraFeatures
                : extraFeatures // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            numberOfKeys: null == numberOfKeys
                ? _value.numberOfKeys
                : numberOfKeys // ignore: cast_nullable_to_non_nullable
                      as int,
            hasFinance: null == hasFinance
                ? _value.hasFinance
                : hasFinance // ignore: cast_nullable_to_non_nullable
                      as bool,
            runningCondition: freezed == runningCondition
                ? _value.runningCondition
                : runningCondition // ignore: cast_nullable_to_non_nullable
                      as RunningCondition?,
            mechanicalIssues: null == mechanicalIssues
                ? _value.mechanicalIssues
                : mechanicalIssues // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            exteriorPhotos: null == exteriorPhotos
                ? _value.exteriorPhotos
                : exteriorPhotos // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            exteriorPhotosMap: null == exteriorPhotosMap
                ? _value.exteriorPhotosMap
                : exteriorPhotosMap // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
            interiorPhotos: null == interiorPhotos
                ? _value.interiorPhotos
                : interiorPhotos // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            damagePhotos: null == damagePhotos
                ? _value.damagePhotos
                : damagePhotos // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            damages: null == damages
                ? _value.damages
                : damages // ignore: cast_nullable_to_non_nullable
                      as List<DamageItem>,
            serviceHistoryType: freezed == serviceHistoryType
                ? _value.serviceHistoryType
                : serviceHistoryType // ignore: cast_nullable_to_non_nullable
                      as ServiceHistoryType?,
            serviceDocuments: null == serviceDocuments
                ? _value.serviceDocuments
                : serviceDocuments // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            submissionStatus: null == submissionStatus
                ? _value.submissionStatus
                : submissionStatus // ignore: cast_nullable_to_non_nullable
                      as SubmissionStatus,
            vehicleDetailsConfirmed: null == vehicleDetailsConfirmed
                ? _value.vehicleDetailsConfirmed
                : vehicleDetailsConfirmed // ignore: cast_nullable_to_non_nullable
                      as bool,
            extraFeaturesConfirmed: null == extraFeaturesConfirmed
                ? _value.extraFeaturesConfirmed
                : extraFeaturesConfirmed // ignore: cast_nullable_to_non_nullable
                      as bool,
            keysConfirmed: null == keysConfirmed
                ? _value.keysConfirmed
                : keysConfirmed // ignore: cast_nullable_to_non_nullable
                      as bool,
            financeConfirmed: null == financeConfirmed
                ? _value.financeConfirmed
                : financeConfirmed // ignore: cast_nullable_to_non_nullable
                      as bool,
            runningConditionConfirmed: null == runningConditionConfirmed
                ? _value.runningConditionConfirmed
                : runningConditionConfirmed // ignore: cast_nullable_to_non_nullable
                      as bool,
            mechanicalIssuesConfirmed: null == mechanicalIssuesConfirmed
                ? _value.mechanicalIssuesConfirmed
                : mechanicalIssuesConfirmed // ignore: cast_nullable_to_non_nullable
                      as bool,
            photosConfirmed: null == photosConfirmed
                ? _value.photosConfirmed
                : photosConfirmed // ignore: cast_nullable_to_non_nullable
                      as bool,
            conditionDamageConfirmed: null == conditionDamageConfirmed
                ? _value.conditionDamageConfirmed
                : conditionDamageConfirmed // ignore: cast_nullable_to_non_nullable
                      as bool,
            serviceHistoryConfirmed: null == serviceHistoryConfirmed
                ? _value.serviceHistoryConfirmed
                : serviceHistoryConfirmed // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of VehicleRegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VehicleCopyWith<$Res>? get vehicle {
    if (_value.vehicle == null) {
      return null;
    }

    return $VehicleCopyWith<$Res>(_value.vehicle!, (value) {
      return _then(_value.copyWith(vehicle: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$VehicleRegistrationStateImplCopyWith<$Res>
    implements $VehicleRegistrationStateCopyWith<$Res> {
  factory _$$VehicleRegistrationStateImplCopyWith(
    _$VehicleRegistrationStateImpl value,
    $Res Function(_$VehicleRegistrationStateImpl) then,
  ) = __$$VehicleRegistrationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Vehicle? vehicle,
    int mileage,
    List<String> extraFeatures,
    int numberOfKeys,
    bool hasFinance,
    RunningCondition? runningCondition,
    List<String> mechanicalIssues,
    List<String> exteriorPhotos,
    Map<String, String> exteriorPhotosMap,
    List<String> interiorPhotos,
    List<String> damagePhotos,
    List<DamageItem> damages,
    ServiceHistoryType? serviceHistoryType,
    List<String> serviceDocuments,
    SubmissionStatus submissionStatus,
    bool vehicleDetailsConfirmed,
    bool extraFeaturesConfirmed,
    bool keysConfirmed,
    bool financeConfirmed,
    bool runningConditionConfirmed,
    bool mechanicalIssuesConfirmed,
    bool photosConfirmed,
    bool conditionDamageConfirmed,
    bool serviceHistoryConfirmed,
  });

  @override
  $VehicleCopyWith<$Res>? get vehicle;
}

/// @nodoc
class __$$VehicleRegistrationStateImplCopyWithImpl<$Res>
    extends
        _$VehicleRegistrationStateCopyWithImpl<
          $Res,
          _$VehicleRegistrationStateImpl
        >
    implements _$$VehicleRegistrationStateImplCopyWith<$Res> {
  __$$VehicleRegistrationStateImplCopyWithImpl(
    _$VehicleRegistrationStateImpl _value,
    $Res Function(_$VehicleRegistrationStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VehicleRegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vehicle = freezed,
    Object? mileage = null,
    Object? extraFeatures = null,
    Object? numberOfKeys = null,
    Object? hasFinance = null,
    Object? runningCondition = freezed,
    Object? mechanicalIssues = null,
    Object? exteriorPhotos = null,
    Object? exteriorPhotosMap = null,
    Object? interiorPhotos = null,
    Object? damagePhotos = null,
    Object? damages = null,
    Object? serviceHistoryType = freezed,
    Object? serviceDocuments = null,
    Object? submissionStatus = null,
    Object? vehicleDetailsConfirmed = null,
    Object? extraFeaturesConfirmed = null,
    Object? keysConfirmed = null,
    Object? financeConfirmed = null,
    Object? runningConditionConfirmed = null,
    Object? mechanicalIssuesConfirmed = null,
    Object? photosConfirmed = null,
    Object? conditionDamageConfirmed = null,
    Object? serviceHistoryConfirmed = null,
  }) {
    return _then(
      _$VehicleRegistrationStateImpl(
        vehicle: freezed == vehicle
            ? _value.vehicle
            : vehicle // ignore: cast_nullable_to_non_nullable
                  as Vehicle?,
        mileage: null == mileage
            ? _value.mileage
            : mileage // ignore: cast_nullable_to_non_nullable
                  as int,
        extraFeatures: null == extraFeatures
            ? _value._extraFeatures
            : extraFeatures // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        numberOfKeys: null == numberOfKeys
            ? _value.numberOfKeys
            : numberOfKeys // ignore: cast_nullable_to_non_nullable
                  as int,
        hasFinance: null == hasFinance
            ? _value.hasFinance
            : hasFinance // ignore: cast_nullable_to_non_nullable
                  as bool,
        runningCondition: freezed == runningCondition
            ? _value.runningCondition
            : runningCondition // ignore: cast_nullable_to_non_nullable
                  as RunningCondition?,
        mechanicalIssues: null == mechanicalIssues
            ? _value._mechanicalIssues
            : mechanicalIssues // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        exteriorPhotos: null == exteriorPhotos
            ? _value._exteriorPhotos
            : exteriorPhotos // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        exteriorPhotosMap: null == exteriorPhotosMap
            ? _value._exteriorPhotosMap
            : exteriorPhotosMap // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
        interiorPhotos: null == interiorPhotos
            ? _value._interiorPhotos
            : interiorPhotos // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        damagePhotos: null == damagePhotos
            ? _value._damagePhotos
            : damagePhotos // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        damages: null == damages
            ? _value._damages
            : damages // ignore: cast_nullable_to_non_nullable
                  as List<DamageItem>,
        serviceHistoryType: freezed == serviceHistoryType
            ? _value.serviceHistoryType
            : serviceHistoryType // ignore: cast_nullable_to_non_nullable
                  as ServiceHistoryType?,
        serviceDocuments: null == serviceDocuments
            ? _value._serviceDocuments
            : serviceDocuments // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        submissionStatus: null == submissionStatus
            ? _value.submissionStatus
            : submissionStatus // ignore: cast_nullable_to_non_nullable
                  as SubmissionStatus,
        vehicleDetailsConfirmed: null == vehicleDetailsConfirmed
            ? _value.vehicleDetailsConfirmed
            : vehicleDetailsConfirmed // ignore: cast_nullable_to_non_nullable
                  as bool,
        extraFeaturesConfirmed: null == extraFeaturesConfirmed
            ? _value.extraFeaturesConfirmed
            : extraFeaturesConfirmed // ignore: cast_nullable_to_non_nullable
                  as bool,
        keysConfirmed: null == keysConfirmed
            ? _value.keysConfirmed
            : keysConfirmed // ignore: cast_nullable_to_non_nullable
                  as bool,
        financeConfirmed: null == financeConfirmed
            ? _value.financeConfirmed
            : financeConfirmed // ignore: cast_nullable_to_non_nullable
                  as bool,
        runningConditionConfirmed: null == runningConditionConfirmed
            ? _value.runningConditionConfirmed
            : runningConditionConfirmed // ignore: cast_nullable_to_non_nullable
                  as bool,
        mechanicalIssuesConfirmed: null == mechanicalIssuesConfirmed
            ? _value.mechanicalIssuesConfirmed
            : mechanicalIssuesConfirmed // ignore: cast_nullable_to_non_nullable
                  as bool,
        photosConfirmed: null == photosConfirmed
            ? _value.photosConfirmed
            : photosConfirmed // ignore: cast_nullable_to_non_nullable
                  as bool,
        conditionDamageConfirmed: null == conditionDamageConfirmed
            ? _value.conditionDamageConfirmed
            : conditionDamageConfirmed // ignore: cast_nullable_to_non_nullable
                  as bool,
        serviceHistoryConfirmed: null == serviceHistoryConfirmed
            ? _value.serviceHistoryConfirmed
            : serviceHistoryConfirmed // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VehicleRegistrationStateImpl implements _VehicleRegistrationState {
  const _$VehicleRegistrationStateImpl({
    this.vehicle,
    this.mileage = 0,
    final List<String> extraFeatures = const [],
    this.numberOfKeys = 1,
    this.hasFinance = false,
    this.runningCondition,
    final List<String> mechanicalIssues = const [],
    final List<String> exteriorPhotos = const [],
    final Map<String, String> exteriorPhotosMap = const {},
    final List<String> interiorPhotos = const [],
    final List<String> damagePhotos = const [],
    final List<DamageItem> damages = const [],
    this.serviceHistoryType,
    final List<String> serviceDocuments = const [],
    this.submissionStatus = SubmissionStatus.draft,
    this.vehicleDetailsConfirmed = false,
    this.extraFeaturesConfirmed = false,
    this.keysConfirmed = false,
    this.financeConfirmed = false,
    this.runningConditionConfirmed = false,
    this.mechanicalIssuesConfirmed = false,
    this.photosConfirmed = false,
    this.conditionDamageConfirmed = false,
    this.serviceHistoryConfirmed = false,
  }) : _extraFeatures = extraFeatures,
       _mechanicalIssues = mechanicalIssues,
       _exteriorPhotos = exteriorPhotos,
       _exteriorPhotosMap = exteriorPhotosMap,
       _interiorPhotos = interiorPhotos,
       _damagePhotos = damagePhotos,
       _damages = damages,
       _serviceDocuments = serviceDocuments;

  factory _$VehicleRegistrationStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$VehicleRegistrationStateImplFromJson(json);

  // Vehicle Information
  @override
  final Vehicle? vehicle;
  @override
  @JsonKey()
  final int mileage;
  // Extra Features
  final List<String> _extraFeatures;
  // Extra Features
  @override
  @JsonKey()
  List<String> get extraFeatures {
    if (_extraFeatures is EqualUnmodifiableListView) return _extraFeatures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_extraFeatures);
  }

  // Keys
  @override
  @JsonKey()
  final int numberOfKeys;
  // Finance
  @override
  @JsonKey()
  final bool hasFinance;
  // Running Condition
  @override
  final RunningCondition? runningCondition;
  // Mechanical Issues
  final List<String> _mechanicalIssues;
  // Mechanical Issues
  @override
  @JsonKey()
  List<String> get mechanicalIssues {
    if (_mechanicalIssues is EqualUnmodifiableListView)
      return _mechanicalIssues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mechanicalIssues);
  }

  // Photos
  final List<String> _exteriorPhotos;
  // Photos
  @override
  @JsonKey()
  List<String> get exteriorPhotos {
    if (_exteriorPhotos is EqualUnmodifiableListView) return _exteriorPhotos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exteriorPhotos);
  }

  final Map<String, String> _exteriorPhotosMap;
  @override
  @JsonKey()
  Map<String, String> get exteriorPhotosMap {
    if (_exteriorPhotosMap is EqualUnmodifiableMapView)
      return _exteriorPhotosMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_exteriorPhotosMap);
  }

  final List<String> _interiorPhotos;
  @override
  @JsonKey()
  List<String> get interiorPhotos {
    if (_interiorPhotos is EqualUnmodifiableListView) return _interiorPhotos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interiorPhotos);
  }

  final List<String> _damagePhotos;
  @override
  @JsonKey()
  List<String> get damagePhotos {
    if (_damagePhotos is EqualUnmodifiableListView) return _damagePhotos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_damagePhotos);
  }

  // Condition & Damage
  final List<DamageItem> _damages;
  // Condition & Damage
  @override
  @JsonKey()
  List<DamageItem> get damages {
    if (_damages is EqualUnmodifiableListView) return _damages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_damages);
  }

  // Service History
  @override
  final ServiceHistoryType? serviceHistoryType;
  final List<String> _serviceDocuments;
  @override
  @JsonKey()
  List<String> get serviceDocuments {
    if (_serviceDocuments is EqualUnmodifiableListView)
      return _serviceDocuments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_serviceDocuments);
  }

  // Submission
  @override
  @JsonKey()
  final SubmissionStatus submissionStatus;
  // Progress tracking
  @override
  @JsonKey()
  final bool vehicleDetailsConfirmed;
  @override
  @JsonKey()
  final bool extraFeaturesConfirmed;
  @override
  @JsonKey()
  final bool keysConfirmed;
  @override
  @JsonKey()
  final bool financeConfirmed;
  @override
  @JsonKey()
  final bool runningConditionConfirmed;
  @override
  @JsonKey()
  final bool mechanicalIssuesConfirmed;
  @override
  @JsonKey()
  final bool photosConfirmed;
  @override
  @JsonKey()
  final bool conditionDamageConfirmed;
  @override
  @JsonKey()
  final bool serviceHistoryConfirmed;

  @override
  String toString() {
    return 'VehicleRegistrationState(vehicle: $vehicle, mileage: $mileage, extraFeatures: $extraFeatures, numberOfKeys: $numberOfKeys, hasFinance: $hasFinance, runningCondition: $runningCondition, mechanicalIssues: $mechanicalIssues, exteriorPhotos: $exteriorPhotos, exteriorPhotosMap: $exteriorPhotosMap, interiorPhotos: $interiorPhotos, damagePhotos: $damagePhotos, damages: $damages, serviceHistoryType: $serviceHistoryType, serviceDocuments: $serviceDocuments, submissionStatus: $submissionStatus, vehicleDetailsConfirmed: $vehicleDetailsConfirmed, extraFeaturesConfirmed: $extraFeaturesConfirmed, keysConfirmed: $keysConfirmed, financeConfirmed: $financeConfirmed, runningConditionConfirmed: $runningConditionConfirmed, mechanicalIssuesConfirmed: $mechanicalIssuesConfirmed, photosConfirmed: $photosConfirmed, conditionDamageConfirmed: $conditionDamageConfirmed, serviceHistoryConfirmed: $serviceHistoryConfirmed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VehicleRegistrationStateImpl &&
            (identical(other.vehicle, vehicle) || other.vehicle == vehicle) &&
            (identical(other.mileage, mileage) || other.mileage == mileage) &&
            const DeepCollectionEquality().equals(
              other._extraFeatures,
              _extraFeatures,
            ) &&
            (identical(other.numberOfKeys, numberOfKeys) ||
                other.numberOfKeys == numberOfKeys) &&
            (identical(other.hasFinance, hasFinance) ||
                other.hasFinance == hasFinance) &&
            (identical(other.runningCondition, runningCondition) ||
                other.runningCondition == runningCondition) &&
            const DeepCollectionEquality().equals(
              other._mechanicalIssues,
              _mechanicalIssues,
            ) &&
            const DeepCollectionEquality().equals(
              other._exteriorPhotos,
              _exteriorPhotos,
            ) &&
            const DeepCollectionEquality().equals(
              other._exteriorPhotosMap,
              _exteriorPhotosMap,
            ) &&
            const DeepCollectionEquality().equals(
              other._interiorPhotos,
              _interiorPhotos,
            ) &&
            const DeepCollectionEquality().equals(
              other._damagePhotos,
              _damagePhotos,
            ) &&
            const DeepCollectionEquality().equals(other._damages, _damages) &&
            (identical(other.serviceHistoryType, serviceHistoryType) ||
                other.serviceHistoryType == serviceHistoryType) &&
            const DeepCollectionEquality().equals(
              other._serviceDocuments,
              _serviceDocuments,
            ) &&
            (identical(other.submissionStatus, submissionStatus) ||
                other.submissionStatus == submissionStatus) &&
            (identical(
                  other.vehicleDetailsConfirmed,
                  vehicleDetailsConfirmed,
                ) ||
                other.vehicleDetailsConfirmed == vehicleDetailsConfirmed) &&
            (identical(other.extraFeaturesConfirmed, extraFeaturesConfirmed) ||
                other.extraFeaturesConfirmed == extraFeaturesConfirmed) &&
            (identical(other.keysConfirmed, keysConfirmed) ||
                other.keysConfirmed == keysConfirmed) &&
            (identical(other.financeConfirmed, financeConfirmed) ||
                other.financeConfirmed == financeConfirmed) &&
            (identical(
                  other.runningConditionConfirmed,
                  runningConditionConfirmed,
                ) ||
                other.runningConditionConfirmed == runningConditionConfirmed) &&
            (identical(
                  other.mechanicalIssuesConfirmed,
                  mechanicalIssuesConfirmed,
                ) ||
                other.mechanicalIssuesConfirmed == mechanicalIssuesConfirmed) &&
            (identical(other.photosConfirmed, photosConfirmed) ||
                other.photosConfirmed == photosConfirmed) &&
            (identical(
                  other.conditionDamageConfirmed,
                  conditionDamageConfirmed,
                ) ||
                other.conditionDamageConfirmed == conditionDamageConfirmed) &&
            (identical(
                  other.serviceHistoryConfirmed,
                  serviceHistoryConfirmed,
                ) ||
                other.serviceHistoryConfirmed == serviceHistoryConfirmed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    vehicle,
    mileage,
    const DeepCollectionEquality().hash(_extraFeatures),
    numberOfKeys,
    hasFinance,
    runningCondition,
    const DeepCollectionEquality().hash(_mechanicalIssues),
    const DeepCollectionEquality().hash(_exteriorPhotos),
    const DeepCollectionEquality().hash(_exteriorPhotosMap),
    const DeepCollectionEquality().hash(_interiorPhotos),
    const DeepCollectionEquality().hash(_damagePhotos),
    const DeepCollectionEquality().hash(_damages),
    serviceHistoryType,
    const DeepCollectionEquality().hash(_serviceDocuments),
    submissionStatus,
    vehicleDetailsConfirmed,
    extraFeaturesConfirmed,
    keysConfirmed,
    financeConfirmed,
    runningConditionConfirmed,
    mechanicalIssuesConfirmed,
    photosConfirmed,
    conditionDamageConfirmed,
    serviceHistoryConfirmed,
  ]);

  /// Create a copy of VehicleRegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VehicleRegistrationStateImplCopyWith<_$VehicleRegistrationStateImpl>
  get copyWith =>
      __$$VehicleRegistrationStateImplCopyWithImpl<
        _$VehicleRegistrationStateImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VehicleRegistrationStateImplToJson(this);
  }
}

abstract class _VehicleRegistrationState implements VehicleRegistrationState {
  const factory _VehicleRegistrationState({
    final Vehicle? vehicle,
    final int mileage,
    final List<String> extraFeatures,
    final int numberOfKeys,
    final bool hasFinance,
    final RunningCondition? runningCondition,
    final List<String> mechanicalIssues,
    final List<String> exteriorPhotos,
    final Map<String, String> exteriorPhotosMap,
    final List<String> interiorPhotos,
    final List<String> damagePhotos,
    final List<DamageItem> damages,
    final ServiceHistoryType? serviceHistoryType,
    final List<String> serviceDocuments,
    final SubmissionStatus submissionStatus,
    final bool vehicleDetailsConfirmed,
    final bool extraFeaturesConfirmed,
    final bool keysConfirmed,
    final bool financeConfirmed,
    final bool runningConditionConfirmed,
    final bool mechanicalIssuesConfirmed,
    final bool photosConfirmed,
    final bool conditionDamageConfirmed,
    final bool serviceHistoryConfirmed,
  }) = _$VehicleRegistrationStateImpl;

  factory _VehicleRegistrationState.fromJson(Map<String, dynamic> json) =
      _$VehicleRegistrationStateImpl.fromJson;

  // Vehicle Information
  @override
  Vehicle? get vehicle;
  @override
  int get mileage; // Extra Features
  @override
  List<String> get extraFeatures; // Keys
  @override
  int get numberOfKeys; // Finance
  @override
  bool get hasFinance; // Running Condition
  @override
  RunningCondition? get runningCondition; // Mechanical Issues
  @override
  List<String> get mechanicalIssues; // Photos
  @override
  List<String> get exteriorPhotos;
  @override
  Map<String, String> get exteriorPhotosMap;
  @override
  List<String> get interiorPhotos;
  @override
  List<String> get damagePhotos; // Condition & Damage
  @override
  List<DamageItem> get damages; // Service History
  @override
  ServiceHistoryType? get serviceHistoryType;
  @override
  List<String> get serviceDocuments; // Submission
  @override
  SubmissionStatus get submissionStatus; // Progress tracking
  @override
  bool get vehicleDetailsConfirmed;
  @override
  bool get extraFeaturesConfirmed;
  @override
  bool get keysConfirmed;
  @override
  bool get financeConfirmed;
  @override
  bool get runningConditionConfirmed;
  @override
  bool get mechanicalIssuesConfirmed;
  @override
  bool get photosConfirmed;
  @override
  bool get conditionDamageConfirmed;
  @override
  bool get serviceHistoryConfirmed;

  /// Create a copy of VehicleRegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VehicleRegistrationStateImplCopyWith<_$VehicleRegistrationStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DamageItem _$DamageItemFromJson(Map<String, dynamic> json) {
  return _DamageItem.fromJson(json);
}

/// @nodoc
mixin _$DamageItem {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get photoPath => throw _privateConstructorUsedError;

  /// Serializes this DamageItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DamageItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DamageItemCopyWith<DamageItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DamageItemCopyWith<$Res> {
  factory $DamageItemCopyWith(
    DamageItem value,
    $Res Function(DamageItem) then,
  ) = _$DamageItemCopyWithImpl<$Res, DamageItem>;
  @useResult
  $Res call({
    String id,
    String type,
    String location,
    String? description,
    String? photoPath,
  });
}

/// @nodoc
class _$DamageItemCopyWithImpl<$Res, $Val extends DamageItem>
    implements $DamageItemCopyWith<$Res> {
  _$DamageItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DamageItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? location = null,
    Object? description = freezed,
    Object? photoPath = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            location: null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            photoPath: freezed == photoPath
                ? _value.photoPath
                : photoPath // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DamageItemImplCopyWith<$Res>
    implements $DamageItemCopyWith<$Res> {
  factory _$$DamageItemImplCopyWith(
    _$DamageItemImpl value,
    $Res Function(_$DamageItemImpl) then,
  ) = __$$DamageItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String type,
    String location,
    String? description,
    String? photoPath,
  });
}

/// @nodoc
class __$$DamageItemImplCopyWithImpl<$Res>
    extends _$DamageItemCopyWithImpl<$Res, _$DamageItemImpl>
    implements _$$DamageItemImplCopyWith<$Res> {
  __$$DamageItemImplCopyWithImpl(
    _$DamageItemImpl _value,
    $Res Function(_$DamageItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DamageItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? location = null,
    Object? description = freezed,
    Object? photoPath = freezed,
  }) {
    return _then(
      _$DamageItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        location: null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        photoPath: freezed == photoPath
            ? _value.photoPath
            : photoPath // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DamageItemImpl implements _DamageItem {
  const _$DamageItemImpl({
    required this.id,
    required this.type,
    required this.location,
    this.description,
    this.photoPath,
  });

  factory _$DamageItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$DamageItemImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final String location;
  @override
  final String? description;
  @override
  final String? photoPath;

  @override
  String toString() {
    return 'DamageItem(id: $id, type: $type, location: $location, description: $description, photoPath: $photoPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DamageItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.photoPath, photoPath) ||
                other.photoPath == photoPath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, type, location, description, photoPath);

  /// Create a copy of DamageItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DamageItemImplCopyWith<_$DamageItemImpl> get copyWith =>
      __$$DamageItemImplCopyWithImpl<_$DamageItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DamageItemImplToJson(this);
  }
}

abstract class _DamageItem implements DamageItem {
  const factory _DamageItem({
    required final String id,
    required final String type,
    required final String location,
    final String? description,
    final String? photoPath,
  }) = _$DamageItemImpl;

  factory _DamageItem.fromJson(Map<String, dynamic> json) =
      _$DamageItemImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  String get location;
  @override
  String? get description;
  @override
  String? get photoPath;

  /// Create a copy of DamageItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DamageItemImplCopyWith<_$DamageItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
