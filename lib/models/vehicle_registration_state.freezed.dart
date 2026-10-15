// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle_registration_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VehicleRegistrationState {

 Vehicle? get vehicle; double get mileage; List<String> get extraFeatures; int get numberOfKeys; bool get hasFinance; RunningCondition? get runningCondition; List<String> get mechanicalIssues; List<String> get exteriorPhotos; Map<String, String> get exteriorPhotosMap; List<String> get interiorPhotos; Map<String, String> get interiorPhotosMap; List<String> get damagePhotos; Map<String, String> get wheelsPhotosMap; String? get tireCondition; String? get seatMaterial; bool get seatMaterialConfirmed; List<PaintworkMark> get paintworkMarks; bool get paintworkConfirmed; List<String> get brokenFittingsPhotos; bool get hasBrokenFittings; bool get brokenFittingsConfirmed; Map<String, bool> get wheelDamageMap; bool get wheelDamageConfirmed; bool get hasToolPack; bool get toolPackConfirmed; bool get hasLockingWheelNut; bool get lockingWheelNutConfirmed; List<DamageItem> get damages; ServiceHistoryType? get serviceHistoryType; List<String> get serviceDocuments; bool get hasProofOfPurchase; bool get proofOfPurchaseConfirmed; bool get hasBeenSmokedIn; bool get smokingConfirmed; bool get hasPrivatePlate; bool get privatePlateConfirmed; SubmissionStatus get submissionStatus; bool get vehicleDetailsConfirmed; bool get extraFeaturesConfirmed; bool get keysConfirmed; bool get financeConfirmed; bool get runningConditionConfirmed; bool get mechanicalIssuesConfirmed; bool get photosConfirmed; bool get interiorPhotosConfirmed; bool get wheelsPhotosConfirmed; bool get tireConditionConfirmed; bool get conditionDamageConfirmed; bool get serviceHistoryConfirmed;
/// Create a copy of VehicleRegistrationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehicleRegistrationStateCopyWith<VehicleRegistrationState> get copyWith => _$VehicleRegistrationStateCopyWithImpl<VehicleRegistrationState>(this as VehicleRegistrationState, _$identity);

  /// Serializes this VehicleRegistrationState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as VehicleRegistrationState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehicleRegistrationState&&(identical(other.vehicle, _this.vehicle) || other.vehicle == _this.vehicle)&&(identical(other.mileage, _this.mileage) || other.mileage == _this.mileage)&&const DeepCollectionEquality().equals(other.extraFeatures, _this.extraFeatures)&&(identical(other.numberOfKeys, _this.numberOfKeys) || other.numberOfKeys == _this.numberOfKeys)&&(identical(other.hasFinance, _this.hasFinance) || other.hasFinance == _this.hasFinance)&&(identical(other.runningCondition, _this.runningCondition) || other.runningCondition == _this.runningCondition)&&const DeepCollectionEquality().equals(other.mechanicalIssues, _this.mechanicalIssues)&&const DeepCollectionEquality().equals(other.exteriorPhotos, _this.exteriorPhotos)&&const DeepCollectionEquality().equals(other.exteriorPhotosMap, _this.exteriorPhotosMap)&&const DeepCollectionEquality().equals(other.interiorPhotos, _this.interiorPhotos)&&const DeepCollectionEquality().equals(other.interiorPhotosMap, _this.interiorPhotosMap)&&const DeepCollectionEquality().equals(other.damagePhotos, _this.damagePhotos)&&const DeepCollectionEquality().equals(other.wheelsPhotosMap, _this.wheelsPhotosMap)&&(identical(other.tireCondition, _this.tireCondition) || other.tireCondition == _this.tireCondition)&&(identical(other.seatMaterial, _this.seatMaterial) || other.seatMaterial == _this.seatMaterial)&&(identical(other.seatMaterialConfirmed, _this.seatMaterialConfirmed) || other.seatMaterialConfirmed == _this.seatMaterialConfirmed)&&const DeepCollectionEquality().equals(other.paintworkMarks, _this.paintworkMarks)&&(identical(other.paintworkConfirmed, _this.paintworkConfirmed) || other.paintworkConfirmed == _this.paintworkConfirmed)&&const DeepCollectionEquality().equals(other.brokenFittingsPhotos, _this.brokenFittingsPhotos)&&(identical(other.hasBrokenFittings, _this.hasBrokenFittings) || other.hasBrokenFittings == _this.hasBrokenFittings)&&(identical(other.brokenFittingsConfirmed, _this.brokenFittingsConfirmed) || other.brokenFittingsConfirmed == _this.brokenFittingsConfirmed)&&const DeepCollectionEquality().equals(other.wheelDamageMap, _this.wheelDamageMap)&&(identical(other.wheelDamageConfirmed, _this.wheelDamageConfirmed) || other.wheelDamageConfirmed == _this.wheelDamageConfirmed)&&(identical(other.hasToolPack, _this.hasToolPack) || other.hasToolPack == _this.hasToolPack)&&(identical(other.toolPackConfirmed, _this.toolPackConfirmed) || other.toolPackConfirmed == _this.toolPackConfirmed)&&(identical(other.hasLockingWheelNut, _this.hasLockingWheelNut) || other.hasLockingWheelNut == _this.hasLockingWheelNut)&&(identical(other.lockingWheelNutConfirmed, _this.lockingWheelNutConfirmed) || other.lockingWheelNutConfirmed == _this.lockingWheelNutConfirmed)&&const DeepCollectionEquality().equals(other.damages, _this.damages)&&(identical(other.serviceHistoryType, _this.serviceHistoryType) || other.serviceHistoryType == _this.serviceHistoryType)&&const DeepCollectionEquality().equals(other.serviceDocuments, _this.serviceDocuments)&&(identical(other.hasProofOfPurchase, _this.hasProofOfPurchase) || other.hasProofOfPurchase == _this.hasProofOfPurchase)&&(identical(other.proofOfPurchaseConfirmed, _this.proofOfPurchaseConfirmed) || other.proofOfPurchaseConfirmed == _this.proofOfPurchaseConfirmed)&&(identical(other.hasBeenSmokedIn, _this.hasBeenSmokedIn) || other.hasBeenSmokedIn == _this.hasBeenSmokedIn)&&(identical(other.smokingConfirmed, _this.smokingConfirmed) || other.smokingConfirmed == _this.smokingConfirmed)&&(identical(other.hasPrivatePlate, _this.hasPrivatePlate) || other.hasPrivatePlate == _this.hasPrivatePlate)&&(identical(other.privatePlateConfirmed, _this.privatePlateConfirmed) || other.privatePlateConfirmed == _this.privatePlateConfirmed)&&(identical(other.submissionStatus, _this.submissionStatus) || other.submissionStatus == _this.submissionStatus)&&(identical(other.vehicleDetailsConfirmed, _this.vehicleDetailsConfirmed) || other.vehicleDetailsConfirmed == _this.vehicleDetailsConfirmed)&&(identical(other.extraFeaturesConfirmed, _this.extraFeaturesConfirmed) || other.extraFeaturesConfirmed == _this.extraFeaturesConfirmed)&&(identical(other.keysConfirmed, _this.keysConfirmed) || other.keysConfirmed == _this.keysConfirmed)&&(identical(other.financeConfirmed, _this.financeConfirmed) || other.financeConfirmed == _this.financeConfirmed)&&(identical(other.runningConditionConfirmed, _this.runningConditionConfirmed) || other.runningConditionConfirmed == _this.runningConditionConfirmed)&&(identical(other.mechanicalIssuesConfirmed, _this.mechanicalIssuesConfirmed) || other.mechanicalIssuesConfirmed == _this.mechanicalIssuesConfirmed)&&(identical(other.photosConfirmed, _this.photosConfirmed) || other.photosConfirmed == _this.photosConfirmed)&&(identical(other.interiorPhotosConfirmed, _this.interiorPhotosConfirmed) || other.interiorPhotosConfirmed == _this.interiorPhotosConfirmed)&&(identical(other.wheelsPhotosConfirmed, _this.wheelsPhotosConfirmed) || other.wheelsPhotosConfirmed == _this.wheelsPhotosConfirmed)&&(identical(other.tireConditionConfirmed, _this.tireConditionConfirmed) || other.tireConditionConfirmed == _this.tireConditionConfirmed)&&(identical(other.conditionDamageConfirmed, _this.conditionDamageConfirmed) || other.conditionDamageConfirmed == _this.conditionDamageConfirmed)&&(identical(other.serviceHistoryConfirmed, _this.serviceHistoryConfirmed) || other.serviceHistoryConfirmed == _this.serviceHistoryConfirmed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VehicleRegistrationState;
  return Object.hashAll([runtimeType,_this.vehicle,_this.mileage,const DeepCollectionEquality().hash(_this.extraFeatures),_this.numberOfKeys,_this.hasFinance,_this.runningCondition,const DeepCollectionEquality().hash(_this.mechanicalIssues),const DeepCollectionEquality().hash(_this.exteriorPhotos),const DeepCollectionEquality().hash(_this.exteriorPhotosMap),const DeepCollectionEquality().hash(_this.interiorPhotos),const DeepCollectionEquality().hash(_this.interiorPhotosMap),const DeepCollectionEquality().hash(_this.damagePhotos),const DeepCollectionEquality().hash(_this.wheelsPhotosMap),_this.tireCondition,_this.seatMaterial,_this.seatMaterialConfirmed,const DeepCollectionEquality().hash(_this.paintworkMarks),_this.paintworkConfirmed,const DeepCollectionEquality().hash(_this.brokenFittingsPhotos),_this.hasBrokenFittings,_this.brokenFittingsConfirmed,const DeepCollectionEquality().hash(_this.wheelDamageMap),_this.wheelDamageConfirmed,_this.hasToolPack,_this.toolPackConfirmed,_this.hasLockingWheelNut,_this.lockingWheelNutConfirmed,const DeepCollectionEquality().hash(_this.damages),_this.serviceHistoryType,const DeepCollectionEquality().hash(_this.serviceDocuments),_this.hasProofOfPurchase,_this.proofOfPurchaseConfirmed,_this.hasBeenSmokedIn,_this.smokingConfirmed,_this.hasPrivatePlate,_this.privatePlateConfirmed,_this.submissionStatus,_this.vehicleDetailsConfirmed,_this.extraFeaturesConfirmed,_this.keysConfirmed,_this.financeConfirmed,_this.runningConditionConfirmed,_this.mechanicalIssuesConfirmed,_this.photosConfirmed,_this.interiorPhotosConfirmed,_this.wheelsPhotosConfirmed,_this.tireConditionConfirmed,_this.conditionDamageConfirmed,_this.serviceHistoryConfirmed]);
}

@override
String toString() {
  final _this = this as VehicleRegistrationState;
  return 'VehicleRegistrationState(vehicle: ${_this.vehicle}, mileage: ${_this.mileage}, extraFeatures: ${_this.extraFeatures}, numberOfKeys: ${_this.numberOfKeys}, hasFinance: ${_this.hasFinance}, runningCondition: ${_this.runningCondition}, mechanicalIssues: ${_this.mechanicalIssues}, exteriorPhotos: ${_this.exteriorPhotos}, exteriorPhotosMap: ${_this.exteriorPhotosMap}, interiorPhotos: ${_this.interiorPhotos}, interiorPhotosMap: ${_this.interiorPhotosMap}, damagePhotos: ${_this.damagePhotos}, wheelsPhotosMap: ${_this.wheelsPhotosMap}, tireCondition: ${_this.tireCondition}, seatMaterial: ${_this.seatMaterial}, seatMaterialConfirmed: ${_this.seatMaterialConfirmed}, paintworkMarks: ${_this.paintworkMarks}, paintworkConfirmed: ${_this.paintworkConfirmed}, brokenFittingsPhotos: ${_this.brokenFittingsPhotos}, hasBrokenFittings: ${_this.hasBrokenFittings}, brokenFittingsConfirmed: ${_this.brokenFittingsConfirmed}, wheelDamageMap: ${_this.wheelDamageMap}, wheelDamageConfirmed: ${_this.wheelDamageConfirmed}, hasToolPack: ${_this.hasToolPack}, toolPackConfirmed: ${_this.toolPackConfirmed}, hasLockingWheelNut: ${_this.hasLockingWheelNut}, lockingWheelNutConfirmed: ${_this.lockingWheelNutConfirmed}, damages: ${_this.damages}, serviceHistoryType: ${_this.serviceHistoryType}, serviceDocuments: ${_this.serviceDocuments}, hasProofOfPurchase: ${_this.hasProofOfPurchase}, proofOfPurchaseConfirmed: ${_this.proofOfPurchaseConfirmed}, hasBeenSmokedIn: ${_this.hasBeenSmokedIn}, smokingConfirmed: ${_this.smokingConfirmed}, hasPrivatePlate: ${_this.hasPrivatePlate}, privatePlateConfirmed: ${_this.privatePlateConfirmed}, submissionStatus: ${_this.submissionStatus}, vehicleDetailsConfirmed: ${_this.vehicleDetailsConfirmed}, extraFeaturesConfirmed: ${_this.extraFeaturesConfirmed}, keysConfirmed: ${_this.keysConfirmed}, financeConfirmed: ${_this.financeConfirmed}, runningConditionConfirmed: ${_this.runningConditionConfirmed}, mechanicalIssuesConfirmed: ${_this.mechanicalIssuesConfirmed}, photosConfirmed: ${_this.photosConfirmed}, interiorPhotosConfirmed: ${_this.interiorPhotosConfirmed}, wheelsPhotosConfirmed: ${_this.wheelsPhotosConfirmed}, tireConditionConfirmed: ${_this.tireConditionConfirmed}, conditionDamageConfirmed: ${_this.conditionDamageConfirmed}, serviceHistoryConfirmed: ${_this.serviceHistoryConfirmed})';
}


}

/// @nodoc
abstract mixin class $VehicleRegistrationStateCopyWith<$Res>  {
  factory $VehicleRegistrationStateCopyWith(VehicleRegistrationState value, $Res Function(VehicleRegistrationState) _then) = _$VehicleRegistrationStateCopyWithImpl;
@useResult
$Res call({
 Vehicle? vehicle, double mileage, List<String> extraFeatures, int numberOfKeys, bool hasFinance, RunningCondition? runningCondition, List<String> mechanicalIssues, List<String> exteriorPhotos, Map<String, String> exteriorPhotosMap, List<String> interiorPhotos, Map<String, String> interiorPhotosMap, List<String> damagePhotos, Map<String, String> wheelsPhotosMap, String? tireCondition, String? seatMaterial, bool seatMaterialConfirmed, List<PaintworkMark> paintworkMarks, bool paintworkConfirmed, List<String> brokenFittingsPhotos, bool hasBrokenFittings, bool brokenFittingsConfirmed, Map<String, bool> wheelDamageMap, bool wheelDamageConfirmed, bool hasToolPack, bool toolPackConfirmed, bool hasLockingWheelNut, bool lockingWheelNutConfirmed, List<DamageItem> damages, ServiceHistoryType? serviceHistoryType, List<String> serviceDocuments, bool hasProofOfPurchase, bool proofOfPurchaseConfirmed, bool hasBeenSmokedIn, bool smokingConfirmed, bool hasPrivatePlate, bool privatePlateConfirmed, SubmissionStatus submissionStatus, bool vehicleDetailsConfirmed, bool extraFeaturesConfirmed, bool keysConfirmed, bool financeConfirmed, bool runningConditionConfirmed, bool mechanicalIssuesConfirmed, bool photosConfirmed, bool interiorPhotosConfirmed, bool wheelsPhotosConfirmed, bool tireConditionConfirmed, bool conditionDamageConfirmed, bool serviceHistoryConfirmed
});


$VehicleCopyWith<$Res>? get vehicle;

}
/// @nodoc
class _$VehicleRegistrationStateCopyWithImpl<$Res>
    implements $VehicleRegistrationStateCopyWith<$Res> {
  _$VehicleRegistrationStateCopyWithImpl(this._self, this._then);

  final VehicleRegistrationState _self;
  final $Res Function(VehicleRegistrationState) _then;

/// Create a copy of VehicleRegistrationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vehicle = freezed,Object? mileage = null,Object? extraFeatures = null,Object? numberOfKeys = null,Object? hasFinance = null,Object? runningCondition = freezed,Object? mechanicalIssues = null,Object? exteriorPhotos = null,Object? exteriorPhotosMap = null,Object? interiorPhotos = null,Object? interiorPhotosMap = null,Object? damagePhotos = null,Object? wheelsPhotosMap = null,Object? tireCondition = freezed,Object? seatMaterial = freezed,Object? seatMaterialConfirmed = null,Object? paintworkMarks = null,Object? paintworkConfirmed = null,Object? brokenFittingsPhotos = null,Object? hasBrokenFittings = null,Object? brokenFittingsConfirmed = null,Object? wheelDamageMap = null,Object? wheelDamageConfirmed = null,Object? hasToolPack = null,Object? toolPackConfirmed = null,Object? hasLockingWheelNut = null,Object? lockingWheelNutConfirmed = null,Object? damages = null,Object? serviceHistoryType = freezed,Object? serviceDocuments = null,Object? hasProofOfPurchase = null,Object? proofOfPurchaseConfirmed = null,Object? hasBeenSmokedIn = null,Object? smokingConfirmed = null,Object? hasPrivatePlate = null,Object? privatePlateConfirmed = null,Object? submissionStatus = null,Object? vehicleDetailsConfirmed = null,Object? extraFeaturesConfirmed = null,Object? keysConfirmed = null,Object? financeConfirmed = null,Object? runningConditionConfirmed = null,Object? mechanicalIssuesConfirmed = null,Object? photosConfirmed = null,Object? interiorPhotosConfirmed = null,Object? wheelsPhotosConfirmed = null,Object? tireConditionConfirmed = null,Object? conditionDamageConfirmed = null,Object? serviceHistoryConfirmed = null,}) {
  return _then(VehicleRegistrationState(
vehicle: freezed == vehicle ? _self.vehicle : vehicle // ignore: cast_nullable_to_non_nullable
as Vehicle?,mileage: null == mileage ? _self.mileage : mileage // ignore: cast_nullable_to_non_nullable
as double,extraFeatures: null == extraFeatures ? _self.extraFeatures : extraFeatures // ignore: cast_nullable_to_non_nullable
as List<String>,numberOfKeys: null == numberOfKeys ? _self.numberOfKeys : numberOfKeys // ignore: cast_nullable_to_non_nullable
as int,hasFinance: null == hasFinance ? _self.hasFinance : hasFinance // ignore: cast_nullable_to_non_nullable
as bool,runningCondition: freezed == runningCondition ? _self.runningCondition : runningCondition // ignore: cast_nullable_to_non_nullable
as RunningCondition?,mechanicalIssues: null == mechanicalIssues ? _self.mechanicalIssues : mechanicalIssues // ignore: cast_nullable_to_non_nullable
as List<String>,exteriorPhotos: null == exteriorPhotos ? _self.exteriorPhotos : exteriorPhotos // ignore: cast_nullable_to_non_nullable
as List<String>,exteriorPhotosMap: null == exteriorPhotosMap ? _self.exteriorPhotosMap : exteriorPhotosMap // ignore: cast_nullable_to_non_nullable
as Map<String, String>,interiorPhotos: null == interiorPhotos ? _self.interiorPhotos : interiorPhotos // ignore: cast_nullable_to_non_nullable
as List<String>,interiorPhotosMap: null == interiorPhotosMap ? _self.interiorPhotosMap : interiorPhotosMap // ignore: cast_nullable_to_non_nullable
as Map<String, String>,damagePhotos: null == damagePhotos ? _self.damagePhotos : damagePhotos // ignore: cast_nullable_to_non_nullable
as List<String>,wheelsPhotosMap: null == wheelsPhotosMap ? _self.wheelsPhotosMap : wheelsPhotosMap // ignore: cast_nullable_to_non_nullable
as Map<String, String>,tireCondition: freezed == tireCondition ? _self.tireCondition : tireCondition // ignore: cast_nullable_to_non_nullable
as String?,seatMaterial: freezed == seatMaterial ? _self.seatMaterial : seatMaterial // ignore: cast_nullable_to_non_nullable
as String?,seatMaterialConfirmed: null == seatMaterialConfirmed ? _self.seatMaterialConfirmed : seatMaterialConfirmed // ignore: cast_nullable_to_non_nullable
as bool,paintworkMarks: null == paintworkMarks ? _self.paintworkMarks : paintworkMarks // ignore: cast_nullable_to_non_nullable
as List<PaintworkMark>,paintworkConfirmed: null == paintworkConfirmed ? _self.paintworkConfirmed : paintworkConfirmed // ignore: cast_nullable_to_non_nullable
as bool,brokenFittingsPhotos: null == brokenFittingsPhotos ? _self.brokenFittingsPhotos : brokenFittingsPhotos // ignore: cast_nullable_to_non_nullable
as List<String>,hasBrokenFittings: null == hasBrokenFittings ? _self.hasBrokenFittings : hasBrokenFittings // ignore: cast_nullable_to_non_nullable
as bool,brokenFittingsConfirmed: null == brokenFittingsConfirmed ? _self.brokenFittingsConfirmed : brokenFittingsConfirmed // ignore: cast_nullable_to_non_nullable
as bool,wheelDamageMap: null == wheelDamageMap ? _self.wheelDamageMap : wheelDamageMap // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,wheelDamageConfirmed: null == wheelDamageConfirmed ? _self.wheelDamageConfirmed : wheelDamageConfirmed // ignore: cast_nullable_to_non_nullable
as bool,hasToolPack: null == hasToolPack ? _self.hasToolPack : hasToolPack // ignore: cast_nullable_to_non_nullable
as bool,toolPackConfirmed: null == toolPackConfirmed ? _self.toolPackConfirmed : toolPackConfirmed // ignore: cast_nullable_to_non_nullable
as bool,hasLockingWheelNut: null == hasLockingWheelNut ? _self.hasLockingWheelNut : hasLockingWheelNut // ignore: cast_nullable_to_non_nullable
as bool,lockingWheelNutConfirmed: null == lockingWheelNutConfirmed ? _self.lockingWheelNutConfirmed : lockingWheelNutConfirmed // ignore: cast_nullable_to_non_nullable
as bool,damages: null == damages ? _self.damages : damages // ignore: cast_nullable_to_non_nullable
as List<DamageItem>,serviceHistoryType: freezed == serviceHistoryType ? _self.serviceHistoryType : serviceHistoryType // ignore: cast_nullable_to_non_nullable
as ServiceHistoryType?,serviceDocuments: null == serviceDocuments ? _self.serviceDocuments : serviceDocuments // ignore: cast_nullable_to_non_nullable
as List<String>,hasProofOfPurchase: null == hasProofOfPurchase ? _self.hasProofOfPurchase : hasProofOfPurchase // ignore: cast_nullable_to_non_nullable
as bool,proofOfPurchaseConfirmed: null == proofOfPurchaseConfirmed ? _self.proofOfPurchaseConfirmed : proofOfPurchaseConfirmed // ignore: cast_nullable_to_non_nullable
as bool,hasBeenSmokedIn: null == hasBeenSmokedIn ? _self.hasBeenSmokedIn : hasBeenSmokedIn // ignore: cast_nullable_to_non_nullable
as bool,smokingConfirmed: null == smokingConfirmed ? _self.smokingConfirmed : smokingConfirmed // ignore: cast_nullable_to_non_nullable
as bool,hasPrivatePlate: null == hasPrivatePlate ? _self.hasPrivatePlate : hasPrivatePlate // ignore: cast_nullable_to_non_nullable
as bool,privatePlateConfirmed: null == privatePlateConfirmed ? _self.privatePlateConfirmed : privatePlateConfirmed // ignore: cast_nullable_to_non_nullable
as bool,submissionStatus: null == submissionStatus ? _self.submissionStatus : submissionStatus // ignore: cast_nullable_to_non_nullable
as SubmissionStatus,vehicleDetailsConfirmed: null == vehicleDetailsConfirmed ? _self.vehicleDetailsConfirmed : vehicleDetailsConfirmed // ignore: cast_nullable_to_non_nullable
as bool,extraFeaturesConfirmed: null == extraFeaturesConfirmed ? _self.extraFeaturesConfirmed : extraFeaturesConfirmed // ignore: cast_nullable_to_non_nullable
as bool,keysConfirmed: null == keysConfirmed ? _self.keysConfirmed : keysConfirmed // ignore: cast_nullable_to_non_nullable
as bool,financeConfirmed: null == financeConfirmed ? _self.financeConfirmed : financeConfirmed // ignore: cast_nullable_to_non_nullable
as bool,runningConditionConfirmed: null == runningConditionConfirmed ? _self.runningConditionConfirmed : runningConditionConfirmed // ignore: cast_nullable_to_non_nullable
as bool,mechanicalIssuesConfirmed: null == mechanicalIssuesConfirmed ? _self.mechanicalIssuesConfirmed : mechanicalIssuesConfirmed // ignore: cast_nullable_to_non_nullable
as bool,photosConfirmed: null == photosConfirmed ? _self.photosConfirmed : photosConfirmed // ignore: cast_nullable_to_non_nullable
as bool,interiorPhotosConfirmed: null == interiorPhotosConfirmed ? _self.interiorPhotosConfirmed : interiorPhotosConfirmed // ignore: cast_nullable_to_non_nullable
as bool,wheelsPhotosConfirmed: null == wheelsPhotosConfirmed ? _self.wheelsPhotosConfirmed : wheelsPhotosConfirmed // ignore: cast_nullable_to_non_nullable
as bool,tireConditionConfirmed: null == tireConditionConfirmed ? _self.tireConditionConfirmed : tireConditionConfirmed // ignore: cast_nullable_to_non_nullable
as bool,conditionDamageConfirmed: null == conditionDamageConfirmed ? _self.conditionDamageConfirmed : conditionDamageConfirmed // ignore: cast_nullable_to_non_nullable
as bool,serviceHistoryConfirmed: null == serviceHistoryConfirmed ? _self.serviceHistoryConfirmed : serviceHistoryConfirmed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of VehicleRegistrationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VehicleCopyWith<$Res>? get vehicle {
    if (_self.vehicle == null) {
    return null;
  }

  return $VehicleCopyWith<$Res>(_self.vehicle!, (value) {
    return _then(_self.copyWith(vehicle: value));
  });
}
}


/// Adds pattern-matching-related methods to [VehicleRegistrationState].
extension VehicleRegistrationStatePatterns on VehicleRegistrationState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VehicleRegistrationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VehicleRegistrationState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VehicleRegistrationState value)  $default,){
final _that = this;
switch (_that) {
case _VehicleRegistrationState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VehicleRegistrationState value)?  $default,){
final _that = this;
switch (_that) {
case _VehicleRegistrationState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Vehicle? vehicle,  double mileage,  List<String> extraFeatures,  int numberOfKeys,  bool hasFinance,  RunningCondition? runningCondition,  List<String> mechanicalIssues,  List<String> exteriorPhotos,  Map<String, String> exteriorPhotosMap,  List<String> interiorPhotos,  Map<String, String> interiorPhotosMap,  List<String> damagePhotos,  Map<String, String> wheelsPhotosMap,  String? tireCondition,  String? seatMaterial,  bool seatMaterialConfirmed,  List<PaintworkMark> paintworkMarks,  bool paintworkConfirmed,  List<String> brokenFittingsPhotos,  bool hasBrokenFittings,  bool brokenFittingsConfirmed,  Map<String, bool> wheelDamageMap,  bool wheelDamageConfirmed,  bool hasToolPack,  bool toolPackConfirmed,  bool hasLockingWheelNut,  bool lockingWheelNutConfirmed,  List<DamageItem> damages,  ServiceHistoryType? serviceHistoryType,  List<String> serviceDocuments,  bool hasProofOfPurchase,  bool proofOfPurchaseConfirmed,  bool hasBeenSmokedIn,  bool smokingConfirmed,  bool hasPrivatePlate,  bool privatePlateConfirmed,  SubmissionStatus submissionStatus,  bool vehicleDetailsConfirmed,  bool extraFeaturesConfirmed,  bool keysConfirmed,  bool financeConfirmed,  bool runningConditionConfirmed,  bool mechanicalIssuesConfirmed,  bool photosConfirmed,  bool interiorPhotosConfirmed,  bool wheelsPhotosConfirmed,  bool tireConditionConfirmed,  bool conditionDamageConfirmed,  bool serviceHistoryConfirmed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VehicleRegistrationState() when $default != null:
return $default(_that.vehicle,_that.mileage,_that.extraFeatures,_that.numberOfKeys,_that.hasFinance,_that.runningCondition,_that.mechanicalIssues,_that.exteriorPhotos,_that.exteriorPhotosMap,_that.interiorPhotos,_that.interiorPhotosMap,_that.damagePhotos,_that.wheelsPhotosMap,_that.tireCondition,_that.seatMaterial,_that.seatMaterialConfirmed,_that.paintworkMarks,_that.paintworkConfirmed,_that.brokenFittingsPhotos,_that.hasBrokenFittings,_that.brokenFittingsConfirmed,_that.wheelDamageMap,_that.wheelDamageConfirmed,_that.hasToolPack,_that.toolPackConfirmed,_that.hasLockingWheelNut,_that.lockingWheelNutConfirmed,_that.damages,_that.serviceHistoryType,_that.serviceDocuments,_that.hasProofOfPurchase,_that.proofOfPurchaseConfirmed,_that.hasBeenSmokedIn,_that.smokingConfirmed,_that.hasPrivatePlate,_that.privatePlateConfirmed,_that.submissionStatus,_that.vehicleDetailsConfirmed,_that.extraFeaturesConfirmed,_that.keysConfirmed,_that.financeConfirmed,_that.runningConditionConfirmed,_that.mechanicalIssuesConfirmed,_that.photosConfirmed,_that.interiorPhotosConfirmed,_that.wheelsPhotosConfirmed,_that.tireConditionConfirmed,_that.conditionDamageConfirmed,_that.serviceHistoryConfirmed);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Vehicle? vehicle,  double mileage,  List<String> extraFeatures,  int numberOfKeys,  bool hasFinance,  RunningCondition? runningCondition,  List<String> mechanicalIssues,  List<String> exteriorPhotos,  Map<String, String> exteriorPhotosMap,  List<String> interiorPhotos,  Map<String, String> interiorPhotosMap,  List<String> damagePhotos,  Map<String, String> wheelsPhotosMap,  String? tireCondition,  String? seatMaterial,  bool seatMaterialConfirmed,  List<PaintworkMark> paintworkMarks,  bool paintworkConfirmed,  List<String> brokenFittingsPhotos,  bool hasBrokenFittings,  bool brokenFittingsConfirmed,  Map<String, bool> wheelDamageMap,  bool wheelDamageConfirmed,  bool hasToolPack,  bool toolPackConfirmed,  bool hasLockingWheelNut,  bool lockingWheelNutConfirmed,  List<DamageItem> damages,  ServiceHistoryType? serviceHistoryType,  List<String> serviceDocuments,  bool hasProofOfPurchase,  bool proofOfPurchaseConfirmed,  bool hasBeenSmokedIn,  bool smokingConfirmed,  bool hasPrivatePlate,  bool privatePlateConfirmed,  SubmissionStatus submissionStatus,  bool vehicleDetailsConfirmed,  bool extraFeaturesConfirmed,  bool keysConfirmed,  bool financeConfirmed,  bool runningConditionConfirmed,  bool mechanicalIssuesConfirmed,  bool photosConfirmed,  bool interiorPhotosConfirmed,  bool wheelsPhotosConfirmed,  bool tireConditionConfirmed,  bool conditionDamageConfirmed,  bool serviceHistoryConfirmed)  $default,) {final _that = this;
switch (_that) {
case _VehicleRegistrationState():
return $default(_that.vehicle,_that.mileage,_that.extraFeatures,_that.numberOfKeys,_that.hasFinance,_that.runningCondition,_that.mechanicalIssues,_that.exteriorPhotos,_that.exteriorPhotosMap,_that.interiorPhotos,_that.interiorPhotosMap,_that.damagePhotos,_that.wheelsPhotosMap,_that.tireCondition,_that.seatMaterial,_that.seatMaterialConfirmed,_that.paintworkMarks,_that.paintworkConfirmed,_that.brokenFittingsPhotos,_that.hasBrokenFittings,_that.brokenFittingsConfirmed,_that.wheelDamageMap,_that.wheelDamageConfirmed,_that.hasToolPack,_that.toolPackConfirmed,_that.hasLockingWheelNut,_that.lockingWheelNutConfirmed,_that.damages,_that.serviceHistoryType,_that.serviceDocuments,_that.hasProofOfPurchase,_that.proofOfPurchaseConfirmed,_that.hasBeenSmokedIn,_that.smokingConfirmed,_that.hasPrivatePlate,_that.privatePlateConfirmed,_that.submissionStatus,_that.vehicleDetailsConfirmed,_that.extraFeaturesConfirmed,_that.keysConfirmed,_that.financeConfirmed,_that.runningConditionConfirmed,_that.mechanicalIssuesConfirmed,_that.photosConfirmed,_that.interiorPhotosConfirmed,_that.wheelsPhotosConfirmed,_that.tireConditionConfirmed,_that.conditionDamageConfirmed,_that.serviceHistoryConfirmed);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Vehicle? vehicle,  double mileage,  List<String> extraFeatures,  int numberOfKeys,  bool hasFinance,  RunningCondition? runningCondition,  List<String> mechanicalIssues,  List<String> exteriorPhotos,  Map<String, String> exteriorPhotosMap,  List<String> interiorPhotos,  Map<String, String> interiorPhotosMap,  List<String> damagePhotos,  Map<String, String> wheelsPhotosMap,  String? tireCondition,  String? seatMaterial,  bool seatMaterialConfirmed,  List<PaintworkMark> paintworkMarks,  bool paintworkConfirmed,  List<String> brokenFittingsPhotos,  bool hasBrokenFittings,  bool brokenFittingsConfirmed,  Map<String, bool> wheelDamageMap,  bool wheelDamageConfirmed,  bool hasToolPack,  bool toolPackConfirmed,  bool hasLockingWheelNut,  bool lockingWheelNutConfirmed,  List<DamageItem> damages,  ServiceHistoryType? serviceHistoryType,  List<String> serviceDocuments,  bool hasProofOfPurchase,  bool proofOfPurchaseConfirmed,  bool hasBeenSmokedIn,  bool smokingConfirmed,  bool hasPrivatePlate,  bool privatePlateConfirmed,  SubmissionStatus submissionStatus,  bool vehicleDetailsConfirmed,  bool extraFeaturesConfirmed,  bool keysConfirmed,  bool financeConfirmed,  bool runningConditionConfirmed,  bool mechanicalIssuesConfirmed,  bool photosConfirmed,  bool interiorPhotosConfirmed,  bool wheelsPhotosConfirmed,  bool tireConditionConfirmed,  bool conditionDamageConfirmed,  bool serviceHistoryConfirmed)?  $default,) {final _that = this;
switch (_that) {
case _VehicleRegistrationState() when $default != null:
return $default(_that.vehicle,_that.mileage,_that.extraFeatures,_that.numberOfKeys,_that.hasFinance,_that.runningCondition,_that.mechanicalIssues,_that.exteriorPhotos,_that.exteriorPhotosMap,_that.interiorPhotos,_that.interiorPhotosMap,_that.damagePhotos,_that.wheelsPhotosMap,_that.tireCondition,_that.seatMaterial,_that.seatMaterialConfirmed,_that.paintworkMarks,_that.paintworkConfirmed,_that.brokenFittingsPhotos,_that.hasBrokenFittings,_that.brokenFittingsConfirmed,_that.wheelDamageMap,_that.wheelDamageConfirmed,_that.hasToolPack,_that.toolPackConfirmed,_that.hasLockingWheelNut,_that.lockingWheelNutConfirmed,_that.damages,_that.serviceHistoryType,_that.serviceDocuments,_that.hasProofOfPurchase,_that.proofOfPurchaseConfirmed,_that.hasBeenSmokedIn,_that.smokingConfirmed,_that.hasPrivatePlate,_that.privatePlateConfirmed,_that.submissionStatus,_that.vehicleDetailsConfirmed,_that.extraFeaturesConfirmed,_that.keysConfirmed,_that.financeConfirmed,_that.runningConditionConfirmed,_that.mechanicalIssuesConfirmed,_that.photosConfirmed,_that.interiorPhotosConfirmed,_that.wheelsPhotosConfirmed,_that.tireConditionConfirmed,_that.conditionDamageConfirmed,_that.serviceHistoryConfirmed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VehicleRegistrationState implements VehicleRegistrationState {
  const _VehicleRegistrationState({this.vehicle, this.mileage = 0,  List<String> extraFeatures = const [], this.numberOfKeys = 1, this.hasFinance = false, this.runningCondition,  List<String> mechanicalIssues = const [],  List<String> exteriorPhotos = const [],  Map<String, String> exteriorPhotosMap = const {},  List<String> interiorPhotos = const [],  Map<String, String> interiorPhotosMap = const {},  List<String> damagePhotos = const [],  Map<String, String> wheelsPhotosMap = const {}, this.tireCondition, this.seatMaterial, this.seatMaterialConfirmed = false,  List<PaintworkMark> paintworkMarks = const [], this.paintworkConfirmed = false,  List<String> brokenFittingsPhotos = const [], this.hasBrokenFittings = false, this.brokenFittingsConfirmed = false,  Map<String, bool> wheelDamageMap = const {}, this.wheelDamageConfirmed = false, this.hasToolPack = false, this.toolPackConfirmed = false, this.hasLockingWheelNut = false, this.lockingWheelNutConfirmed = false,  List<DamageItem> damages = const [], this.serviceHistoryType,  List<String> serviceDocuments = const [], this.hasProofOfPurchase = false, this.proofOfPurchaseConfirmed = false, this.hasBeenSmokedIn = false, this.smokingConfirmed = false, this.hasPrivatePlate = false, this.privatePlateConfirmed = false, this.submissionStatus = SubmissionStatus.draft, this.vehicleDetailsConfirmed = false, this.extraFeaturesConfirmed = false, this.keysConfirmed = false, this.financeConfirmed = false, this.runningConditionConfirmed = false, this.mechanicalIssuesConfirmed = false, this.photosConfirmed = false, this.interiorPhotosConfirmed = false, this.wheelsPhotosConfirmed = false, this.tireConditionConfirmed = false, this.conditionDamageConfirmed = false, this.serviceHistoryConfirmed = false}): _extraFeatures = extraFeatures,_mechanicalIssues = mechanicalIssues,_exteriorPhotos = exteriorPhotos,_exteriorPhotosMap = exteriorPhotosMap,_interiorPhotos = interiorPhotos,_interiorPhotosMap = interiorPhotosMap,_damagePhotos = damagePhotos,_wheelsPhotosMap = wheelsPhotosMap,_paintworkMarks = paintworkMarks,_brokenFittingsPhotos = brokenFittingsPhotos,_wheelDamageMap = wheelDamageMap,_damages = damages,_serviceDocuments = serviceDocuments;
  factory _VehicleRegistrationState.fromJson(Map<String, dynamic> json) => _$VehicleRegistrationStateFromJson(json);

@override final  Vehicle? vehicle;
@override@JsonKey() final  double mileage;
 final  List<String> _extraFeatures;
@override@JsonKey() List<String> get extraFeatures {
  if (_extraFeatures is EqualUnmodifiableListView) return _extraFeatures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_extraFeatures);
}

@override@JsonKey() final  int numberOfKeys;
@override@JsonKey() final  bool hasFinance;
@override final  RunningCondition? runningCondition;
 final  List<String> _mechanicalIssues;
@override@JsonKey() List<String> get mechanicalIssues {
  if (_mechanicalIssues is EqualUnmodifiableListView) return _mechanicalIssues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mechanicalIssues);
}

 final  List<String> _exteriorPhotos;
@override@JsonKey() List<String> get exteriorPhotos {
  if (_exteriorPhotos is EqualUnmodifiableListView) return _exteriorPhotos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exteriorPhotos);
}

 final  Map<String, String> _exteriorPhotosMap;
@override@JsonKey() Map<String, String> get exteriorPhotosMap {
  if (_exteriorPhotosMap is EqualUnmodifiableMapView) return _exteriorPhotosMap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_exteriorPhotosMap);
}

 final  List<String> _interiorPhotos;
@override@JsonKey() List<String> get interiorPhotos {
  if (_interiorPhotos is EqualUnmodifiableListView) return _interiorPhotos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_interiorPhotos);
}

 final  Map<String, String> _interiorPhotosMap;
@override@JsonKey() Map<String, String> get interiorPhotosMap {
  if (_interiorPhotosMap is EqualUnmodifiableMapView) return _interiorPhotosMap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_interiorPhotosMap);
}

 final  List<String> _damagePhotos;
@override@JsonKey() List<String> get damagePhotos {
  if (_damagePhotos is EqualUnmodifiableListView) return _damagePhotos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_damagePhotos);
}

 final  Map<String, String> _wheelsPhotosMap;
@override@JsonKey() Map<String, String> get wheelsPhotosMap {
  if (_wheelsPhotosMap is EqualUnmodifiableMapView) return _wheelsPhotosMap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_wheelsPhotosMap);
}

@override final  String? tireCondition;
@override final  String? seatMaterial;
@override@JsonKey() final  bool seatMaterialConfirmed;
 final  List<PaintworkMark> _paintworkMarks;
@override@JsonKey() List<PaintworkMark> get paintworkMarks {
  if (_paintworkMarks is EqualUnmodifiableListView) return _paintworkMarks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_paintworkMarks);
}

@override@JsonKey() final  bool paintworkConfirmed;
 final  List<String> _brokenFittingsPhotos;
@override@JsonKey() List<String> get brokenFittingsPhotos {
  if (_brokenFittingsPhotos is EqualUnmodifiableListView) return _brokenFittingsPhotos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_brokenFittingsPhotos);
}

@override@JsonKey() final  bool hasBrokenFittings;
@override@JsonKey() final  bool brokenFittingsConfirmed;
 final  Map<String, bool> _wheelDamageMap;
@override@JsonKey() Map<String, bool> get wheelDamageMap {
  if (_wheelDamageMap is EqualUnmodifiableMapView) return _wheelDamageMap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_wheelDamageMap);
}

@override@JsonKey() final  bool wheelDamageConfirmed;
@override@JsonKey() final  bool hasToolPack;
@override@JsonKey() final  bool toolPackConfirmed;
@override@JsonKey() final  bool hasLockingWheelNut;
@override@JsonKey() final  bool lockingWheelNutConfirmed;
 final  List<DamageItem> _damages;
@override@JsonKey() List<DamageItem> get damages {
  if (_damages is EqualUnmodifiableListView) return _damages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_damages);
}

@override final  ServiceHistoryType? serviceHistoryType;
 final  List<String> _serviceDocuments;
@override@JsonKey() List<String> get serviceDocuments {
  if (_serviceDocuments is EqualUnmodifiableListView) return _serviceDocuments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_serviceDocuments);
}

@override@JsonKey() final  bool hasProofOfPurchase;
@override@JsonKey() final  bool proofOfPurchaseConfirmed;
@override@JsonKey() final  bool hasBeenSmokedIn;
@override@JsonKey() final  bool smokingConfirmed;
@override@JsonKey() final  bool hasPrivatePlate;
@override@JsonKey() final  bool privatePlateConfirmed;
@override@JsonKey() final  SubmissionStatus submissionStatus;
@override@JsonKey() final  bool vehicleDetailsConfirmed;
@override@JsonKey() final  bool extraFeaturesConfirmed;
@override@JsonKey() final  bool keysConfirmed;
@override@JsonKey() final  bool financeConfirmed;
@override@JsonKey() final  bool runningConditionConfirmed;
@override@JsonKey() final  bool mechanicalIssuesConfirmed;
@override@JsonKey() final  bool photosConfirmed;
@override@JsonKey() final  bool interiorPhotosConfirmed;
@override@JsonKey() final  bool wheelsPhotosConfirmed;
@override@JsonKey() final  bool tireConditionConfirmed;
@override@JsonKey() final  bool conditionDamageConfirmed;
@override@JsonKey() final  bool serviceHistoryConfirmed;

/// Create a copy of VehicleRegistrationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VehicleRegistrationStateCopyWith<_VehicleRegistrationState> get copyWith => __$VehicleRegistrationStateCopyWithImpl<_VehicleRegistrationState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VehicleRegistrationStateToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VehicleRegistrationState&&(identical(other.vehicle, vehicle) || other.vehicle == vehicle)&&(identical(other.mileage, mileage) || other.mileage == mileage)&&const DeepCollectionEquality().equals(other.extraFeatures, _extraFeatures)&&(identical(other.numberOfKeys, numberOfKeys) || other.numberOfKeys == numberOfKeys)&&(identical(other.hasFinance, hasFinance) || other.hasFinance == hasFinance)&&(identical(other.runningCondition, runningCondition) || other.runningCondition == runningCondition)&&const DeepCollectionEquality().equals(other.mechanicalIssues, _mechanicalIssues)&&const DeepCollectionEquality().equals(other.exteriorPhotos, _exteriorPhotos)&&const DeepCollectionEquality().equals(other.exteriorPhotosMap, _exteriorPhotosMap)&&const DeepCollectionEquality().equals(other.interiorPhotos, _interiorPhotos)&&const DeepCollectionEquality().equals(other.interiorPhotosMap, _interiorPhotosMap)&&const DeepCollectionEquality().equals(other.damagePhotos, _damagePhotos)&&const DeepCollectionEquality().equals(other.wheelsPhotosMap, _wheelsPhotosMap)&&(identical(other.tireCondition, tireCondition) || other.tireCondition == tireCondition)&&(identical(other.seatMaterial, seatMaterial) || other.seatMaterial == seatMaterial)&&(identical(other.seatMaterialConfirmed, seatMaterialConfirmed) || other.seatMaterialConfirmed == seatMaterialConfirmed)&&const DeepCollectionEquality().equals(other.paintworkMarks, _paintworkMarks)&&(identical(other.paintworkConfirmed, paintworkConfirmed) || other.paintworkConfirmed == paintworkConfirmed)&&const DeepCollectionEquality().equals(other.brokenFittingsPhotos, _brokenFittingsPhotos)&&(identical(other.hasBrokenFittings, hasBrokenFittings) || other.hasBrokenFittings == hasBrokenFittings)&&(identical(other.brokenFittingsConfirmed, brokenFittingsConfirmed) || other.brokenFittingsConfirmed == brokenFittingsConfirmed)&&const DeepCollectionEquality().equals(other.wheelDamageMap, _wheelDamageMap)&&(identical(other.wheelDamageConfirmed, wheelDamageConfirmed) || other.wheelDamageConfirmed == wheelDamageConfirmed)&&(identical(other.hasToolPack, hasToolPack) || other.hasToolPack == hasToolPack)&&(identical(other.toolPackConfirmed, toolPackConfirmed) || other.toolPackConfirmed == toolPackConfirmed)&&(identical(other.hasLockingWheelNut, hasLockingWheelNut) || other.hasLockingWheelNut == hasLockingWheelNut)&&(identical(other.lockingWheelNutConfirmed, lockingWheelNutConfirmed) || other.lockingWheelNutConfirmed == lockingWheelNutConfirmed)&&const DeepCollectionEquality().equals(other.damages, _damages)&&(identical(other.serviceHistoryType, serviceHistoryType) || other.serviceHistoryType == serviceHistoryType)&&const DeepCollectionEquality().equals(other.serviceDocuments, _serviceDocuments)&&(identical(other.hasProofOfPurchase, hasProofOfPurchase) || other.hasProofOfPurchase == hasProofOfPurchase)&&(identical(other.proofOfPurchaseConfirmed, proofOfPurchaseConfirmed) || other.proofOfPurchaseConfirmed == proofOfPurchaseConfirmed)&&(identical(other.hasBeenSmokedIn, hasBeenSmokedIn) || other.hasBeenSmokedIn == hasBeenSmokedIn)&&(identical(other.smokingConfirmed, smokingConfirmed) || other.smokingConfirmed == smokingConfirmed)&&(identical(other.hasPrivatePlate, hasPrivatePlate) || other.hasPrivatePlate == hasPrivatePlate)&&(identical(other.privatePlateConfirmed, privatePlateConfirmed) || other.privatePlateConfirmed == privatePlateConfirmed)&&(identical(other.submissionStatus, submissionStatus) || other.submissionStatus == submissionStatus)&&(identical(other.vehicleDetailsConfirmed, vehicleDetailsConfirmed) || other.vehicleDetailsConfirmed == vehicleDetailsConfirmed)&&(identical(other.extraFeaturesConfirmed, extraFeaturesConfirmed) || other.extraFeaturesConfirmed == extraFeaturesConfirmed)&&(identical(other.keysConfirmed, keysConfirmed) || other.keysConfirmed == keysConfirmed)&&(identical(other.financeConfirmed, financeConfirmed) || other.financeConfirmed == financeConfirmed)&&(identical(other.runningConditionConfirmed, runningConditionConfirmed) || other.runningConditionConfirmed == runningConditionConfirmed)&&(identical(other.mechanicalIssuesConfirmed, mechanicalIssuesConfirmed) || other.mechanicalIssuesConfirmed == mechanicalIssuesConfirmed)&&(identical(other.photosConfirmed, photosConfirmed) || other.photosConfirmed == photosConfirmed)&&(identical(other.interiorPhotosConfirmed, interiorPhotosConfirmed) || other.interiorPhotosConfirmed == interiorPhotosConfirmed)&&(identical(other.wheelsPhotosConfirmed, wheelsPhotosConfirmed) || other.wheelsPhotosConfirmed == wheelsPhotosConfirmed)&&(identical(other.tireConditionConfirmed, tireConditionConfirmed) || other.tireConditionConfirmed == tireConditionConfirmed)&&(identical(other.conditionDamageConfirmed, conditionDamageConfirmed) || other.conditionDamageConfirmed == conditionDamageConfirmed)&&(identical(other.serviceHistoryConfirmed, serviceHistoryConfirmed) || other.serviceHistoryConfirmed == serviceHistoryConfirmed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,vehicle,mileage,const DeepCollectionEquality().hash(_extraFeatures),numberOfKeys,hasFinance,runningCondition,const DeepCollectionEquality().hash(_mechanicalIssues),const DeepCollectionEquality().hash(_exteriorPhotos),const DeepCollectionEquality().hash(_exteriorPhotosMap),const DeepCollectionEquality().hash(_interiorPhotos),const DeepCollectionEquality().hash(_interiorPhotosMap),const DeepCollectionEquality().hash(_damagePhotos),const DeepCollectionEquality().hash(_wheelsPhotosMap),tireCondition,seatMaterial,seatMaterialConfirmed,const DeepCollectionEquality().hash(_paintworkMarks),paintworkConfirmed,const DeepCollectionEquality().hash(_brokenFittingsPhotos),hasBrokenFittings,brokenFittingsConfirmed,const DeepCollectionEquality().hash(_wheelDamageMap),wheelDamageConfirmed,hasToolPack,toolPackConfirmed,hasLockingWheelNut,lockingWheelNutConfirmed,const DeepCollectionEquality().hash(_damages),serviceHistoryType,const DeepCollectionEquality().hash(_serviceDocuments),hasProofOfPurchase,proofOfPurchaseConfirmed,hasBeenSmokedIn,smokingConfirmed,hasPrivatePlate,privatePlateConfirmed,submissionStatus,vehicleDetailsConfirmed,extraFeaturesConfirmed,keysConfirmed,financeConfirmed,runningConditionConfirmed,mechanicalIssuesConfirmed,photosConfirmed,interiorPhotosConfirmed,wheelsPhotosConfirmed,tireConditionConfirmed,conditionDamageConfirmed,serviceHistoryConfirmed]);
}

@override
String toString() {
    return 'VehicleRegistrationState(vehicle: $vehicle, mileage: $mileage, extraFeatures: $extraFeatures, numberOfKeys: $numberOfKeys, hasFinance: $hasFinance, runningCondition: $runningCondition, mechanicalIssues: $mechanicalIssues, exteriorPhotos: $exteriorPhotos, exteriorPhotosMap: $exteriorPhotosMap, interiorPhotos: $interiorPhotos, interiorPhotosMap: $interiorPhotosMap, damagePhotos: $damagePhotos, wheelsPhotosMap: $wheelsPhotosMap, tireCondition: $tireCondition, seatMaterial: $seatMaterial, seatMaterialConfirmed: $seatMaterialConfirmed, paintworkMarks: $paintworkMarks, paintworkConfirmed: $paintworkConfirmed, brokenFittingsPhotos: $brokenFittingsPhotos, hasBrokenFittings: $hasBrokenFittings, brokenFittingsConfirmed: $brokenFittingsConfirmed, wheelDamageMap: $wheelDamageMap, wheelDamageConfirmed: $wheelDamageConfirmed, hasToolPack: $hasToolPack, toolPackConfirmed: $toolPackConfirmed, hasLockingWheelNut: $hasLockingWheelNut, lockingWheelNutConfirmed: $lockingWheelNutConfirmed, damages: $damages, serviceHistoryType: $serviceHistoryType, serviceDocuments: $serviceDocuments, hasProofOfPurchase: $hasProofOfPurchase, proofOfPurchaseConfirmed: $proofOfPurchaseConfirmed, hasBeenSmokedIn: $hasBeenSmokedIn, smokingConfirmed: $smokingConfirmed, hasPrivatePlate: $hasPrivatePlate, privatePlateConfirmed: $privatePlateConfirmed, submissionStatus: $submissionStatus, vehicleDetailsConfirmed: $vehicleDetailsConfirmed, extraFeaturesConfirmed: $extraFeaturesConfirmed, keysConfirmed: $keysConfirmed, financeConfirmed: $financeConfirmed, runningConditionConfirmed: $runningConditionConfirmed, mechanicalIssuesConfirmed: $mechanicalIssuesConfirmed, photosConfirmed: $photosConfirmed, interiorPhotosConfirmed: $interiorPhotosConfirmed, wheelsPhotosConfirmed: $wheelsPhotosConfirmed, tireConditionConfirmed: $tireConditionConfirmed, conditionDamageConfirmed: $conditionDamageConfirmed, serviceHistoryConfirmed: $serviceHistoryConfirmed)';
}


}

/// @nodoc
abstract mixin class _$VehicleRegistrationStateCopyWith<$Res> implements $VehicleRegistrationStateCopyWith<$Res> {
  factory _$VehicleRegistrationStateCopyWith(_VehicleRegistrationState value, $Res Function(_VehicleRegistrationState) _then) = __$VehicleRegistrationStateCopyWithImpl;
@override @useResult
$Res call({
 Vehicle? vehicle, double mileage, List<String> extraFeatures, int numberOfKeys, bool hasFinance, RunningCondition? runningCondition, List<String> mechanicalIssues, List<String> exteriorPhotos, Map<String, String> exteriorPhotosMap, List<String> interiorPhotos, Map<String, String> interiorPhotosMap, List<String> damagePhotos, Map<String, String> wheelsPhotosMap, String? tireCondition, String? seatMaterial, bool seatMaterialConfirmed, List<PaintworkMark> paintworkMarks, bool paintworkConfirmed, List<String> brokenFittingsPhotos, bool hasBrokenFittings, bool brokenFittingsConfirmed, Map<String, bool> wheelDamageMap, bool wheelDamageConfirmed, bool hasToolPack, bool toolPackConfirmed, bool hasLockingWheelNut, bool lockingWheelNutConfirmed, List<DamageItem> damages, ServiceHistoryType? serviceHistoryType, List<String> serviceDocuments, bool hasProofOfPurchase, bool proofOfPurchaseConfirmed, bool hasBeenSmokedIn, bool smokingConfirmed, bool hasPrivatePlate, bool privatePlateConfirmed, SubmissionStatus submissionStatus, bool vehicleDetailsConfirmed, bool extraFeaturesConfirmed, bool keysConfirmed, bool financeConfirmed, bool runningConditionConfirmed, bool mechanicalIssuesConfirmed, bool photosConfirmed, bool interiorPhotosConfirmed, bool wheelsPhotosConfirmed, bool tireConditionConfirmed, bool conditionDamageConfirmed, bool serviceHistoryConfirmed
});


@override $VehicleCopyWith<$Res>? get vehicle;

}
/// @nodoc
class __$VehicleRegistrationStateCopyWithImpl<$Res>
    implements _$VehicleRegistrationStateCopyWith<$Res> {
  __$VehicleRegistrationStateCopyWithImpl(this._self, this._then);

  final _VehicleRegistrationState _self;
  final $Res Function(_VehicleRegistrationState) _then;

/// Create a copy of VehicleRegistrationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vehicle = freezed,Object? mileage = null,Object? extraFeatures = null,Object? numberOfKeys = null,Object? hasFinance = null,Object? runningCondition = freezed,Object? mechanicalIssues = null,Object? exteriorPhotos = null,Object? exteriorPhotosMap = null,Object? interiorPhotos = null,Object? interiorPhotosMap = null,Object? damagePhotos = null,Object? wheelsPhotosMap = null,Object? tireCondition = freezed,Object? seatMaterial = freezed,Object? seatMaterialConfirmed = null,Object? paintworkMarks = null,Object? paintworkConfirmed = null,Object? brokenFittingsPhotos = null,Object? hasBrokenFittings = null,Object? brokenFittingsConfirmed = null,Object? wheelDamageMap = null,Object? wheelDamageConfirmed = null,Object? hasToolPack = null,Object? toolPackConfirmed = null,Object? hasLockingWheelNut = null,Object? lockingWheelNutConfirmed = null,Object? damages = null,Object? serviceHistoryType = freezed,Object? serviceDocuments = null,Object? hasProofOfPurchase = null,Object? proofOfPurchaseConfirmed = null,Object? hasBeenSmokedIn = null,Object? smokingConfirmed = null,Object? hasPrivatePlate = null,Object? privatePlateConfirmed = null,Object? submissionStatus = null,Object? vehicleDetailsConfirmed = null,Object? extraFeaturesConfirmed = null,Object? keysConfirmed = null,Object? financeConfirmed = null,Object? runningConditionConfirmed = null,Object? mechanicalIssuesConfirmed = null,Object? photosConfirmed = null,Object? interiorPhotosConfirmed = null,Object? wheelsPhotosConfirmed = null,Object? tireConditionConfirmed = null,Object? conditionDamageConfirmed = null,Object? serviceHistoryConfirmed = null,}) {
  return _then(_VehicleRegistrationState(
vehicle: freezed == vehicle ? _self.vehicle : vehicle // ignore: cast_nullable_to_non_nullable
as Vehicle?,mileage: null == mileage ? _self.mileage : mileage // ignore: cast_nullable_to_non_nullable
as double,extraFeatures: null == extraFeatures ? _self._extraFeatures : extraFeatures // ignore: cast_nullable_to_non_nullable
as List<String>,numberOfKeys: null == numberOfKeys ? _self.numberOfKeys : numberOfKeys // ignore: cast_nullable_to_non_nullable
as int,hasFinance: null == hasFinance ? _self.hasFinance : hasFinance // ignore: cast_nullable_to_non_nullable
as bool,runningCondition: freezed == runningCondition ? _self.runningCondition : runningCondition // ignore: cast_nullable_to_non_nullable
as RunningCondition?,mechanicalIssues: null == mechanicalIssues ? _self._mechanicalIssues : mechanicalIssues // ignore: cast_nullable_to_non_nullable
as List<String>,exteriorPhotos: null == exteriorPhotos ? _self._exteriorPhotos : exteriorPhotos // ignore: cast_nullable_to_non_nullable
as List<String>,exteriorPhotosMap: null == exteriorPhotosMap ? _self._exteriorPhotosMap : exteriorPhotosMap // ignore: cast_nullable_to_non_nullable
as Map<String, String>,interiorPhotos: null == interiorPhotos ? _self._interiorPhotos : interiorPhotos // ignore: cast_nullable_to_non_nullable
as List<String>,interiorPhotosMap: null == interiorPhotosMap ? _self._interiorPhotosMap : interiorPhotosMap // ignore: cast_nullable_to_non_nullable
as Map<String, String>,damagePhotos: null == damagePhotos ? _self._damagePhotos : damagePhotos // ignore: cast_nullable_to_non_nullable
as List<String>,wheelsPhotosMap: null == wheelsPhotosMap ? _self._wheelsPhotosMap : wheelsPhotosMap // ignore: cast_nullable_to_non_nullable
as Map<String, String>,tireCondition: freezed == tireCondition ? _self.tireCondition : tireCondition // ignore: cast_nullable_to_non_nullable
as String?,seatMaterial: freezed == seatMaterial ? _self.seatMaterial : seatMaterial // ignore: cast_nullable_to_non_nullable
as String?,seatMaterialConfirmed: null == seatMaterialConfirmed ? _self.seatMaterialConfirmed : seatMaterialConfirmed // ignore: cast_nullable_to_non_nullable
as bool,paintworkMarks: null == paintworkMarks ? _self._paintworkMarks : paintworkMarks // ignore: cast_nullable_to_non_nullable
as List<PaintworkMark>,paintworkConfirmed: null == paintworkConfirmed ? _self.paintworkConfirmed : paintworkConfirmed // ignore: cast_nullable_to_non_nullable
as bool,brokenFittingsPhotos: null == brokenFittingsPhotos ? _self._brokenFittingsPhotos : brokenFittingsPhotos // ignore: cast_nullable_to_non_nullable
as List<String>,hasBrokenFittings: null == hasBrokenFittings ? _self.hasBrokenFittings : hasBrokenFittings // ignore: cast_nullable_to_non_nullable
as bool,brokenFittingsConfirmed: null == brokenFittingsConfirmed ? _self.brokenFittingsConfirmed : brokenFittingsConfirmed // ignore: cast_nullable_to_non_nullable
as bool,wheelDamageMap: null == wheelDamageMap ? _self._wheelDamageMap : wheelDamageMap // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,wheelDamageConfirmed: null == wheelDamageConfirmed ? _self.wheelDamageConfirmed : wheelDamageConfirmed // ignore: cast_nullable_to_non_nullable
as bool,hasToolPack: null == hasToolPack ? _self.hasToolPack : hasToolPack // ignore: cast_nullable_to_non_nullable
as bool,toolPackConfirmed: null == toolPackConfirmed ? _self.toolPackConfirmed : toolPackConfirmed // ignore: cast_nullable_to_non_nullable
as bool,hasLockingWheelNut: null == hasLockingWheelNut ? _self.hasLockingWheelNut : hasLockingWheelNut // ignore: cast_nullable_to_non_nullable
as bool,lockingWheelNutConfirmed: null == lockingWheelNutConfirmed ? _self.lockingWheelNutConfirmed : lockingWheelNutConfirmed // ignore: cast_nullable_to_non_nullable
as bool,damages: null == damages ? _self._damages : damages // ignore: cast_nullable_to_non_nullable
as List<DamageItem>,serviceHistoryType: freezed == serviceHistoryType ? _self.serviceHistoryType : serviceHistoryType // ignore: cast_nullable_to_non_nullable
as ServiceHistoryType?,serviceDocuments: null == serviceDocuments ? _self._serviceDocuments : serviceDocuments // ignore: cast_nullable_to_non_nullable
as List<String>,hasProofOfPurchase: null == hasProofOfPurchase ? _self.hasProofOfPurchase : hasProofOfPurchase // ignore: cast_nullable_to_non_nullable
as bool,proofOfPurchaseConfirmed: null == proofOfPurchaseConfirmed ? _self.proofOfPurchaseConfirmed : proofOfPurchaseConfirmed // ignore: cast_nullable_to_non_nullable
as bool,hasBeenSmokedIn: null == hasBeenSmokedIn ? _self.hasBeenSmokedIn : hasBeenSmokedIn // ignore: cast_nullable_to_non_nullable
as bool,smokingConfirmed: null == smokingConfirmed ? _self.smokingConfirmed : smokingConfirmed // ignore: cast_nullable_to_non_nullable
as bool,hasPrivatePlate: null == hasPrivatePlate ? _self.hasPrivatePlate : hasPrivatePlate // ignore: cast_nullable_to_non_nullable
as bool,privatePlateConfirmed: null == privatePlateConfirmed ? _self.privatePlateConfirmed : privatePlateConfirmed // ignore: cast_nullable_to_non_nullable
as bool,submissionStatus: null == submissionStatus ? _self.submissionStatus : submissionStatus // ignore: cast_nullable_to_non_nullable
as SubmissionStatus,vehicleDetailsConfirmed: null == vehicleDetailsConfirmed ? _self.vehicleDetailsConfirmed : vehicleDetailsConfirmed // ignore: cast_nullable_to_non_nullable
as bool,extraFeaturesConfirmed: null == extraFeaturesConfirmed ? _self.extraFeaturesConfirmed : extraFeaturesConfirmed // ignore: cast_nullable_to_non_nullable
as bool,keysConfirmed: null == keysConfirmed ? _self.keysConfirmed : keysConfirmed // ignore: cast_nullable_to_non_nullable
as bool,financeConfirmed: null == financeConfirmed ? _self.financeConfirmed : financeConfirmed // ignore: cast_nullable_to_non_nullable
as bool,runningConditionConfirmed: null == runningConditionConfirmed ? _self.runningConditionConfirmed : runningConditionConfirmed // ignore: cast_nullable_to_non_nullable
as bool,mechanicalIssuesConfirmed: null == mechanicalIssuesConfirmed ? _self.mechanicalIssuesConfirmed : mechanicalIssuesConfirmed // ignore: cast_nullable_to_non_nullable
as bool,photosConfirmed: null == photosConfirmed ? _self.photosConfirmed : photosConfirmed // ignore: cast_nullable_to_non_nullable
as bool,interiorPhotosConfirmed: null == interiorPhotosConfirmed ? _self.interiorPhotosConfirmed : interiorPhotosConfirmed // ignore: cast_nullable_to_non_nullable
as bool,wheelsPhotosConfirmed: null == wheelsPhotosConfirmed ? _self.wheelsPhotosConfirmed : wheelsPhotosConfirmed // ignore: cast_nullable_to_non_nullable
as bool,tireConditionConfirmed: null == tireConditionConfirmed ? _self.tireConditionConfirmed : tireConditionConfirmed // ignore: cast_nullable_to_non_nullable
as bool,conditionDamageConfirmed: null == conditionDamageConfirmed ? _self.conditionDamageConfirmed : conditionDamageConfirmed // ignore: cast_nullable_to_non_nullable
as bool,serviceHistoryConfirmed: null == serviceHistoryConfirmed ? _self.serviceHistoryConfirmed : serviceHistoryConfirmed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of VehicleRegistrationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VehicleCopyWith<$Res>? get vehicle {
    if (_self.vehicle == null) {
    return null;
  }

  return $VehicleCopyWith<$Res>(_self.vehicle!, (value) {
    return _then(_self.copyWith(vehicle: value));
  });
}
}


/// @nodoc
mixin _$DamageItem {

 String get id; String get type; String get location; String? get description; String? get photoPath;
/// Create a copy of DamageItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DamageItemCopyWith<DamageItem> get copyWith => _$DamageItemCopyWithImpl<DamageItem>(this as DamageItem, _$identity);

  /// Serializes this DamageItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DamageItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DamageItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.location, _this.location) || other.location == _this.location)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.photoPath, _this.photoPath) || other.photoPath == _this.photoPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DamageItem;
  return Object.hash(runtimeType,_this.id,_this.type,_this.location,_this.description,_this.photoPath);
}

@override
String toString() {
  final _this = this as DamageItem;
  return 'DamageItem(id: ${_this.id}, type: ${_this.type}, location: ${_this.location}, description: ${_this.description}, photoPath: ${_this.photoPath})';
}


}

/// @nodoc
abstract mixin class $DamageItemCopyWith<$Res>  {
  factory $DamageItemCopyWith(DamageItem value, $Res Function(DamageItem) _then) = _$DamageItemCopyWithImpl;
@useResult
$Res call({
 String id, String type, String location, String? description, String? photoPath
});




}
/// @nodoc
class _$DamageItemCopyWithImpl<$Res>
    implements $DamageItemCopyWith<$Res> {
  _$DamageItemCopyWithImpl(this._self, this._then);

  final DamageItem _self;
  final $Res Function(DamageItem) _then;

/// Create a copy of DamageItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? location = null,Object? description = freezed,Object? photoPath = freezed,}) {
  return _then(DamageItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DamageItem].
extension DamageItemPatterns on DamageItem {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DamageItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DamageItem() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DamageItem value)  $default,){
final _that = this;
switch (_that) {
case _DamageItem():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DamageItem value)?  $default,){
final _that = this;
switch (_that) {
case _DamageItem() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  String location,  String? description,  String? photoPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DamageItem() when $default != null:
return $default(_that.id,_that.type,_that.location,_that.description,_that.photoPath);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  String location,  String? description,  String? photoPath)  $default,) {final _that = this;
switch (_that) {
case _DamageItem():
return $default(_that.id,_that.type,_that.location,_that.description,_that.photoPath);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  String location,  String? description,  String? photoPath)?  $default,) {final _that = this;
switch (_that) {
case _DamageItem() when $default != null:
return $default(_that.id,_that.type,_that.location,_that.description,_that.photoPath);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DamageItem implements DamageItem {
  const _DamageItem({required this.id, required this.type, required this.location, this.description, this.photoPath});
  factory _DamageItem.fromJson(Map<String, dynamic> json) => _$DamageItemFromJson(json);

@override final  String id;
@override final  String type;
@override final  String location;
@override final  String? description;
@override final  String? photoPath;

/// Create a copy of DamageItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DamageItemCopyWith<_DamageItem> get copyWith => __$DamageItemCopyWithImpl<_DamageItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DamageItemToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DamageItem&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.location, location) || other.location == location)&&(identical(other.description, description) || other.description == description)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,type,location,description,photoPath);
}

@override
String toString() {
    return 'DamageItem(id: $id, type: $type, location: $location, description: $description, photoPath: $photoPath)';
}


}

/// @nodoc
abstract mixin class _$DamageItemCopyWith<$Res> implements $DamageItemCopyWith<$Res> {
  factory _$DamageItemCopyWith(_DamageItem value, $Res Function(_DamageItem) _then) = __$DamageItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, String location, String? description, String? photoPath
});




}
/// @nodoc
class __$DamageItemCopyWithImpl<$Res>
    implements _$DamageItemCopyWith<$Res> {
  __$DamageItemCopyWithImpl(this._self, this._then);

  final _DamageItem _self;
  final $Res Function(_DamageItem) _then;

/// Create a copy of DamageItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? location = null,Object? description = freezed,Object? photoPath = freezed,}) {
  return _then(_DamageItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PaintworkMark {

 String get id; String get view; double get x; double get y; String get size;
/// Create a copy of PaintworkMark
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaintworkMarkCopyWith<PaintworkMark> get copyWith => _$PaintworkMarkCopyWithImpl<PaintworkMark>(this as PaintworkMark, _$identity);

  /// Serializes this PaintworkMark to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PaintworkMark;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaintworkMark&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.view, _this.view) || other.view == _this.view)&&(identical(other.x, _this.x) || other.x == _this.x)&&(identical(other.y, _this.y) || other.y == _this.y)&&(identical(other.size, _this.size) || other.size == _this.size));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PaintworkMark;
  return Object.hash(runtimeType,_this.id,_this.view,_this.x,_this.y,_this.size);
}

@override
String toString() {
  final _this = this as PaintworkMark;
  return 'PaintworkMark(id: ${_this.id}, view: ${_this.view}, x: ${_this.x}, y: ${_this.y}, size: ${_this.size})';
}


}

/// @nodoc
abstract mixin class $PaintworkMarkCopyWith<$Res>  {
  factory $PaintworkMarkCopyWith(PaintworkMark value, $Res Function(PaintworkMark) _then) = _$PaintworkMarkCopyWithImpl;
@useResult
$Res call({
 String id, String view, double x, double y, String size
});




}
/// @nodoc
class _$PaintworkMarkCopyWithImpl<$Res>
    implements $PaintworkMarkCopyWith<$Res> {
  _$PaintworkMarkCopyWithImpl(this._self, this._then);

  final PaintworkMark _self;
  final $Res Function(PaintworkMark) _then;

/// Create a copy of PaintworkMark
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? view = null,Object? x = null,Object? y = null,Object? size = null,}) {
  return _then(PaintworkMark(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as String,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PaintworkMark].
extension PaintworkMarkPatterns on PaintworkMark {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaintworkMark value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaintworkMark() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaintworkMark value)  $default,){
final _that = this;
switch (_that) {
case _PaintworkMark():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaintworkMark value)?  $default,){
final _that = this;
switch (_that) {
case _PaintworkMark() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String view,  double x,  double y,  String size)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaintworkMark() when $default != null:
return $default(_that.id,_that.view,_that.x,_that.y,_that.size);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String view,  double x,  double y,  String size)  $default,) {final _that = this;
switch (_that) {
case _PaintworkMark():
return $default(_that.id,_that.view,_that.x,_that.y,_that.size);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String view,  double x,  double y,  String size)?  $default,) {final _that = this;
switch (_that) {
case _PaintworkMark() when $default != null:
return $default(_that.id,_that.view,_that.x,_that.y,_that.size);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaintworkMark implements PaintworkMark {
  const _PaintworkMark({required this.id, required this.view, required this.x, required this.y, required this.size});
  factory _PaintworkMark.fromJson(Map<String, dynamic> json) => _$PaintworkMarkFromJson(json);

@override final  String id;
@override final  String view;
@override final  double x;
@override final  double y;
@override final  String size;

/// Create a copy of PaintworkMark
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaintworkMarkCopyWith<_PaintworkMark> get copyWith => __$PaintworkMarkCopyWithImpl<_PaintworkMark>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaintworkMarkToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaintworkMark&&(identical(other.id, id) || other.id == id)&&(identical(other.view, view) || other.view == view)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.size, size) || other.size == size));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,view,x,y,size);
}

@override
String toString() {
    return 'PaintworkMark(id: $id, view: $view, x: $x, y: $y, size: $size)';
}


}

/// @nodoc
abstract mixin class _$PaintworkMarkCopyWith<$Res> implements $PaintworkMarkCopyWith<$Res> {
  factory _$PaintworkMarkCopyWith(_PaintworkMark value, $Res Function(_PaintworkMark) _then) = __$PaintworkMarkCopyWithImpl;
@override @useResult
$Res call({
 String id, String view, double x, double y, String size
});




}
/// @nodoc
class __$PaintworkMarkCopyWithImpl<$Res>
    implements _$PaintworkMarkCopyWith<$Res> {
  __$PaintworkMarkCopyWithImpl(this._self, this._then);

  final _PaintworkMark _self;
  final $Res Function(_PaintworkMark) _then;

/// Create a copy of PaintworkMark
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? view = null,Object? x = null,Object? y = null,Object? size = null,}) {
  return _then(_PaintworkMark(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as String,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
