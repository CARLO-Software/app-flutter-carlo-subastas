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

 Vehicle? get vehicle; double get mileage; List<String> get extraFeatures; int get numberOfKeys; bool get hasFinance; RunningCondition? get runningCondition; List<String> get mechanicalIssues; List<String> get exteriorPhotos; Map<String, String> get exteriorPhotosMap; List<String> get interiorPhotos; Map<String, String> get interiorPhotosMap; List<String> get damagePhotos; Map<String, String> get wheelsPhotosMap; Map<String, String> get tirePhotosMap; bool get tirePhotosConfirmed; Map<String, bool> get tireDamageMap; String? get tireCondition; String? get seatMaterial; bool get seatMaterialConfirmed; List<PaintworkMark> get paintworkMarks; bool get paintworkConfirmed; List<String> get brokenFittingsPhotos; List<BrokenFittingMark> get brokenFittingMarks; bool get hasBrokenFittings; bool get brokenFittingsConfirmed; Map<String, bool> get wheelDamageMap; bool get wheelDamageConfirmed; bool get hasToolPack; String? get toolPackOption; bool get toolPackConfirmed; String? get parcelShelfOption; bool get parcelShelfConfirmed; List<String> get bonusPhotos; bool get bonusPhotosConfirmed; bool get serviceHistoryInfoSeen; List<String> get serviceHistoryPhotos; bool get noServiceHistory; bool get serviceHistoryUploadConfirmed; String? get v5cLogBookOption; bool get v5cLogBookConfirmed; String? get registeredKeeperOption; bool get registeredKeeperConfirmed; String get ownerFullName; bool get ownerNameConfirmed; String get phoneNumber; bool get phoneConfirmed; String get collectionAddress; String get collectionAddressLine1; String get collectionAddressLine2; String get collectionAddressLine3; String get collectionCity; String get collectionPostcode; bool get collectionAddressConfirmed; bool get hasLockingWheelNut; String? get lockingWheelNutOption; bool get lockingWheelNutConfirmed; List<String> get warningLights; bool get warningLightsConfirmed; List<String> get chargingCables; bool get chargingCablesConfirmed; List<String> get interiorConditionIssues; bool get interiorConditionConfirmed; List<DamageItem> get damages; ServiceHistoryType? get serviceHistoryType; List<String> get serviceDocuments; bool get hasProofOfPurchase; bool get proofOfPurchaseConfirmed; bool get hasBeenSmokedIn; bool get smokingConfirmed; bool get hasPrivatePlate; bool get privatePlateConfirmed; SaleType? get saleType; SubmissionStatus get submissionStatus; bool get vehicleDetailsConfirmed; bool get extraFeaturesConfirmed; bool get keysConfirmed; bool get financeConfirmed; bool get runningConditionConfirmed; bool get mechanicalIssuesConfirmed; bool get photosConfirmed; bool get interiorPhotosConfirmed; bool get wheelsPhotosConfirmed; bool get tireConditionConfirmed; bool get conditionDamageConfirmed; bool get serviceHistoryConfirmed;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehicleRegistrationState&&(identical(other.vehicle, _this.vehicle) || other.vehicle == _this.vehicle)&&(identical(other.mileage, _this.mileage) || other.mileage == _this.mileage)&&const DeepCollectionEquality().equals(other.extraFeatures, _this.extraFeatures)&&(identical(other.numberOfKeys, _this.numberOfKeys) || other.numberOfKeys == _this.numberOfKeys)&&(identical(other.hasFinance, _this.hasFinance) || other.hasFinance == _this.hasFinance)&&(identical(other.runningCondition, _this.runningCondition) || other.runningCondition == _this.runningCondition)&&const DeepCollectionEquality().equals(other.mechanicalIssues, _this.mechanicalIssues)&&const DeepCollectionEquality().equals(other.exteriorPhotos, _this.exteriorPhotos)&&const DeepCollectionEquality().equals(other.exteriorPhotosMap, _this.exteriorPhotosMap)&&const DeepCollectionEquality().equals(other.interiorPhotos, _this.interiorPhotos)&&const DeepCollectionEquality().equals(other.interiorPhotosMap, _this.interiorPhotosMap)&&const DeepCollectionEquality().equals(other.damagePhotos, _this.damagePhotos)&&const DeepCollectionEquality().equals(other.wheelsPhotosMap, _this.wheelsPhotosMap)&&const DeepCollectionEquality().equals(other.tirePhotosMap, _this.tirePhotosMap)&&(identical(other.tirePhotosConfirmed, _this.tirePhotosConfirmed) || other.tirePhotosConfirmed == _this.tirePhotosConfirmed)&&const DeepCollectionEquality().equals(other.tireDamageMap, _this.tireDamageMap)&&(identical(other.tireCondition, _this.tireCondition) || other.tireCondition == _this.tireCondition)&&(identical(other.seatMaterial, _this.seatMaterial) || other.seatMaterial == _this.seatMaterial)&&(identical(other.seatMaterialConfirmed, _this.seatMaterialConfirmed) || other.seatMaterialConfirmed == _this.seatMaterialConfirmed)&&const DeepCollectionEquality().equals(other.paintworkMarks, _this.paintworkMarks)&&(identical(other.paintworkConfirmed, _this.paintworkConfirmed) || other.paintworkConfirmed == _this.paintworkConfirmed)&&const DeepCollectionEquality().equals(other.brokenFittingsPhotos, _this.brokenFittingsPhotos)&&const DeepCollectionEquality().equals(other.brokenFittingMarks, _this.brokenFittingMarks)&&(identical(other.hasBrokenFittings, _this.hasBrokenFittings) || other.hasBrokenFittings == _this.hasBrokenFittings)&&(identical(other.brokenFittingsConfirmed, _this.brokenFittingsConfirmed) || other.brokenFittingsConfirmed == _this.brokenFittingsConfirmed)&&const DeepCollectionEquality().equals(other.wheelDamageMap, _this.wheelDamageMap)&&(identical(other.wheelDamageConfirmed, _this.wheelDamageConfirmed) || other.wheelDamageConfirmed == _this.wheelDamageConfirmed)&&(identical(other.hasToolPack, _this.hasToolPack) || other.hasToolPack == _this.hasToolPack)&&(identical(other.toolPackOption, _this.toolPackOption) || other.toolPackOption == _this.toolPackOption)&&(identical(other.toolPackConfirmed, _this.toolPackConfirmed) || other.toolPackConfirmed == _this.toolPackConfirmed)&&(identical(other.parcelShelfOption, _this.parcelShelfOption) || other.parcelShelfOption == _this.parcelShelfOption)&&(identical(other.parcelShelfConfirmed, _this.parcelShelfConfirmed) || other.parcelShelfConfirmed == _this.parcelShelfConfirmed)&&const DeepCollectionEquality().equals(other.bonusPhotos, _this.bonusPhotos)&&(identical(other.bonusPhotosConfirmed, _this.bonusPhotosConfirmed) || other.bonusPhotosConfirmed == _this.bonusPhotosConfirmed)&&(identical(other.serviceHistoryInfoSeen, _this.serviceHistoryInfoSeen) || other.serviceHistoryInfoSeen == _this.serviceHistoryInfoSeen)&&const DeepCollectionEquality().equals(other.serviceHistoryPhotos, _this.serviceHistoryPhotos)&&(identical(other.noServiceHistory, _this.noServiceHistory) || other.noServiceHistory == _this.noServiceHistory)&&(identical(other.serviceHistoryUploadConfirmed, _this.serviceHistoryUploadConfirmed) || other.serviceHistoryUploadConfirmed == _this.serviceHistoryUploadConfirmed)&&(identical(other.v5cLogBookOption, _this.v5cLogBookOption) || other.v5cLogBookOption == _this.v5cLogBookOption)&&(identical(other.v5cLogBookConfirmed, _this.v5cLogBookConfirmed) || other.v5cLogBookConfirmed == _this.v5cLogBookConfirmed)&&(identical(other.registeredKeeperOption, _this.registeredKeeperOption) || other.registeredKeeperOption == _this.registeredKeeperOption)&&(identical(other.registeredKeeperConfirmed, _this.registeredKeeperConfirmed) || other.registeredKeeperConfirmed == _this.registeredKeeperConfirmed)&&(identical(other.ownerFullName, _this.ownerFullName) || other.ownerFullName == _this.ownerFullName)&&(identical(other.ownerNameConfirmed, _this.ownerNameConfirmed) || other.ownerNameConfirmed == _this.ownerNameConfirmed)&&(identical(other.phoneNumber, _this.phoneNumber) || other.phoneNumber == _this.phoneNumber)&&(identical(other.phoneConfirmed, _this.phoneConfirmed) || other.phoneConfirmed == _this.phoneConfirmed)&&(identical(other.collectionAddress, _this.collectionAddress) || other.collectionAddress == _this.collectionAddress)&&(identical(other.collectionAddressLine1, _this.collectionAddressLine1) || other.collectionAddressLine1 == _this.collectionAddressLine1)&&(identical(other.collectionAddressLine2, _this.collectionAddressLine2) || other.collectionAddressLine2 == _this.collectionAddressLine2)&&(identical(other.collectionAddressLine3, _this.collectionAddressLine3) || other.collectionAddressLine3 == _this.collectionAddressLine3)&&(identical(other.collectionCity, _this.collectionCity) || other.collectionCity == _this.collectionCity)&&(identical(other.collectionPostcode, _this.collectionPostcode) || other.collectionPostcode == _this.collectionPostcode)&&(identical(other.collectionAddressConfirmed, _this.collectionAddressConfirmed) || other.collectionAddressConfirmed == _this.collectionAddressConfirmed)&&(identical(other.hasLockingWheelNut, _this.hasLockingWheelNut) || other.hasLockingWheelNut == _this.hasLockingWheelNut)&&(identical(other.lockingWheelNutOption, _this.lockingWheelNutOption) || other.lockingWheelNutOption == _this.lockingWheelNutOption)&&(identical(other.lockingWheelNutConfirmed, _this.lockingWheelNutConfirmed) || other.lockingWheelNutConfirmed == _this.lockingWheelNutConfirmed)&&const DeepCollectionEquality().equals(other.warningLights, _this.warningLights)&&(identical(other.warningLightsConfirmed, _this.warningLightsConfirmed) || other.warningLightsConfirmed == _this.warningLightsConfirmed)&&const DeepCollectionEquality().equals(other.chargingCables, _this.chargingCables)&&(identical(other.chargingCablesConfirmed, _this.chargingCablesConfirmed) || other.chargingCablesConfirmed == _this.chargingCablesConfirmed)&&const DeepCollectionEquality().equals(other.interiorConditionIssues, _this.interiorConditionIssues)&&(identical(other.interiorConditionConfirmed, _this.interiorConditionConfirmed) || other.interiorConditionConfirmed == _this.interiorConditionConfirmed)&&const DeepCollectionEquality().equals(other.damages, _this.damages)&&(identical(other.serviceHistoryType, _this.serviceHistoryType) || other.serviceHistoryType == _this.serviceHistoryType)&&const DeepCollectionEquality().equals(other.serviceDocuments, _this.serviceDocuments)&&(identical(other.hasProofOfPurchase, _this.hasProofOfPurchase) || other.hasProofOfPurchase == _this.hasProofOfPurchase)&&(identical(other.proofOfPurchaseConfirmed, _this.proofOfPurchaseConfirmed) || other.proofOfPurchaseConfirmed == _this.proofOfPurchaseConfirmed)&&(identical(other.hasBeenSmokedIn, _this.hasBeenSmokedIn) || other.hasBeenSmokedIn == _this.hasBeenSmokedIn)&&(identical(other.smokingConfirmed, _this.smokingConfirmed) || other.smokingConfirmed == _this.smokingConfirmed)&&(identical(other.hasPrivatePlate, _this.hasPrivatePlate) || other.hasPrivatePlate == _this.hasPrivatePlate)&&(identical(other.privatePlateConfirmed, _this.privatePlateConfirmed) || other.privatePlateConfirmed == _this.privatePlateConfirmed)&&(identical(other.saleType, _this.saleType) || other.saleType == _this.saleType)&&(identical(other.submissionStatus, _this.submissionStatus) || other.submissionStatus == _this.submissionStatus)&&(identical(other.vehicleDetailsConfirmed, _this.vehicleDetailsConfirmed) || other.vehicleDetailsConfirmed == _this.vehicleDetailsConfirmed)&&(identical(other.extraFeaturesConfirmed, _this.extraFeaturesConfirmed) || other.extraFeaturesConfirmed == _this.extraFeaturesConfirmed)&&(identical(other.keysConfirmed, _this.keysConfirmed) || other.keysConfirmed == _this.keysConfirmed)&&(identical(other.financeConfirmed, _this.financeConfirmed) || other.financeConfirmed == _this.financeConfirmed)&&(identical(other.runningConditionConfirmed, _this.runningConditionConfirmed) || other.runningConditionConfirmed == _this.runningConditionConfirmed)&&(identical(other.mechanicalIssuesConfirmed, _this.mechanicalIssuesConfirmed) || other.mechanicalIssuesConfirmed == _this.mechanicalIssuesConfirmed)&&(identical(other.photosConfirmed, _this.photosConfirmed) || other.photosConfirmed == _this.photosConfirmed)&&(identical(other.interiorPhotosConfirmed, _this.interiorPhotosConfirmed) || other.interiorPhotosConfirmed == _this.interiorPhotosConfirmed)&&(identical(other.wheelsPhotosConfirmed, _this.wheelsPhotosConfirmed) || other.wheelsPhotosConfirmed == _this.wheelsPhotosConfirmed)&&(identical(other.tireConditionConfirmed, _this.tireConditionConfirmed) || other.tireConditionConfirmed == _this.tireConditionConfirmed)&&(identical(other.conditionDamageConfirmed, _this.conditionDamageConfirmed) || other.conditionDamageConfirmed == _this.conditionDamageConfirmed)&&(identical(other.serviceHistoryConfirmed, _this.serviceHistoryConfirmed) || other.serviceHistoryConfirmed == _this.serviceHistoryConfirmed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VehicleRegistrationState;
  return Object.hashAll([runtimeType,_this.vehicle,_this.mileage,const DeepCollectionEquality().hash(_this.extraFeatures),_this.numberOfKeys,_this.hasFinance,_this.runningCondition,const DeepCollectionEquality().hash(_this.mechanicalIssues),const DeepCollectionEquality().hash(_this.exteriorPhotos),const DeepCollectionEquality().hash(_this.exteriorPhotosMap),const DeepCollectionEquality().hash(_this.interiorPhotos),const DeepCollectionEquality().hash(_this.interiorPhotosMap),const DeepCollectionEquality().hash(_this.damagePhotos),const DeepCollectionEquality().hash(_this.wheelsPhotosMap),const DeepCollectionEquality().hash(_this.tirePhotosMap),_this.tirePhotosConfirmed,const DeepCollectionEquality().hash(_this.tireDamageMap),_this.tireCondition,_this.seatMaterial,_this.seatMaterialConfirmed,const DeepCollectionEquality().hash(_this.paintworkMarks),_this.paintworkConfirmed,const DeepCollectionEquality().hash(_this.brokenFittingsPhotos),const DeepCollectionEquality().hash(_this.brokenFittingMarks),_this.hasBrokenFittings,_this.brokenFittingsConfirmed,const DeepCollectionEquality().hash(_this.wheelDamageMap),_this.wheelDamageConfirmed,_this.hasToolPack,_this.toolPackOption,_this.toolPackConfirmed,_this.parcelShelfOption,_this.parcelShelfConfirmed,const DeepCollectionEquality().hash(_this.bonusPhotos),_this.bonusPhotosConfirmed,_this.serviceHistoryInfoSeen,const DeepCollectionEquality().hash(_this.serviceHistoryPhotos),_this.noServiceHistory,_this.serviceHistoryUploadConfirmed,_this.v5cLogBookOption,_this.v5cLogBookConfirmed,_this.registeredKeeperOption,_this.registeredKeeperConfirmed,_this.ownerFullName,_this.ownerNameConfirmed,_this.phoneNumber,_this.phoneConfirmed,_this.collectionAddress,_this.collectionAddressLine1,_this.collectionAddressLine2,_this.collectionAddressLine3,_this.collectionCity,_this.collectionPostcode,_this.collectionAddressConfirmed,_this.hasLockingWheelNut,_this.lockingWheelNutOption,_this.lockingWheelNutConfirmed,const DeepCollectionEquality().hash(_this.warningLights),_this.warningLightsConfirmed,const DeepCollectionEquality().hash(_this.chargingCables),_this.chargingCablesConfirmed,const DeepCollectionEquality().hash(_this.interiorConditionIssues),_this.interiorConditionConfirmed,const DeepCollectionEquality().hash(_this.damages),_this.serviceHistoryType,const DeepCollectionEquality().hash(_this.serviceDocuments),_this.hasProofOfPurchase,_this.proofOfPurchaseConfirmed,_this.hasBeenSmokedIn,_this.smokingConfirmed,_this.hasPrivatePlate,_this.privatePlateConfirmed,_this.saleType,_this.submissionStatus,_this.vehicleDetailsConfirmed,_this.extraFeaturesConfirmed,_this.keysConfirmed,_this.financeConfirmed,_this.runningConditionConfirmed,_this.mechanicalIssuesConfirmed,_this.photosConfirmed,_this.interiorPhotosConfirmed,_this.wheelsPhotosConfirmed,_this.tireConditionConfirmed,_this.conditionDamageConfirmed,_this.serviceHistoryConfirmed]);
}

@override
String toString() {
  final _this = this as VehicleRegistrationState;
  return 'VehicleRegistrationState(vehicle: ${_this.vehicle}, mileage: ${_this.mileage}, extraFeatures: ${_this.extraFeatures}, numberOfKeys: ${_this.numberOfKeys}, hasFinance: ${_this.hasFinance}, runningCondition: ${_this.runningCondition}, mechanicalIssues: ${_this.mechanicalIssues}, exteriorPhotos: ${_this.exteriorPhotos}, exteriorPhotosMap: ${_this.exteriorPhotosMap}, interiorPhotos: ${_this.interiorPhotos}, interiorPhotosMap: ${_this.interiorPhotosMap}, damagePhotos: ${_this.damagePhotos}, wheelsPhotosMap: ${_this.wheelsPhotosMap}, tirePhotosMap: ${_this.tirePhotosMap}, tirePhotosConfirmed: ${_this.tirePhotosConfirmed}, tireDamageMap: ${_this.tireDamageMap}, tireCondition: ${_this.tireCondition}, seatMaterial: ${_this.seatMaterial}, seatMaterialConfirmed: ${_this.seatMaterialConfirmed}, paintworkMarks: ${_this.paintworkMarks}, paintworkConfirmed: ${_this.paintworkConfirmed}, brokenFittingsPhotos: ${_this.brokenFittingsPhotos}, brokenFittingMarks: ${_this.brokenFittingMarks}, hasBrokenFittings: ${_this.hasBrokenFittings}, brokenFittingsConfirmed: ${_this.brokenFittingsConfirmed}, wheelDamageMap: ${_this.wheelDamageMap}, wheelDamageConfirmed: ${_this.wheelDamageConfirmed}, hasToolPack: ${_this.hasToolPack}, toolPackOption: ${_this.toolPackOption}, toolPackConfirmed: ${_this.toolPackConfirmed}, parcelShelfOption: ${_this.parcelShelfOption}, parcelShelfConfirmed: ${_this.parcelShelfConfirmed}, bonusPhotos: ${_this.bonusPhotos}, bonusPhotosConfirmed: ${_this.bonusPhotosConfirmed}, serviceHistoryInfoSeen: ${_this.serviceHistoryInfoSeen}, serviceHistoryPhotos: ${_this.serviceHistoryPhotos}, noServiceHistory: ${_this.noServiceHistory}, serviceHistoryUploadConfirmed: ${_this.serviceHistoryUploadConfirmed}, v5cLogBookOption: ${_this.v5cLogBookOption}, v5cLogBookConfirmed: ${_this.v5cLogBookConfirmed}, registeredKeeperOption: ${_this.registeredKeeperOption}, registeredKeeperConfirmed: ${_this.registeredKeeperConfirmed}, ownerFullName: ${_this.ownerFullName}, ownerNameConfirmed: ${_this.ownerNameConfirmed}, phoneNumber: ${_this.phoneNumber}, phoneConfirmed: ${_this.phoneConfirmed}, collectionAddress: ${_this.collectionAddress}, collectionAddressLine1: ${_this.collectionAddressLine1}, collectionAddressLine2: ${_this.collectionAddressLine2}, collectionAddressLine3: ${_this.collectionAddressLine3}, collectionCity: ${_this.collectionCity}, collectionPostcode: ${_this.collectionPostcode}, collectionAddressConfirmed: ${_this.collectionAddressConfirmed}, hasLockingWheelNut: ${_this.hasLockingWheelNut}, lockingWheelNutOption: ${_this.lockingWheelNutOption}, lockingWheelNutConfirmed: ${_this.lockingWheelNutConfirmed}, warningLights: ${_this.warningLights}, warningLightsConfirmed: ${_this.warningLightsConfirmed}, chargingCables: ${_this.chargingCables}, chargingCablesConfirmed: ${_this.chargingCablesConfirmed}, interiorConditionIssues: ${_this.interiorConditionIssues}, interiorConditionConfirmed: ${_this.interiorConditionConfirmed}, damages: ${_this.damages}, serviceHistoryType: ${_this.serviceHistoryType}, serviceDocuments: ${_this.serviceDocuments}, hasProofOfPurchase: ${_this.hasProofOfPurchase}, proofOfPurchaseConfirmed: ${_this.proofOfPurchaseConfirmed}, hasBeenSmokedIn: ${_this.hasBeenSmokedIn}, smokingConfirmed: ${_this.smokingConfirmed}, hasPrivatePlate: ${_this.hasPrivatePlate}, privatePlateConfirmed: ${_this.privatePlateConfirmed}, saleType: ${_this.saleType}, submissionStatus: ${_this.submissionStatus}, vehicleDetailsConfirmed: ${_this.vehicleDetailsConfirmed}, extraFeaturesConfirmed: ${_this.extraFeaturesConfirmed}, keysConfirmed: ${_this.keysConfirmed}, financeConfirmed: ${_this.financeConfirmed}, runningConditionConfirmed: ${_this.runningConditionConfirmed}, mechanicalIssuesConfirmed: ${_this.mechanicalIssuesConfirmed}, photosConfirmed: ${_this.photosConfirmed}, interiorPhotosConfirmed: ${_this.interiorPhotosConfirmed}, wheelsPhotosConfirmed: ${_this.wheelsPhotosConfirmed}, tireConditionConfirmed: ${_this.tireConditionConfirmed}, conditionDamageConfirmed: ${_this.conditionDamageConfirmed}, serviceHistoryConfirmed: ${_this.serviceHistoryConfirmed})';
}


}

/// @nodoc
abstract mixin class $VehicleRegistrationStateCopyWith<$Res>  {
  factory $VehicleRegistrationStateCopyWith(VehicleRegistrationState value, $Res Function(VehicleRegistrationState) _then) = _$VehicleRegistrationStateCopyWithImpl;
@useResult
$Res call({
 Vehicle? vehicle, double mileage, List<String> extraFeatures, int numberOfKeys, bool hasFinance, RunningCondition? runningCondition, List<String> mechanicalIssues, List<String> exteriorPhotos, Map<String, String> exteriorPhotosMap, List<String> interiorPhotos, Map<String, String> interiorPhotosMap, List<String> damagePhotos, Map<String, String> wheelsPhotosMap, Map<String, String> tirePhotosMap, bool tirePhotosConfirmed, Map<String, bool> tireDamageMap, String? tireCondition, String? seatMaterial, bool seatMaterialConfirmed, List<PaintworkMark> paintworkMarks, bool paintworkConfirmed, List<String> brokenFittingsPhotos, List<BrokenFittingMark> brokenFittingMarks, bool hasBrokenFittings, bool brokenFittingsConfirmed, Map<String, bool> wheelDamageMap, bool wheelDamageConfirmed, bool hasToolPack, String? toolPackOption, bool toolPackConfirmed, String? parcelShelfOption, bool parcelShelfConfirmed, List<String> bonusPhotos, bool bonusPhotosConfirmed, bool serviceHistoryInfoSeen, List<String> serviceHistoryPhotos, bool noServiceHistory, bool serviceHistoryUploadConfirmed, String? v5cLogBookOption, bool v5cLogBookConfirmed, String? registeredKeeperOption, bool registeredKeeperConfirmed, String ownerFullName, bool ownerNameConfirmed, String phoneNumber, bool phoneConfirmed, String collectionAddress, String collectionAddressLine1, String collectionAddressLine2, String collectionAddressLine3, String collectionCity, String collectionPostcode, bool collectionAddressConfirmed, bool hasLockingWheelNut, String? lockingWheelNutOption, bool lockingWheelNutConfirmed, List<String> warningLights, bool warningLightsConfirmed, List<String> chargingCables, bool chargingCablesConfirmed, List<String> interiorConditionIssues, bool interiorConditionConfirmed, List<DamageItem> damages, ServiceHistoryType? serviceHistoryType, List<String> serviceDocuments, bool hasProofOfPurchase, bool proofOfPurchaseConfirmed, bool hasBeenSmokedIn, bool smokingConfirmed, bool hasPrivatePlate, bool privatePlateConfirmed, SaleType? saleType, SubmissionStatus submissionStatus, bool vehicleDetailsConfirmed, bool extraFeaturesConfirmed, bool keysConfirmed, bool financeConfirmed, bool runningConditionConfirmed, bool mechanicalIssuesConfirmed, bool photosConfirmed, bool interiorPhotosConfirmed, bool wheelsPhotosConfirmed, bool tireConditionConfirmed, bool conditionDamageConfirmed, bool serviceHistoryConfirmed
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
@pragma('vm:prefer-inline') @override $Res call({Object? vehicle = freezed,Object? mileage = null,Object? extraFeatures = null,Object? numberOfKeys = null,Object? hasFinance = null,Object? runningCondition = freezed,Object? mechanicalIssues = null,Object? exteriorPhotos = null,Object? exteriorPhotosMap = null,Object? interiorPhotos = null,Object? interiorPhotosMap = null,Object? damagePhotos = null,Object? wheelsPhotosMap = null,Object? tirePhotosMap = null,Object? tirePhotosConfirmed = null,Object? tireDamageMap = null,Object? tireCondition = freezed,Object? seatMaterial = freezed,Object? seatMaterialConfirmed = null,Object? paintworkMarks = null,Object? paintworkConfirmed = null,Object? brokenFittingsPhotos = null,Object? brokenFittingMarks = null,Object? hasBrokenFittings = null,Object? brokenFittingsConfirmed = null,Object? wheelDamageMap = null,Object? wheelDamageConfirmed = null,Object? hasToolPack = null,Object? toolPackOption = freezed,Object? toolPackConfirmed = null,Object? parcelShelfOption = freezed,Object? parcelShelfConfirmed = null,Object? bonusPhotos = null,Object? bonusPhotosConfirmed = null,Object? serviceHistoryInfoSeen = null,Object? serviceHistoryPhotos = null,Object? noServiceHistory = null,Object? serviceHistoryUploadConfirmed = null,Object? v5cLogBookOption = freezed,Object? v5cLogBookConfirmed = null,Object? registeredKeeperOption = freezed,Object? registeredKeeperConfirmed = null,Object? ownerFullName = null,Object? ownerNameConfirmed = null,Object? phoneNumber = null,Object? phoneConfirmed = null,Object? collectionAddress = null,Object? collectionAddressLine1 = null,Object? collectionAddressLine2 = null,Object? collectionAddressLine3 = null,Object? collectionCity = null,Object? collectionPostcode = null,Object? collectionAddressConfirmed = null,Object? hasLockingWheelNut = null,Object? lockingWheelNutOption = freezed,Object? lockingWheelNutConfirmed = null,Object? warningLights = null,Object? warningLightsConfirmed = null,Object? chargingCables = null,Object? chargingCablesConfirmed = null,Object? interiorConditionIssues = null,Object? interiorConditionConfirmed = null,Object? damages = null,Object? serviceHistoryType = freezed,Object? serviceDocuments = null,Object? hasProofOfPurchase = null,Object? proofOfPurchaseConfirmed = null,Object? hasBeenSmokedIn = null,Object? smokingConfirmed = null,Object? hasPrivatePlate = null,Object? privatePlateConfirmed = null,Object? saleType = freezed,Object? submissionStatus = null,Object? vehicleDetailsConfirmed = null,Object? extraFeaturesConfirmed = null,Object? keysConfirmed = null,Object? financeConfirmed = null,Object? runningConditionConfirmed = null,Object? mechanicalIssuesConfirmed = null,Object? photosConfirmed = null,Object? interiorPhotosConfirmed = null,Object? wheelsPhotosConfirmed = null,Object? tireConditionConfirmed = null,Object? conditionDamageConfirmed = null,Object? serviceHistoryConfirmed = null,}) {
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
as Map<String, String>,tirePhotosMap: null == tirePhotosMap ? _self.tirePhotosMap : tirePhotosMap // ignore: cast_nullable_to_non_nullable
as Map<String, String>,tirePhotosConfirmed: null == tirePhotosConfirmed ? _self.tirePhotosConfirmed : tirePhotosConfirmed // ignore: cast_nullable_to_non_nullable
as bool,tireDamageMap: null == tireDamageMap ? _self.tireDamageMap : tireDamageMap // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,tireCondition: freezed == tireCondition ? _self.tireCondition : tireCondition // ignore: cast_nullable_to_non_nullable
as String?,seatMaterial: freezed == seatMaterial ? _self.seatMaterial : seatMaterial // ignore: cast_nullable_to_non_nullable
as String?,seatMaterialConfirmed: null == seatMaterialConfirmed ? _self.seatMaterialConfirmed : seatMaterialConfirmed // ignore: cast_nullable_to_non_nullable
as bool,paintworkMarks: null == paintworkMarks ? _self.paintworkMarks : paintworkMarks // ignore: cast_nullable_to_non_nullable
as List<PaintworkMark>,paintworkConfirmed: null == paintworkConfirmed ? _self.paintworkConfirmed : paintworkConfirmed // ignore: cast_nullable_to_non_nullable
as bool,brokenFittingsPhotos: null == brokenFittingsPhotos ? _self.brokenFittingsPhotos : brokenFittingsPhotos // ignore: cast_nullable_to_non_nullable
as List<String>,brokenFittingMarks: null == brokenFittingMarks ? _self.brokenFittingMarks : brokenFittingMarks // ignore: cast_nullable_to_non_nullable
as List<BrokenFittingMark>,hasBrokenFittings: null == hasBrokenFittings ? _self.hasBrokenFittings : hasBrokenFittings // ignore: cast_nullable_to_non_nullable
as bool,brokenFittingsConfirmed: null == brokenFittingsConfirmed ? _self.brokenFittingsConfirmed : brokenFittingsConfirmed // ignore: cast_nullable_to_non_nullable
as bool,wheelDamageMap: null == wheelDamageMap ? _self.wheelDamageMap : wheelDamageMap // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,wheelDamageConfirmed: null == wheelDamageConfirmed ? _self.wheelDamageConfirmed : wheelDamageConfirmed // ignore: cast_nullable_to_non_nullable
as bool,hasToolPack: null == hasToolPack ? _self.hasToolPack : hasToolPack // ignore: cast_nullable_to_non_nullable
as bool,toolPackOption: freezed == toolPackOption ? _self.toolPackOption : toolPackOption // ignore: cast_nullable_to_non_nullable
as String?,toolPackConfirmed: null == toolPackConfirmed ? _self.toolPackConfirmed : toolPackConfirmed // ignore: cast_nullable_to_non_nullable
as bool,parcelShelfOption: freezed == parcelShelfOption ? _self.parcelShelfOption : parcelShelfOption // ignore: cast_nullable_to_non_nullable
as String?,parcelShelfConfirmed: null == parcelShelfConfirmed ? _self.parcelShelfConfirmed : parcelShelfConfirmed // ignore: cast_nullable_to_non_nullable
as bool,bonusPhotos: null == bonusPhotos ? _self.bonusPhotos : bonusPhotos // ignore: cast_nullable_to_non_nullable
as List<String>,bonusPhotosConfirmed: null == bonusPhotosConfirmed ? _self.bonusPhotosConfirmed : bonusPhotosConfirmed // ignore: cast_nullable_to_non_nullable
as bool,serviceHistoryInfoSeen: null == serviceHistoryInfoSeen ? _self.serviceHistoryInfoSeen : serviceHistoryInfoSeen // ignore: cast_nullable_to_non_nullable
as bool,serviceHistoryPhotos: null == serviceHistoryPhotos ? _self.serviceHistoryPhotos : serviceHistoryPhotos // ignore: cast_nullable_to_non_nullable
as List<String>,noServiceHistory: null == noServiceHistory ? _self.noServiceHistory : noServiceHistory // ignore: cast_nullable_to_non_nullable
as bool,serviceHistoryUploadConfirmed: null == serviceHistoryUploadConfirmed ? _self.serviceHistoryUploadConfirmed : serviceHistoryUploadConfirmed // ignore: cast_nullable_to_non_nullable
as bool,v5cLogBookOption: freezed == v5cLogBookOption ? _self.v5cLogBookOption : v5cLogBookOption // ignore: cast_nullable_to_non_nullable
as String?,v5cLogBookConfirmed: null == v5cLogBookConfirmed ? _self.v5cLogBookConfirmed : v5cLogBookConfirmed // ignore: cast_nullable_to_non_nullable
as bool,registeredKeeperOption: freezed == registeredKeeperOption ? _self.registeredKeeperOption : registeredKeeperOption // ignore: cast_nullable_to_non_nullable
as String?,registeredKeeperConfirmed: null == registeredKeeperConfirmed ? _self.registeredKeeperConfirmed : registeredKeeperConfirmed // ignore: cast_nullable_to_non_nullable
as bool,ownerFullName: null == ownerFullName ? _self.ownerFullName : ownerFullName // ignore: cast_nullable_to_non_nullable
as String,ownerNameConfirmed: null == ownerNameConfirmed ? _self.ownerNameConfirmed : ownerNameConfirmed // ignore: cast_nullable_to_non_nullable
as bool,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,phoneConfirmed: null == phoneConfirmed ? _self.phoneConfirmed : phoneConfirmed // ignore: cast_nullable_to_non_nullable
as bool,collectionAddress: null == collectionAddress ? _self.collectionAddress : collectionAddress // ignore: cast_nullable_to_non_nullable
as String,collectionAddressLine1: null == collectionAddressLine1 ? _self.collectionAddressLine1 : collectionAddressLine1 // ignore: cast_nullable_to_non_nullable
as String,collectionAddressLine2: null == collectionAddressLine2 ? _self.collectionAddressLine2 : collectionAddressLine2 // ignore: cast_nullable_to_non_nullable
as String,collectionAddressLine3: null == collectionAddressLine3 ? _self.collectionAddressLine3 : collectionAddressLine3 // ignore: cast_nullable_to_non_nullable
as String,collectionCity: null == collectionCity ? _self.collectionCity : collectionCity // ignore: cast_nullable_to_non_nullable
as String,collectionPostcode: null == collectionPostcode ? _self.collectionPostcode : collectionPostcode // ignore: cast_nullable_to_non_nullable
as String,collectionAddressConfirmed: null == collectionAddressConfirmed ? _self.collectionAddressConfirmed : collectionAddressConfirmed // ignore: cast_nullable_to_non_nullable
as bool,hasLockingWheelNut: null == hasLockingWheelNut ? _self.hasLockingWheelNut : hasLockingWheelNut // ignore: cast_nullable_to_non_nullable
as bool,lockingWheelNutOption: freezed == lockingWheelNutOption ? _self.lockingWheelNutOption : lockingWheelNutOption // ignore: cast_nullable_to_non_nullable
as String?,lockingWheelNutConfirmed: null == lockingWheelNutConfirmed ? _self.lockingWheelNutConfirmed : lockingWheelNutConfirmed // ignore: cast_nullable_to_non_nullable
as bool,warningLights: null == warningLights ? _self.warningLights : warningLights // ignore: cast_nullable_to_non_nullable
as List<String>,warningLightsConfirmed: null == warningLightsConfirmed ? _self.warningLightsConfirmed : warningLightsConfirmed // ignore: cast_nullable_to_non_nullable
as bool,chargingCables: null == chargingCables ? _self.chargingCables : chargingCables // ignore: cast_nullable_to_non_nullable
as List<String>,chargingCablesConfirmed: null == chargingCablesConfirmed ? _self.chargingCablesConfirmed : chargingCablesConfirmed // ignore: cast_nullable_to_non_nullable
as bool,interiorConditionIssues: null == interiorConditionIssues ? _self.interiorConditionIssues : interiorConditionIssues // ignore: cast_nullable_to_non_nullable
as List<String>,interiorConditionConfirmed: null == interiorConditionConfirmed ? _self.interiorConditionConfirmed : interiorConditionConfirmed // ignore: cast_nullable_to_non_nullable
as bool,damages: null == damages ? _self.damages : damages // ignore: cast_nullable_to_non_nullable
as List<DamageItem>,serviceHistoryType: freezed == serviceHistoryType ? _self.serviceHistoryType : serviceHistoryType // ignore: cast_nullable_to_non_nullable
as ServiceHistoryType?,serviceDocuments: null == serviceDocuments ? _self.serviceDocuments : serviceDocuments // ignore: cast_nullable_to_non_nullable
as List<String>,hasProofOfPurchase: null == hasProofOfPurchase ? _self.hasProofOfPurchase : hasProofOfPurchase // ignore: cast_nullable_to_non_nullable
as bool,proofOfPurchaseConfirmed: null == proofOfPurchaseConfirmed ? _self.proofOfPurchaseConfirmed : proofOfPurchaseConfirmed // ignore: cast_nullable_to_non_nullable
as bool,hasBeenSmokedIn: null == hasBeenSmokedIn ? _self.hasBeenSmokedIn : hasBeenSmokedIn // ignore: cast_nullable_to_non_nullable
as bool,smokingConfirmed: null == smokingConfirmed ? _self.smokingConfirmed : smokingConfirmed // ignore: cast_nullable_to_non_nullable
as bool,hasPrivatePlate: null == hasPrivatePlate ? _self.hasPrivatePlate : hasPrivatePlate // ignore: cast_nullable_to_non_nullable
as bool,privatePlateConfirmed: null == privatePlateConfirmed ? _self.privatePlateConfirmed : privatePlateConfirmed // ignore: cast_nullable_to_non_nullable
as bool,saleType: freezed == saleType ? _self.saleType : saleType // ignore: cast_nullable_to_non_nullable
as SaleType?,submissionStatus: null == submissionStatus ? _self.submissionStatus : submissionStatus // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Vehicle? vehicle,  double mileage,  List<String> extraFeatures,  int numberOfKeys,  bool hasFinance,  RunningCondition? runningCondition,  List<String> mechanicalIssues,  List<String> exteriorPhotos,  Map<String, String> exteriorPhotosMap,  List<String> interiorPhotos,  Map<String, String> interiorPhotosMap,  List<String> damagePhotos,  Map<String, String> wheelsPhotosMap,  Map<String, String> tirePhotosMap,  bool tirePhotosConfirmed,  Map<String, bool> tireDamageMap,  String? tireCondition,  String? seatMaterial,  bool seatMaterialConfirmed,  List<PaintworkMark> paintworkMarks,  bool paintworkConfirmed,  List<String> brokenFittingsPhotos,  List<BrokenFittingMark> brokenFittingMarks,  bool hasBrokenFittings,  bool brokenFittingsConfirmed,  Map<String, bool> wheelDamageMap,  bool wheelDamageConfirmed,  bool hasToolPack,  String? toolPackOption,  bool toolPackConfirmed,  String? parcelShelfOption,  bool parcelShelfConfirmed,  List<String> bonusPhotos,  bool bonusPhotosConfirmed,  bool serviceHistoryInfoSeen,  List<String> serviceHistoryPhotos,  bool noServiceHistory,  bool serviceHistoryUploadConfirmed,  String? v5cLogBookOption,  bool v5cLogBookConfirmed,  String? registeredKeeperOption,  bool registeredKeeperConfirmed,  String ownerFullName,  bool ownerNameConfirmed,  String phoneNumber,  bool phoneConfirmed,  String collectionAddress,  String collectionAddressLine1,  String collectionAddressLine2,  String collectionAddressLine3,  String collectionCity,  String collectionPostcode,  bool collectionAddressConfirmed,  bool hasLockingWheelNut,  String? lockingWheelNutOption,  bool lockingWheelNutConfirmed,  List<String> warningLights,  bool warningLightsConfirmed,  List<String> chargingCables,  bool chargingCablesConfirmed,  List<String> interiorConditionIssues,  bool interiorConditionConfirmed,  List<DamageItem> damages,  ServiceHistoryType? serviceHistoryType,  List<String> serviceDocuments,  bool hasProofOfPurchase,  bool proofOfPurchaseConfirmed,  bool hasBeenSmokedIn,  bool smokingConfirmed,  bool hasPrivatePlate,  bool privatePlateConfirmed,  SaleType? saleType,  SubmissionStatus submissionStatus,  bool vehicleDetailsConfirmed,  bool extraFeaturesConfirmed,  bool keysConfirmed,  bool financeConfirmed,  bool runningConditionConfirmed,  bool mechanicalIssuesConfirmed,  bool photosConfirmed,  bool interiorPhotosConfirmed,  bool wheelsPhotosConfirmed,  bool tireConditionConfirmed,  bool conditionDamageConfirmed,  bool serviceHistoryConfirmed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VehicleRegistrationState() when $default != null:
return $default(_that.vehicle,_that.mileage,_that.extraFeatures,_that.numberOfKeys,_that.hasFinance,_that.runningCondition,_that.mechanicalIssues,_that.exteriorPhotos,_that.exteriorPhotosMap,_that.interiorPhotos,_that.interiorPhotosMap,_that.damagePhotos,_that.wheelsPhotosMap,_that.tirePhotosMap,_that.tirePhotosConfirmed,_that.tireDamageMap,_that.tireCondition,_that.seatMaterial,_that.seatMaterialConfirmed,_that.paintworkMarks,_that.paintworkConfirmed,_that.brokenFittingsPhotos,_that.brokenFittingMarks,_that.hasBrokenFittings,_that.brokenFittingsConfirmed,_that.wheelDamageMap,_that.wheelDamageConfirmed,_that.hasToolPack,_that.toolPackOption,_that.toolPackConfirmed,_that.parcelShelfOption,_that.parcelShelfConfirmed,_that.bonusPhotos,_that.bonusPhotosConfirmed,_that.serviceHistoryInfoSeen,_that.serviceHistoryPhotos,_that.noServiceHistory,_that.serviceHistoryUploadConfirmed,_that.v5cLogBookOption,_that.v5cLogBookConfirmed,_that.registeredKeeperOption,_that.registeredKeeperConfirmed,_that.ownerFullName,_that.ownerNameConfirmed,_that.phoneNumber,_that.phoneConfirmed,_that.collectionAddress,_that.collectionAddressLine1,_that.collectionAddressLine2,_that.collectionAddressLine3,_that.collectionCity,_that.collectionPostcode,_that.collectionAddressConfirmed,_that.hasLockingWheelNut,_that.lockingWheelNutOption,_that.lockingWheelNutConfirmed,_that.warningLights,_that.warningLightsConfirmed,_that.chargingCables,_that.chargingCablesConfirmed,_that.interiorConditionIssues,_that.interiorConditionConfirmed,_that.damages,_that.serviceHistoryType,_that.serviceDocuments,_that.hasProofOfPurchase,_that.proofOfPurchaseConfirmed,_that.hasBeenSmokedIn,_that.smokingConfirmed,_that.hasPrivatePlate,_that.privatePlateConfirmed,_that.saleType,_that.submissionStatus,_that.vehicleDetailsConfirmed,_that.extraFeaturesConfirmed,_that.keysConfirmed,_that.financeConfirmed,_that.runningConditionConfirmed,_that.mechanicalIssuesConfirmed,_that.photosConfirmed,_that.interiorPhotosConfirmed,_that.wheelsPhotosConfirmed,_that.tireConditionConfirmed,_that.conditionDamageConfirmed,_that.serviceHistoryConfirmed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Vehicle? vehicle,  double mileage,  List<String> extraFeatures,  int numberOfKeys,  bool hasFinance,  RunningCondition? runningCondition,  List<String> mechanicalIssues,  List<String> exteriorPhotos,  Map<String, String> exteriorPhotosMap,  List<String> interiorPhotos,  Map<String, String> interiorPhotosMap,  List<String> damagePhotos,  Map<String, String> wheelsPhotosMap,  Map<String, String> tirePhotosMap,  bool tirePhotosConfirmed,  Map<String, bool> tireDamageMap,  String? tireCondition,  String? seatMaterial,  bool seatMaterialConfirmed,  List<PaintworkMark> paintworkMarks,  bool paintworkConfirmed,  List<String> brokenFittingsPhotos,  List<BrokenFittingMark> brokenFittingMarks,  bool hasBrokenFittings,  bool brokenFittingsConfirmed,  Map<String, bool> wheelDamageMap,  bool wheelDamageConfirmed,  bool hasToolPack,  String? toolPackOption,  bool toolPackConfirmed,  String? parcelShelfOption,  bool parcelShelfConfirmed,  List<String> bonusPhotos,  bool bonusPhotosConfirmed,  bool serviceHistoryInfoSeen,  List<String> serviceHistoryPhotos,  bool noServiceHistory,  bool serviceHistoryUploadConfirmed,  String? v5cLogBookOption,  bool v5cLogBookConfirmed,  String? registeredKeeperOption,  bool registeredKeeperConfirmed,  String ownerFullName,  bool ownerNameConfirmed,  String phoneNumber,  bool phoneConfirmed,  String collectionAddress,  String collectionAddressLine1,  String collectionAddressLine2,  String collectionAddressLine3,  String collectionCity,  String collectionPostcode,  bool collectionAddressConfirmed,  bool hasLockingWheelNut,  String? lockingWheelNutOption,  bool lockingWheelNutConfirmed,  List<String> warningLights,  bool warningLightsConfirmed,  List<String> chargingCables,  bool chargingCablesConfirmed,  List<String> interiorConditionIssues,  bool interiorConditionConfirmed,  List<DamageItem> damages,  ServiceHistoryType? serviceHistoryType,  List<String> serviceDocuments,  bool hasProofOfPurchase,  bool proofOfPurchaseConfirmed,  bool hasBeenSmokedIn,  bool smokingConfirmed,  bool hasPrivatePlate,  bool privatePlateConfirmed,  SaleType? saleType,  SubmissionStatus submissionStatus,  bool vehicleDetailsConfirmed,  bool extraFeaturesConfirmed,  bool keysConfirmed,  bool financeConfirmed,  bool runningConditionConfirmed,  bool mechanicalIssuesConfirmed,  bool photosConfirmed,  bool interiorPhotosConfirmed,  bool wheelsPhotosConfirmed,  bool tireConditionConfirmed,  bool conditionDamageConfirmed,  bool serviceHistoryConfirmed)  $default,) {final _that = this;
switch (_that) {
case _VehicleRegistrationState():
return $default(_that.vehicle,_that.mileage,_that.extraFeatures,_that.numberOfKeys,_that.hasFinance,_that.runningCondition,_that.mechanicalIssues,_that.exteriorPhotos,_that.exteriorPhotosMap,_that.interiorPhotos,_that.interiorPhotosMap,_that.damagePhotos,_that.wheelsPhotosMap,_that.tirePhotosMap,_that.tirePhotosConfirmed,_that.tireDamageMap,_that.tireCondition,_that.seatMaterial,_that.seatMaterialConfirmed,_that.paintworkMarks,_that.paintworkConfirmed,_that.brokenFittingsPhotos,_that.brokenFittingMarks,_that.hasBrokenFittings,_that.brokenFittingsConfirmed,_that.wheelDamageMap,_that.wheelDamageConfirmed,_that.hasToolPack,_that.toolPackOption,_that.toolPackConfirmed,_that.parcelShelfOption,_that.parcelShelfConfirmed,_that.bonusPhotos,_that.bonusPhotosConfirmed,_that.serviceHistoryInfoSeen,_that.serviceHistoryPhotos,_that.noServiceHistory,_that.serviceHistoryUploadConfirmed,_that.v5cLogBookOption,_that.v5cLogBookConfirmed,_that.registeredKeeperOption,_that.registeredKeeperConfirmed,_that.ownerFullName,_that.ownerNameConfirmed,_that.phoneNumber,_that.phoneConfirmed,_that.collectionAddress,_that.collectionAddressLine1,_that.collectionAddressLine2,_that.collectionAddressLine3,_that.collectionCity,_that.collectionPostcode,_that.collectionAddressConfirmed,_that.hasLockingWheelNut,_that.lockingWheelNutOption,_that.lockingWheelNutConfirmed,_that.warningLights,_that.warningLightsConfirmed,_that.chargingCables,_that.chargingCablesConfirmed,_that.interiorConditionIssues,_that.interiorConditionConfirmed,_that.damages,_that.serviceHistoryType,_that.serviceDocuments,_that.hasProofOfPurchase,_that.proofOfPurchaseConfirmed,_that.hasBeenSmokedIn,_that.smokingConfirmed,_that.hasPrivatePlate,_that.privatePlateConfirmed,_that.saleType,_that.submissionStatus,_that.vehicleDetailsConfirmed,_that.extraFeaturesConfirmed,_that.keysConfirmed,_that.financeConfirmed,_that.runningConditionConfirmed,_that.mechanicalIssuesConfirmed,_that.photosConfirmed,_that.interiorPhotosConfirmed,_that.wheelsPhotosConfirmed,_that.tireConditionConfirmed,_that.conditionDamageConfirmed,_that.serviceHistoryConfirmed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Vehicle? vehicle,  double mileage,  List<String> extraFeatures,  int numberOfKeys,  bool hasFinance,  RunningCondition? runningCondition,  List<String> mechanicalIssues,  List<String> exteriorPhotos,  Map<String, String> exteriorPhotosMap,  List<String> interiorPhotos,  Map<String, String> interiorPhotosMap,  List<String> damagePhotos,  Map<String, String> wheelsPhotosMap,  Map<String, String> tirePhotosMap,  bool tirePhotosConfirmed,  Map<String, bool> tireDamageMap,  String? tireCondition,  String? seatMaterial,  bool seatMaterialConfirmed,  List<PaintworkMark> paintworkMarks,  bool paintworkConfirmed,  List<String> brokenFittingsPhotos,  List<BrokenFittingMark> brokenFittingMarks,  bool hasBrokenFittings,  bool brokenFittingsConfirmed,  Map<String, bool> wheelDamageMap,  bool wheelDamageConfirmed,  bool hasToolPack,  String? toolPackOption,  bool toolPackConfirmed,  String? parcelShelfOption,  bool parcelShelfConfirmed,  List<String> bonusPhotos,  bool bonusPhotosConfirmed,  bool serviceHistoryInfoSeen,  List<String> serviceHistoryPhotos,  bool noServiceHistory,  bool serviceHistoryUploadConfirmed,  String? v5cLogBookOption,  bool v5cLogBookConfirmed,  String? registeredKeeperOption,  bool registeredKeeperConfirmed,  String ownerFullName,  bool ownerNameConfirmed,  String phoneNumber,  bool phoneConfirmed,  String collectionAddress,  String collectionAddressLine1,  String collectionAddressLine2,  String collectionAddressLine3,  String collectionCity,  String collectionPostcode,  bool collectionAddressConfirmed,  bool hasLockingWheelNut,  String? lockingWheelNutOption,  bool lockingWheelNutConfirmed,  List<String> warningLights,  bool warningLightsConfirmed,  List<String> chargingCables,  bool chargingCablesConfirmed,  List<String> interiorConditionIssues,  bool interiorConditionConfirmed,  List<DamageItem> damages,  ServiceHistoryType? serviceHistoryType,  List<String> serviceDocuments,  bool hasProofOfPurchase,  bool proofOfPurchaseConfirmed,  bool hasBeenSmokedIn,  bool smokingConfirmed,  bool hasPrivatePlate,  bool privatePlateConfirmed,  SaleType? saleType,  SubmissionStatus submissionStatus,  bool vehicleDetailsConfirmed,  bool extraFeaturesConfirmed,  bool keysConfirmed,  bool financeConfirmed,  bool runningConditionConfirmed,  bool mechanicalIssuesConfirmed,  bool photosConfirmed,  bool interiorPhotosConfirmed,  bool wheelsPhotosConfirmed,  bool tireConditionConfirmed,  bool conditionDamageConfirmed,  bool serviceHistoryConfirmed)?  $default,) {final _that = this;
switch (_that) {
case _VehicleRegistrationState() when $default != null:
return $default(_that.vehicle,_that.mileage,_that.extraFeatures,_that.numberOfKeys,_that.hasFinance,_that.runningCondition,_that.mechanicalIssues,_that.exteriorPhotos,_that.exteriorPhotosMap,_that.interiorPhotos,_that.interiorPhotosMap,_that.damagePhotos,_that.wheelsPhotosMap,_that.tirePhotosMap,_that.tirePhotosConfirmed,_that.tireDamageMap,_that.tireCondition,_that.seatMaterial,_that.seatMaterialConfirmed,_that.paintworkMarks,_that.paintworkConfirmed,_that.brokenFittingsPhotos,_that.brokenFittingMarks,_that.hasBrokenFittings,_that.brokenFittingsConfirmed,_that.wheelDamageMap,_that.wheelDamageConfirmed,_that.hasToolPack,_that.toolPackOption,_that.toolPackConfirmed,_that.parcelShelfOption,_that.parcelShelfConfirmed,_that.bonusPhotos,_that.bonusPhotosConfirmed,_that.serviceHistoryInfoSeen,_that.serviceHistoryPhotos,_that.noServiceHistory,_that.serviceHistoryUploadConfirmed,_that.v5cLogBookOption,_that.v5cLogBookConfirmed,_that.registeredKeeperOption,_that.registeredKeeperConfirmed,_that.ownerFullName,_that.ownerNameConfirmed,_that.phoneNumber,_that.phoneConfirmed,_that.collectionAddress,_that.collectionAddressLine1,_that.collectionAddressLine2,_that.collectionAddressLine3,_that.collectionCity,_that.collectionPostcode,_that.collectionAddressConfirmed,_that.hasLockingWheelNut,_that.lockingWheelNutOption,_that.lockingWheelNutConfirmed,_that.warningLights,_that.warningLightsConfirmed,_that.chargingCables,_that.chargingCablesConfirmed,_that.interiorConditionIssues,_that.interiorConditionConfirmed,_that.damages,_that.serviceHistoryType,_that.serviceDocuments,_that.hasProofOfPurchase,_that.proofOfPurchaseConfirmed,_that.hasBeenSmokedIn,_that.smokingConfirmed,_that.hasPrivatePlate,_that.privatePlateConfirmed,_that.saleType,_that.submissionStatus,_that.vehicleDetailsConfirmed,_that.extraFeaturesConfirmed,_that.keysConfirmed,_that.financeConfirmed,_that.runningConditionConfirmed,_that.mechanicalIssuesConfirmed,_that.photosConfirmed,_that.interiorPhotosConfirmed,_that.wheelsPhotosConfirmed,_that.tireConditionConfirmed,_that.conditionDamageConfirmed,_that.serviceHistoryConfirmed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VehicleRegistrationState implements VehicleRegistrationState {
  const _VehicleRegistrationState({this.vehicle, this.mileage = 0,  List<String> extraFeatures = const [], this.numberOfKeys = 1, this.hasFinance = false, this.runningCondition,  List<String> mechanicalIssues = const [],  List<String> exteriorPhotos = const [],  Map<String, String> exteriorPhotosMap = const {},  List<String> interiorPhotos = const [],  Map<String, String> interiorPhotosMap = const {},  List<String> damagePhotos = const [],  Map<String, String> wheelsPhotosMap = const {},  Map<String, String> tirePhotosMap = const {}, this.tirePhotosConfirmed = false,  Map<String, bool> tireDamageMap = const {}, this.tireCondition, this.seatMaterial, this.seatMaterialConfirmed = false,  List<PaintworkMark> paintworkMarks = const [], this.paintworkConfirmed = false,  List<String> brokenFittingsPhotos = const [],  List<BrokenFittingMark> brokenFittingMarks = const [], this.hasBrokenFittings = false, this.brokenFittingsConfirmed = false,  Map<String, bool> wheelDamageMap = const {}, this.wheelDamageConfirmed = false, this.hasToolPack = false, this.toolPackOption, this.toolPackConfirmed = false, this.parcelShelfOption, this.parcelShelfConfirmed = false,  List<String> bonusPhotos = const [], this.bonusPhotosConfirmed = false, this.serviceHistoryInfoSeen = false,  List<String> serviceHistoryPhotos = const [], this.noServiceHistory = false, this.serviceHistoryUploadConfirmed = false, this.v5cLogBookOption, this.v5cLogBookConfirmed = false, this.registeredKeeperOption, this.registeredKeeperConfirmed = false, this.ownerFullName = '', this.ownerNameConfirmed = false, this.phoneNumber = '', this.phoneConfirmed = false, this.collectionAddress = '', this.collectionAddressLine1 = '', this.collectionAddressLine2 = '', this.collectionAddressLine3 = '', this.collectionCity = '', this.collectionPostcode = '', this.collectionAddressConfirmed = false, this.hasLockingWheelNut = false, this.lockingWheelNutOption, this.lockingWheelNutConfirmed = false,  List<String> warningLights = const [], this.warningLightsConfirmed = false,  List<String> chargingCables = const [], this.chargingCablesConfirmed = false,  List<String> interiorConditionIssues = const [], this.interiorConditionConfirmed = false,  List<DamageItem> damages = const [], this.serviceHistoryType,  List<String> serviceDocuments = const [], this.hasProofOfPurchase = false, this.proofOfPurchaseConfirmed = false, this.hasBeenSmokedIn = false, this.smokingConfirmed = false, this.hasPrivatePlate = false, this.privatePlateConfirmed = false, this.saleType, this.submissionStatus = SubmissionStatus.draft, this.vehicleDetailsConfirmed = false, this.extraFeaturesConfirmed = false, this.keysConfirmed = false, this.financeConfirmed = false, this.runningConditionConfirmed = false, this.mechanicalIssuesConfirmed = false, this.photosConfirmed = false, this.interiorPhotosConfirmed = false, this.wheelsPhotosConfirmed = false, this.tireConditionConfirmed = false, this.conditionDamageConfirmed = false, this.serviceHistoryConfirmed = false}): _extraFeatures = extraFeatures,_mechanicalIssues = mechanicalIssues,_exteriorPhotos = exteriorPhotos,_exteriorPhotosMap = exteriorPhotosMap,_interiorPhotos = interiorPhotos,_interiorPhotosMap = interiorPhotosMap,_damagePhotos = damagePhotos,_wheelsPhotosMap = wheelsPhotosMap,_tirePhotosMap = tirePhotosMap,_tireDamageMap = tireDamageMap,_paintworkMarks = paintworkMarks,_brokenFittingsPhotos = brokenFittingsPhotos,_brokenFittingMarks = brokenFittingMarks,_wheelDamageMap = wheelDamageMap,_bonusPhotos = bonusPhotos,_serviceHistoryPhotos = serviceHistoryPhotos,_warningLights = warningLights,_chargingCables = chargingCables,_interiorConditionIssues = interiorConditionIssues,_damages = damages,_serviceDocuments = serviceDocuments;
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

 final  Map<String, String> _tirePhotosMap;
@override@JsonKey() Map<String, String> get tirePhotosMap {
  if (_tirePhotosMap is EqualUnmodifiableMapView) return _tirePhotosMap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_tirePhotosMap);
}

@override@JsonKey() final  bool tirePhotosConfirmed;
 final  Map<String, bool> _tireDamageMap;
@override@JsonKey() Map<String, bool> get tireDamageMap {
  if (_tireDamageMap is EqualUnmodifiableMapView) return _tireDamageMap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_tireDamageMap);
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

 final  List<BrokenFittingMark> _brokenFittingMarks;
@override@JsonKey() List<BrokenFittingMark> get brokenFittingMarks {
  if (_brokenFittingMarks is EqualUnmodifiableListView) return _brokenFittingMarks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_brokenFittingMarks);
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
@override final  String? toolPackOption;
@override@JsonKey() final  bool toolPackConfirmed;
@override final  String? parcelShelfOption;
@override@JsonKey() final  bool parcelShelfConfirmed;
 final  List<String> _bonusPhotos;
@override@JsonKey() List<String> get bonusPhotos {
  if (_bonusPhotos is EqualUnmodifiableListView) return _bonusPhotos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bonusPhotos);
}

@override@JsonKey() final  bool bonusPhotosConfirmed;
@override@JsonKey() final  bool serviceHistoryInfoSeen;
 final  List<String> _serviceHistoryPhotos;
@override@JsonKey() List<String> get serviceHistoryPhotos {
  if (_serviceHistoryPhotos is EqualUnmodifiableListView) return _serviceHistoryPhotos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_serviceHistoryPhotos);
}

@override@JsonKey() final  bool noServiceHistory;
@override@JsonKey() final  bool serviceHistoryUploadConfirmed;
@override final  String? v5cLogBookOption;
@override@JsonKey() final  bool v5cLogBookConfirmed;
@override final  String? registeredKeeperOption;
@override@JsonKey() final  bool registeredKeeperConfirmed;
@override@JsonKey() final  String ownerFullName;
@override@JsonKey() final  bool ownerNameConfirmed;
@override@JsonKey() final  String phoneNumber;
@override@JsonKey() final  bool phoneConfirmed;
@override@JsonKey() final  String collectionAddress;
@override@JsonKey() final  String collectionAddressLine1;
@override@JsonKey() final  String collectionAddressLine2;
@override@JsonKey() final  String collectionAddressLine3;
@override@JsonKey() final  String collectionCity;
@override@JsonKey() final  String collectionPostcode;
@override@JsonKey() final  bool collectionAddressConfirmed;
@override@JsonKey() final  bool hasLockingWheelNut;
@override final  String? lockingWheelNutOption;
@override@JsonKey() final  bool lockingWheelNutConfirmed;
 final  List<String> _warningLights;
@override@JsonKey() List<String> get warningLights {
  if (_warningLights is EqualUnmodifiableListView) return _warningLights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_warningLights);
}

@override@JsonKey() final  bool warningLightsConfirmed;
 final  List<String> _chargingCables;
@override@JsonKey() List<String> get chargingCables {
  if (_chargingCables is EqualUnmodifiableListView) return _chargingCables;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chargingCables);
}

@override@JsonKey() final  bool chargingCablesConfirmed;
 final  List<String> _interiorConditionIssues;
@override@JsonKey() List<String> get interiorConditionIssues {
  if (_interiorConditionIssues is EqualUnmodifiableListView) return _interiorConditionIssues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_interiorConditionIssues);
}

@override@JsonKey() final  bool interiorConditionConfirmed;
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
@override final  SaleType? saleType;
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
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VehicleRegistrationState&&(identical(other.vehicle, vehicle) || other.vehicle == vehicle)&&(identical(other.mileage, mileage) || other.mileage == mileage)&&const DeepCollectionEquality().equals(other.extraFeatures, _extraFeatures)&&(identical(other.numberOfKeys, numberOfKeys) || other.numberOfKeys == numberOfKeys)&&(identical(other.hasFinance, hasFinance) || other.hasFinance == hasFinance)&&(identical(other.runningCondition, runningCondition) || other.runningCondition == runningCondition)&&const DeepCollectionEquality().equals(other.mechanicalIssues, _mechanicalIssues)&&const DeepCollectionEquality().equals(other.exteriorPhotos, _exteriorPhotos)&&const DeepCollectionEquality().equals(other.exteriorPhotosMap, _exteriorPhotosMap)&&const DeepCollectionEquality().equals(other.interiorPhotos, _interiorPhotos)&&const DeepCollectionEquality().equals(other.interiorPhotosMap, _interiorPhotosMap)&&const DeepCollectionEquality().equals(other.damagePhotos, _damagePhotos)&&const DeepCollectionEquality().equals(other.wheelsPhotosMap, _wheelsPhotosMap)&&const DeepCollectionEquality().equals(other.tirePhotosMap, _tirePhotosMap)&&(identical(other.tirePhotosConfirmed, tirePhotosConfirmed) || other.tirePhotosConfirmed == tirePhotosConfirmed)&&const DeepCollectionEquality().equals(other.tireDamageMap, _tireDamageMap)&&(identical(other.tireCondition, tireCondition) || other.tireCondition == tireCondition)&&(identical(other.seatMaterial, seatMaterial) || other.seatMaterial == seatMaterial)&&(identical(other.seatMaterialConfirmed, seatMaterialConfirmed) || other.seatMaterialConfirmed == seatMaterialConfirmed)&&const DeepCollectionEquality().equals(other.paintworkMarks, _paintworkMarks)&&(identical(other.paintworkConfirmed, paintworkConfirmed) || other.paintworkConfirmed == paintworkConfirmed)&&const DeepCollectionEquality().equals(other.brokenFittingsPhotos, _brokenFittingsPhotos)&&const DeepCollectionEquality().equals(other.brokenFittingMarks, _brokenFittingMarks)&&(identical(other.hasBrokenFittings, hasBrokenFittings) || other.hasBrokenFittings == hasBrokenFittings)&&(identical(other.brokenFittingsConfirmed, brokenFittingsConfirmed) || other.brokenFittingsConfirmed == brokenFittingsConfirmed)&&const DeepCollectionEquality().equals(other.wheelDamageMap, _wheelDamageMap)&&(identical(other.wheelDamageConfirmed, wheelDamageConfirmed) || other.wheelDamageConfirmed == wheelDamageConfirmed)&&(identical(other.hasToolPack, hasToolPack) || other.hasToolPack == hasToolPack)&&(identical(other.toolPackOption, toolPackOption) || other.toolPackOption == toolPackOption)&&(identical(other.toolPackConfirmed, toolPackConfirmed) || other.toolPackConfirmed == toolPackConfirmed)&&(identical(other.parcelShelfOption, parcelShelfOption) || other.parcelShelfOption == parcelShelfOption)&&(identical(other.parcelShelfConfirmed, parcelShelfConfirmed) || other.parcelShelfConfirmed == parcelShelfConfirmed)&&const DeepCollectionEquality().equals(other.bonusPhotos, _bonusPhotos)&&(identical(other.bonusPhotosConfirmed, bonusPhotosConfirmed) || other.bonusPhotosConfirmed == bonusPhotosConfirmed)&&(identical(other.serviceHistoryInfoSeen, serviceHistoryInfoSeen) || other.serviceHistoryInfoSeen == serviceHistoryInfoSeen)&&const DeepCollectionEquality().equals(other.serviceHistoryPhotos, _serviceHistoryPhotos)&&(identical(other.noServiceHistory, noServiceHistory) || other.noServiceHistory == noServiceHistory)&&(identical(other.serviceHistoryUploadConfirmed, serviceHistoryUploadConfirmed) || other.serviceHistoryUploadConfirmed == serviceHistoryUploadConfirmed)&&(identical(other.v5cLogBookOption, v5cLogBookOption) || other.v5cLogBookOption == v5cLogBookOption)&&(identical(other.v5cLogBookConfirmed, v5cLogBookConfirmed) || other.v5cLogBookConfirmed == v5cLogBookConfirmed)&&(identical(other.registeredKeeperOption, registeredKeeperOption) || other.registeredKeeperOption == registeredKeeperOption)&&(identical(other.registeredKeeperConfirmed, registeredKeeperConfirmed) || other.registeredKeeperConfirmed == registeredKeeperConfirmed)&&(identical(other.ownerFullName, ownerFullName) || other.ownerFullName == ownerFullName)&&(identical(other.ownerNameConfirmed, ownerNameConfirmed) || other.ownerNameConfirmed == ownerNameConfirmed)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.phoneConfirmed, phoneConfirmed) || other.phoneConfirmed == phoneConfirmed)&&(identical(other.collectionAddress, collectionAddress) || other.collectionAddress == collectionAddress)&&(identical(other.collectionAddressLine1, collectionAddressLine1) || other.collectionAddressLine1 == collectionAddressLine1)&&(identical(other.collectionAddressLine2, collectionAddressLine2) || other.collectionAddressLine2 == collectionAddressLine2)&&(identical(other.collectionAddressLine3, collectionAddressLine3) || other.collectionAddressLine3 == collectionAddressLine3)&&(identical(other.collectionCity, collectionCity) || other.collectionCity == collectionCity)&&(identical(other.collectionPostcode, collectionPostcode) || other.collectionPostcode == collectionPostcode)&&(identical(other.collectionAddressConfirmed, collectionAddressConfirmed) || other.collectionAddressConfirmed == collectionAddressConfirmed)&&(identical(other.hasLockingWheelNut, hasLockingWheelNut) || other.hasLockingWheelNut == hasLockingWheelNut)&&(identical(other.lockingWheelNutOption, lockingWheelNutOption) || other.lockingWheelNutOption == lockingWheelNutOption)&&(identical(other.lockingWheelNutConfirmed, lockingWheelNutConfirmed) || other.lockingWheelNutConfirmed == lockingWheelNutConfirmed)&&const DeepCollectionEquality().equals(other.warningLights, _warningLights)&&(identical(other.warningLightsConfirmed, warningLightsConfirmed) || other.warningLightsConfirmed == warningLightsConfirmed)&&const DeepCollectionEquality().equals(other.chargingCables, _chargingCables)&&(identical(other.chargingCablesConfirmed, chargingCablesConfirmed) || other.chargingCablesConfirmed == chargingCablesConfirmed)&&const DeepCollectionEquality().equals(other.interiorConditionIssues, _interiorConditionIssues)&&(identical(other.interiorConditionConfirmed, interiorConditionConfirmed) || other.interiorConditionConfirmed == interiorConditionConfirmed)&&const DeepCollectionEquality().equals(other.damages, _damages)&&(identical(other.serviceHistoryType, serviceHistoryType) || other.serviceHistoryType == serviceHistoryType)&&const DeepCollectionEquality().equals(other.serviceDocuments, _serviceDocuments)&&(identical(other.hasProofOfPurchase, hasProofOfPurchase) || other.hasProofOfPurchase == hasProofOfPurchase)&&(identical(other.proofOfPurchaseConfirmed, proofOfPurchaseConfirmed) || other.proofOfPurchaseConfirmed == proofOfPurchaseConfirmed)&&(identical(other.hasBeenSmokedIn, hasBeenSmokedIn) || other.hasBeenSmokedIn == hasBeenSmokedIn)&&(identical(other.smokingConfirmed, smokingConfirmed) || other.smokingConfirmed == smokingConfirmed)&&(identical(other.hasPrivatePlate, hasPrivatePlate) || other.hasPrivatePlate == hasPrivatePlate)&&(identical(other.privatePlateConfirmed, privatePlateConfirmed) || other.privatePlateConfirmed == privatePlateConfirmed)&&(identical(other.saleType, saleType) || other.saleType == saleType)&&(identical(other.submissionStatus, submissionStatus) || other.submissionStatus == submissionStatus)&&(identical(other.vehicleDetailsConfirmed, vehicleDetailsConfirmed) || other.vehicleDetailsConfirmed == vehicleDetailsConfirmed)&&(identical(other.extraFeaturesConfirmed, extraFeaturesConfirmed) || other.extraFeaturesConfirmed == extraFeaturesConfirmed)&&(identical(other.keysConfirmed, keysConfirmed) || other.keysConfirmed == keysConfirmed)&&(identical(other.financeConfirmed, financeConfirmed) || other.financeConfirmed == financeConfirmed)&&(identical(other.runningConditionConfirmed, runningConditionConfirmed) || other.runningConditionConfirmed == runningConditionConfirmed)&&(identical(other.mechanicalIssuesConfirmed, mechanicalIssuesConfirmed) || other.mechanicalIssuesConfirmed == mechanicalIssuesConfirmed)&&(identical(other.photosConfirmed, photosConfirmed) || other.photosConfirmed == photosConfirmed)&&(identical(other.interiorPhotosConfirmed, interiorPhotosConfirmed) || other.interiorPhotosConfirmed == interiorPhotosConfirmed)&&(identical(other.wheelsPhotosConfirmed, wheelsPhotosConfirmed) || other.wheelsPhotosConfirmed == wheelsPhotosConfirmed)&&(identical(other.tireConditionConfirmed, tireConditionConfirmed) || other.tireConditionConfirmed == tireConditionConfirmed)&&(identical(other.conditionDamageConfirmed, conditionDamageConfirmed) || other.conditionDamageConfirmed == conditionDamageConfirmed)&&(identical(other.serviceHistoryConfirmed, serviceHistoryConfirmed) || other.serviceHistoryConfirmed == serviceHistoryConfirmed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,vehicle,mileage,const DeepCollectionEquality().hash(_extraFeatures),numberOfKeys,hasFinance,runningCondition,const DeepCollectionEquality().hash(_mechanicalIssues),const DeepCollectionEquality().hash(_exteriorPhotos),const DeepCollectionEquality().hash(_exteriorPhotosMap),const DeepCollectionEquality().hash(_interiorPhotos),const DeepCollectionEquality().hash(_interiorPhotosMap),const DeepCollectionEquality().hash(_damagePhotos),const DeepCollectionEquality().hash(_wheelsPhotosMap),const DeepCollectionEquality().hash(_tirePhotosMap),tirePhotosConfirmed,const DeepCollectionEquality().hash(_tireDamageMap),tireCondition,seatMaterial,seatMaterialConfirmed,const DeepCollectionEquality().hash(_paintworkMarks),paintworkConfirmed,const DeepCollectionEquality().hash(_brokenFittingsPhotos),const DeepCollectionEquality().hash(_brokenFittingMarks),hasBrokenFittings,brokenFittingsConfirmed,const DeepCollectionEquality().hash(_wheelDamageMap),wheelDamageConfirmed,hasToolPack,toolPackOption,toolPackConfirmed,parcelShelfOption,parcelShelfConfirmed,const DeepCollectionEquality().hash(_bonusPhotos),bonusPhotosConfirmed,serviceHistoryInfoSeen,const DeepCollectionEquality().hash(_serviceHistoryPhotos),noServiceHistory,serviceHistoryUploadConfirmed,v5cLogBookOption,v5cLogBookConfirmed,registeredKeeperOption,registeredKeeperConfirmed,ownerFullName,ownerNameConfirmed,phoneNumber,phoneConfirmed,collectionAddress,collectionAddressLine1,collectionAddressLine2,collectionAddressLine3,collectionCity,collectionPostcode,collectionAddressConfirmed,hasLockingWheelNut,lockingWheelNutOption,lockingWheelNutConfirmed,const DeepCollectionEquality().hash(_warningLights),warningLightsConfirmed,const DeepCollectionEquality().hash(_chargingCables),chargingCablesConfirmed,const DeepCollectionEquality().hash(_interiorConditionIssues),interiorConditionConfirmed,const DeepCollectionEquality().hash(_damages),serviceHistoryType,const DeepCollectionEquality().hash(_serviceDocuments),hasProofOfPurchase,proofOfPurchaseConfirmed,hasBeenSmokedIn,smokingConfirmed,hasPrivatePlate,privatePlateConfirmed,saleType,submissionStatus,vehicleDetailsConfirmed,extraFeaturesConfirmed,keysConfirmed,financeConfirmed,runningConditionConfirmed,mechanicalIssuesConfirmed,photosConfirmed,interiorPhotosConfirmed,wheelsPhotosConfirmed,tireConditionConfirmed,conditionDamageConfirmed,serviceHistoryConfirmed]);
}

@override
String toString() {
    return 'VehicleRegistrationState(vehicle: $vehicle, mileage: $mileage, extraFeatures: $extraFeatures, numberOfKeys: $numberOfKeys, hasFinance: $hasFinance, runningCondition: $runningCondition, mechanicalIssues: $mechanicalIssues, exteriorPhotos: $exteriorPhotos, exteriorPhotosMap: $exteriorPhotosMap, interiorPhotos: $interiorPhotos, interiorPhotosMap: $interiorPhotosMap, damagePhotos: $damagePhotos, wheelsPhotosMap: $wheelsPhotosMap, tirePhotosMap: $tirePhotosMap, tirePhotosConfirmed: $tirePhotosConfirmed, tireDamageMap: $tireDamageMap, tireCondition: $tireCondition, seatMaterial: $seatMaterial, seatMaterialConfirmed: $seatMaterialConfirmed, paintworkMarks: $paintworkMarks, paintworkConfirmed: $paintworkConfirmed, brokenFittingsPhotos: $brokenFittingsPhotos, brokenFittingMarks: $brokenFittingMarks, hasBrokenFittings: $hasBrokenFittings, brokenFittingsConfirmed: $brokenFittingsConfirmed, wheelDamageMap: $wheelDamageMap, wheelDamageConfirmed: $wheelDamageConfirmed, hasToolPack: $hasToolPack, toolPackOption: $toolPackOption, toolPackConfirmed: $toolPackConfirmed, parcelShelfOption: $parcelShelfOption, parcelShelfConfirmed: $parcelShelfConfirmed, bonusPhotos: $bonusPhotos, bonusPhotosConfirmed: $bonusPhotosConfirmed, serviceHistoryInfoSeen: $serviceHistoryInfoSeen, serviceHistoryPhotos: $serviceHistoryPhotos, noServiceHistory: $noServiceHistory, serviceHistoryUploadConfirmed: $serviceHistoryUploadConfirmed, v5cLogBookOption: $v5cLogBookOption, v5cLogBookConfirmed: $v5cLogBookConfirmed, registeredKeeperOption: $registeredKeeperOption, registeredKeeperConfirmed: $registeredKeeperConfirmed, ownerFullName: $ownerFullName, ownerNameConfirmed: $ownerNameConfirmed, phoneNumber: $phoneNumber, phoneConfirmed: $phoneConfirmed, collectionAddress: $collectionAddress, collectionAddressLine1: $collectionAddressLine1, collectionAddressLine2: $collectionAddressLine2, collectionAddressLine3: $collectionAddressLine3, collectionCity: $collectionCity, collectionPostcode: $collectionPostcode, collectionAddressConfirmed: $collectionAddressConfirmed, hasLockingWheelNut: $hasLockingWheelNut, lockingWheelNutOption: $lockingWheelNutOption, lockingWheelNutConfirmed: $lockingWheelNutConfirmed, warningLights: $warningLights, warningLightsConfirmed: $warningLightsConfirmed, chargingCables: $chargingCables, chargingCablesConfirmed: $chargingCablesConfirmed, interiorConditionIssues: $interiorConditionIssues, interiorConditionConfirmed: $interiorConditionConfirmed, damages: $damages, serviceHistoryType: $serviceHistoryType, serviceDocuments: $serviceDocuments, hasProofOfPurchase: $hasProofOfPurchase, proofOfPurchaseConfirmed: $proofOfPurchaseConfirmed, hasBeenSmokedIn: $hasBeenSmokedIn, smokingConfirmed: $smokingConfirmed, hasPrivatePlate: $hasPrivatePlate, privatePlateConfirmed: $privatePlateConfirmed, saleType: $saleType, submissionStatus: $submissionStatus, vehicleDetailsConfirmed: $vehicleDetailsConfirmed, extraFeaturesConfirmed: $extraFeaturesConfirmed, keysConfirmed: $keysConfirmed, financeConfirmed: $financeConfirmed, runningConditionConfirmed: $runningConditionConfirmed, mechanicalIssuesConfirmed: $mechanicalIssuesConfirmed, photosConfirmed: $photosConfirmed, interiorPhotosConfirmed: $interiorPhotosConfirmed, wheelsPhotosConfirmed: $wheelsPhotosConfirmed, tireConditionConfirmed: $tireConditionConfirmed, conditionDamageConfirmed: $conditionDamageConfirmed, serviceHistoryConfirmed: $serviceHistoryConfirmed)';
}


}

/// @nodoc
abstract mixin class _$VehicleRegistrationStateCopyWith<$Res> implements $VehicleRegistrationStateCopyWith<$Res> {
  factory _$VehicleRegistrationStateCopyWith(_VehicleRegistrationState value, $Res Function(_VehicleRegistrationState) _then) = __$VehicleRegistrationStateCopyWithImpl;
@override @useResult
$Res call({
 Vehicle? vehicle, double mileage, List<String> extraFeatures, int numberOfKeys, bool hasFinance, RunningCondition? runningCondition, List<String> mechanicalIssues, List<String> exteriorPhotos, Map<String, String> exteriorPhotosMap, List<String> interiorPhotos, Map<String, String> interiorPhotosMap, List<String> damagePhotos, Map<String, String> wheelsPhotosMap, Map<String, String> tirePhotosMap, bool tirePhotosConfirmed, Map<String, bool> tireDamageMap, String? tireCondition, String? seatMaterial, bool seatMaterialConfirmed, List<PaintworkMark> paintworkMarks, bool paintworkConfirmed, List<String> brokenFittingsPhotos, List<BrokenFittingMark> brokenFittingMarks, bool hasBrokenFittings, bool brokenFittingsConfirmed, Map<String, bool> wheelDamageMap, bool wheelDamageConfirmed, bool hasToolPack, String? toolPackOption, bool toolPackConfirmed, String? parcelShelfOption, bool parcelShelfConfirmed, List<String> bonusPhotos, bool bonusPhotosConfirmed, bool serviceHistoryInfoSeen, List<String> serviceHistoryPhotos, bool noServiceHistory, bool serviceHistoryUploadConfirmed, String? v5cLogBookOption, bool v5cLogBookConfirmed, String? registeredKeeperOption, bool registeredKeeperConfirmed, String ownerFullName, bool ownerNameConfirmed, String phoneNumber, bool phoneConfirmed, String collectionAddress, String collectionAddressLine1, String collectionAddressLine2, String collectionAddressLine3, String collectionCity, String collectionPostcode, bool collectionAddressConfirmed, bool hasLockingWheelNut, String? lockingWheelNutOption, bool lockingWheelNutConfirmed, List<String> warningLights, bool warningLightsConfirmed, List<String> chargingCables, bool chargingCablesConfirmed, List<String> interiorConditionIssues, bool interiorConditionConfirmed, List<DamageItem> damages, ServiceHistoryType? serviceHistoryType, List<String> serviceDocuments, bool hasProofOfPurchase, bool proofOfPurchaseConfirmed, bool hasBeenSmokedIn, bool smokingConfirmed, bool hasPrivatePlate, bool privatePlateConfirmed, SaleType? saleType, SubmissionStatus submissionStatus, bool vehicleDetailsConfirmed, bool extraFeaturesConfirmed, bool keysConfirmed, bool financeConfirmed, bool runningConditionConfirmed, bool mechanicalIssuesConfirmed, bool photosConfirmed, bool interiorPhotosConfirmed, bool wheelsPhotosConfirmed, bool tireConditionConfirmed, bool conditionDamageConfirmed, bool serviceHistoryConfirmed
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
@override @pragma('vm:prefer-inline') $Res call({Object? vehicle = freezed,Object? mileage = null,Object? extraFeatures = null,Object? numberOfKeys = null,Object? hasFinance = null,Object? runningCondition = freezed,Object? mechanicalIssues = null,Object? exteriorPhotos = null,Object? exteriorPhotosMap = null,Object? interiorPhotos = null,Object? interiorPhotosMap = null,Object? damagePhotos = null,Object? wheelsPhotosMap = null,Object? tirePhotosMap = null,Object? tirePhotosConfirmed = null,Object? tireDamageMap = null,Object? tireCondition = freezed,Object? seatMaterial = freezed,Object? seatMaterialConfirmed = null,Object? paintworkMarks = null,Object? paintworkConfirmed = null,Object? brokenFittingsPhotos = null,Object? brokenFittingMarks = null,Object? hasBrokenFittings = null,Object? brokenFittingsConfirmed = null,Object? wheelDamageMap = null,Object? wheelDamageConfirmed = null,Object? hasToolPack = null,Object? toolPackOption = freezed,Object? toolPackConfirmed = null,Object? parcelShelfOption = freezed,Object? parcelShelfConfirmed = null,Object? bonusPhotos = null,Object? bonusPhotosConfirmed = null,Object? serviceHistoryInfoSeen = null,Object? serviceHistoryPhotos = null,Object? noServiceHistory = null,Object? serviceHistoryUploadConfirmed = null,Object? v5cLogBookOption = freezed,Object? v5cLogBookConfirmed = null,Object? registeredKeeperOption = freezed,Object? registeredKeeperConfirmed = null,Object? ownerFullName = null,Object? ownerNameConfirmed = null,Object? phoneNumber = null,Object? phoneConfirmed = null,Object? collectionAddress = null,Object? collectionAddressLine1 = null,Object? collectionAddressLine2 = null,Object? collectionAddressLine3 = null,Object? collectionCity = null,Object? collectionPostcode = null,Object? collectionAddressConfirmed = null,Object? hasLockingWheelNut = null,Object? lockingWheelNutOption = freezed,Object? lockingWheelNutConfirmed = null,Object? warningLights = null,Object? warningLightsConfirmed = null,Object? chargingCables = null,Object? chargingCablesConfirmed = null,Object? interiorConditionIssues = null,Object? interiorConditionConfirmed = null,Object? damages = null,Object? serviceHistoryType = freezed,Object? serviceDocuments = null,Object? hasProofOfPurchase = null,Object? proofOfPurchaseConfirmed = null,Object? hasBeenSmokedIn = null,Object? smokingConfirmed = null,Object? hasPrivatePlate = null,Object? privatePlateConfirmed = null,Object? saleType = freezed,Object? submissionStatus = null,Object? vehicleDetailsConfirmed = null,Object? extraFeaturesConfirmed = null,Object? keysConfirmed = null,Object? financeConfirmed = null,Object? runningConditionConfirmed = null,Object? mechanicalIssuesConfirmed = null,Object? photosConfirmed = null,Object? interiorPhotosConfirmed = null,Object? wheelsPhotosConfirmed = null,Object? tireConditionConfirmed = null,Object? conditionDamageConfirmed = null,Object? serviceHistoryConfirmed = null,}) {
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
as Map<String, String>,tirePhotosMap: null == tirePhotosMap ? _self._tirePhotosMap : tirePhotosMap // ignore: cast_nullable_to_non_nullable
as Map<String, String>,tirePhotosConfirmed: null == tirePhotosConfirmed ? _self.tirePhotosConfirmed : tirePhotosConfirmed // ignore: cast_nullable_to_non_nullable
as bool,tireDamageMap: null == tireDamageMap ? _self._tireDamageMap : tireDamageMap // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,tireCondition: freezed == tireCondition ? _self.tireCondition : tireCondition // ignore: cast_nullable_to_non_nullable
as String?,seatMaterial: freezed == seatMaterial ? _self.seatMaterial : seatMaterial // ignore: cast_nullable_to_non_nullable
as String?,seatMaterialConfirmed: null == seatMaterialConfirmed ? _self.seatMaterialConfirmed : seatMaterialConfirmed // ignore: cast_nullable_to_non_nullable
as bool,paintworkMarks: null == paintworkMarks ? _self._paintworkMarks : paintworkMarks // ignore: cast_nullable_to_non_nullable
as List<PaintworkMark>,paintworkConfirmed: null == paintworkConfirmed ? _self.paintworkConfirmed : paintworkConfirmed // ignore: cast_nullable_to_non_nullable
as bool,brokenFittingsPhotos: null == brokenFittingsPhotos ? _self._brokenFittingsPhotos : brokenFittingsPhotos // ignore: cast_nullable_to_non_nullable
as List<String>,brokenFittingMarks: null == brokenFittingMarks ? _self._brokenFittingMarks : brokenFittingMarks // ignore: cast_nullable_to_non_nullable
as List<BrokenFittingMark>,hasBrokenFittings: null == hasBrokenFittings ? _self.hasBrokenFittings : hasBrokenFittings // ignore: cast_nullable_to_non_nullable
as bool,brokenFittingsConfirmed: null == brokenFittingsConfirmed ? _self.brokenFittingsConfirmed : brokenFittingsConfirmed // ignore: cast_nullable_to_non_nullable
as bool,wheelDamageMap: null == wheelDamageMap ? _self._wheelDamageMap : wheelDamageMap // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,wheelDamageConfirmed: null == wheelDamageConfirmed ? _self.wheelDamageConfirmed : wheelDamageConfirmed // ignore: cast_nullable_to_non_nullable
as bool,hasToolPack: null == hasToolPack ? _self.hasToolPack : hasToolPack // ignore: cast_nullable_to_non_nullable
as bool,toolPackOption: freezed == toolPackOption ? _self.toolPackOption : toolPackOption // ignore: cast_nullable_to_non_nullable
as String?,toolPackConfirmed: null == toolPackConfirmed ? _self.toolPackConfirmed : toolPackConfirmed // ignore: cast_nullable_to_non_nullable
as bool,parcelShelfOption: freezed == parcelShelfOption ? _self.parcelShelfOption : parcelShelfOption // ignore: cast_nullable_to_non_nullable
as String?,parcelShelfConfirmed: null == parcelShelfConfirmed ? _self.parcelShelfConfirmed : parcelShelfConfirmed // ignore: cast_nullable_to_non_nullable
as bool,bonusPhotos: null == bonusPhotos ? _self._bonusPhotos : bonusPhotos // ignore: cast_nullable_to_non_nullable
as List<String>,bonusPhotosConfirmed: null == bonusPhotosConfirmed ? _self.bonusPhotosConfirmed : bonusPhotosConfirmed // ignore: cast_nullable_to_non_nullable
as bool,serviceHistoryInfoSeen: null == serviceHistoryInfoSeen ? _self.serviceHistoryInfoSeen : serviceHistoryInfoSeen // ignore: cast_nullable_to_non_nullable
as bool,serviceHistoryPhotos: null == serviceHistoryPhotos ? _self._serviceHistoryPhotos : serviceHistoryPhotos // ignore: cast_nullable_to_non_nullable
as List<String>,noServiceHistory: null == noServiceHistory ? _self.noServiceHistory : noServiceHistory // ignore: cast_nullable_to_non_nullable
as bool,serviceHistoryUploadConfirmed: null == serviceHistoryUploadConfirmed ? _self.serviceHistoryUploadConfirmed : serviceHistoryUploadConfirmed // ignore: cast_nullable_to_non_nullable
as bool,v5cLogBookOption: freezed == v5cLogBookOption ? _self.v5cLogBookOption : v5cLogBookOption // ignore: cast_nullable_to_non_nullable
as String?,v5cLogBookConfirmed: null == v5cLogBookConfirmed ? _self.v5cLogBookConfirmed : v5cLogBookConfirmed // ignore: cast_nullable_to_non_nullable
as bool,registeredKeeperOption: freezed == registeredKeeperOption ? _self.registeredKeeperOption : registeredKeeperOption // ignore: cast_nullable_to_non_nullable
as String?,registeredKeeperConfirmed: null == registeredKeeperConfirmed ? _self.registeredKeeperConfirmed : registeredKeeperConfirmed // ignore: cast_nullable_to_non_nullable
as bool,ownerFullName: null == ownerFullName ? _self.ownerFullName : ownerFullName // ignore: cast_nullable_to_non_nullable
as String,ownerNameConfirmed: null == ownerNameConfirmed ? _self.ownerNameConfirmed : ownerNameConfirmed // ignore: cast_nullable_to_non_nullable
as bool,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,phoneConfirmed: null == phoneConfirmed ? _self.phoneConfirmed : phoneConfirmed // ignore: cast_nullable_to_non_nullable
as bool,collectionAddress: null == collectionAddress ? _self.collectionAddress : collectionAddress // ignore: cast_nullable_to_non_nullable
as String,collectionAddressLine1: null == collectionAddressLine1 ? _self.collectionAddressLine1 : collectionAddressLine1 // ignore: cast_nullable_to_non_nullable
as String,collectionAddressLine2: null == collectionAddressLine2 ? _self.collectionAddressLine2 : collectionAddressLine2 // ignore: cast_nullable_to_non_nullable
as String,collectionAddressLine3: null == collectionAddressLine3 ? _self.collectionAddressLine3 : collectionAddressLine3 // ignore: cast_nullable_to_non_nullable
as String,collectionCity: null == collectionCity ? _self.collectionCity : collectionCity // ignore: cast_nullable_to_non_nullable
as String,collectionPostcode: null == collectionPostcode ? _self.collectionPostcode : collectionPostcode // ignore: cast_nullable_to_non_nullable
as String,collectionAddressConfirmed: null == collectionAddressConfirmed ? _self.collectionAddressConfirmed : collectionAddressConfirmed // ignore: cast_nullable_to_non_nullable
as bool,hasLockingWheelNut: null == hasLockingWheelNut ? _self.hasLockingWheelNut : hasLockingWheelNut // ignore: cast_nullable_to_non_nullable
as bool,lockingWheelNutOption: freezed == lockingWheelNutOption ? _self.lockingWheelNutOption : lockingWheelNutOption // ignore: cast_nullable_to_non_nullable
as String?,lockingWheelNutConfirmed: null == lockingWheelNutConfirmed ? _self.lockingWheelNutConfirmed : lockingWheelNutConfirmed // ignore: cast_nullable_to_non_nullable
as bool,warningLights: null == warningLights ? _self._warningLights : warningLights // ignore: cast_nullable_to_non_nullable
as List<String>,warningLightsConfirmed: null == warningLightsConfirmed ? _self.warningLightsConfirmed : warningLightsConfirmed // ignore: cast_nullable_to_non_nullable
as bool,chargingCables: null == chargingCables ? _self._chargingCables : chargingCables // ignore: cast_nullable_to_non_nullable
as List<String>,chargingCablesConfirmed: null == chargingCablesConfirmed ? _self.chargingCablesConfirmed : chargingCablesConfirmed // ignore: cast_nullable_to_non_nullable
as bool,interiorConditionIssues: null == interiorConditionIssues ? _self._interiorConditionIssues : interiorConditionIssues // ignore: cast_nullable_to_non_nullable
as List<String>,interiorConditionConfirmed: null == interiorConditionConfirmed ? _self.interiorConditionConfirmed : interiorConditionConfirmed // ignore: cast_nullable_to_non_nullable
as bool,damages: null == damages ? _self._damages : damages // ignore: cast_nullable_to_non_nullable
as List<DamageItem>,serviceHistoryType: freezed == serviceHistoryType ? _self.serviceHistoryType : serviceHistoryType // ignore: cast_nullable_to_non_nullable
as ServiceHistoryType?,serviceDocuments: null == serviceDocuments ? _self._serviceDocuments : serviceDocuments // ignore: cast_nullable_to_non_nullable
as List<String>,hasProofOfPurchase: null == hasProofOfPurchase ? _self.hasProofOfPurchase : hasProofOfPurchase // ignore: cast_nullable_to_non_nullable
as bool,proofOfPurchaseConfirmed: null == proofOfPurchaseConfirmed ? _self.proofOfPurchaseConfirmed : proofOfPurchaseConfirmed // ignore: cast_nullable_to_non_nullable
as bool,hasBeenSmokedIn: null == hasBeenSmokedIn ? _self.hasBeenSmokedIn : hasBeenSmokedIn // ignore: cast_nullable_to_non_nullable
as bool,smokingConfirmed: null == smokingConfirmed ? _self.smokingConfirmed : smokingConfirmed // ignore: cast_nullable_to_non_nullable
as bool,hasPrivatePlate: null == hasPrivatePlate ? _self.hasPrivatePlate : hasPrivatePlate // ignore: cast_nullable_to_non_nullable
as bool,privatePlateConfirmed: null == privatePlateConfirmed ? _self.privatePlateConfirmed : privatePlateConfirmed // ignore: cast_nullable_to_non_nullable
as bool,saleType: freezed == saleType ? _self.saleType : saleType // ignore: cast_nullable_to_non_nullable
as SaleType?,submissionStatus: null == submissionStatus ? _self.submissionStatus : submissionStatus // ignore: cast_nullable_to_non_nullable
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


/// @nodoc
mixin _$BrokenFittingMark {

 String get id; String get view; double get x; double get y; String get label; String? get photoPath;
/// Create a copy of BrokenFittingMark
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BrokenFittingMarkCopyWith<BrokenFittingMark> get copyWith => _$BrokenFittingMarkCopyWithImpl<BrokenFittingMark>(this as BrokenFittingMark, _$identity);

  /// Serializes this BrokenFittingMark to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BrokenFittingMark;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BrokenFittingMark&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.view, _this.view) || other.view == _this.view)&&(identical(other.x, _this.x) || other.x == _this.x)&&(identical(other.y, _this.y) || other.y == _this.y)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.photoPath, _this.photoPath) || other.photoPath == _this.photoPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BrokenFittingMark;
  return Object.hash(runtimeType,_this.id,_this.view,_this.x,_this.y,_this.label,_this.photoPath);
}

@override
String toString() {
  final _this = this as BrokenFittingMark;
  return 'BrokenFittingMark(id: ${_this.id}, view: ${_this.view}, x: ${_this.x}, y: ${_this.y}, label: ${_this.label}, photoPath: ${_this.photoPath})';
}


}

/// @nodoc
abstract mixin class $BrokenFittingMarkCopyWith<$Res>  {
  factory $BrokenFittingMarkCopyWith(BrokenFittingMark value, $Res Function(BrokenFittingMark) _then) = _$BrokenFittingMarkCopyWithImpl;
@useResult
$Res call({
 String id, String view, double x, double y, String label, String? photoPath
});




}
/// @nodoc
class _$BrokenFittingMarkCopyWithImpl<$Res>
    implements $BrokenFittingMarkCopyWith<$Res> {
  _$BrokenFittingMarkCopyWithImpl(this._self, this._then);

  final BrokenFittingMark _self;
  final $Res Function(BrokenFittingMark) _then;

/// Create a copy of BrokenFittingMark
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? view = null,Object? x = null,Object? y = null,Object? label = null,Object? photoPath = freezed,}) {
  return _then(BrokenFittingMark(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as String,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BrokenFittingMark].
extension BrokenFittingMarkPatterns on BrokenFittingMark {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BrokenFittingMark value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BrokenFittingMark() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BrokenFittingMark value)  $default,){
final _that = this;
switch (_that) {
case _BrokenFittingMark():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BrokenFittingMark value)?  $default,){
final _that = this;
switch (_that) {
case _BrokenFittingMark() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String view,  double x,  double y,  String label,  String? photoPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BrokenFittingMark() when $default != null:
return $default(_that.id,_that.view,_that.x,_that.y,_that.label,_that.photoPath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String view,  double x,  double y,  String label,  String? photoPath)  $default,) {final _that = this;
switch (_that) {
case _BrokenFittingMark():
return $default(_that.id,_that.view,_that.x,_that.y,_that.label,_that.photoPath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String view,  double x,  double y,  String label,  String? photoPath)?  $default,) {final _that = this;
switch (_that) {
case _BrokenFittingMark() when $default != null:
return $default(_that.id,_that.view,_that.x,_that.y,_that.label,_that.photoPath);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BrokenFittingMark implements BrokenFittingMark {
  const _BrokenFittingMark({required this.id, required this.view, required this.x, required this.y, required this.label, this.photoPath});
  factory _BrokenFittingMark.fromJson(Map<String, dynamic> json) => _$BrokenFittingMarkFromJson(json);

@override final  String id;
@override final  String view;
@override final  double x;
@override final  double y;
@override final  String label;
@override final  String? photoPath;

/// Create a copy of BrokenFittingMark
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BrokenFittingMarkCopyWith<_BrokenFittingMark> get copyWith => __$BrokenFittingMarkCopyWithImpl<_BrokenFittingMark>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BrokenFittingMarkToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BrokenFittingMark&&(identical(other.id, id) || other.id == id)&&(identical(other.view, view) || other.view == view)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.label, label) || other.label == label)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,view,x,y,label,photoPath);
}

@override
String toString() {
    return 'BrokenFittingMark(id: $id, view: $view, x: $x, y: $y, label: $label, photoPath: $photoPath)';
}


}

/// @nodoc
abstract mixin class _$BrokenFittingMarkCopyWith<$Res> implements $BrokenFittingMarkCopyWith<$Res> {
  factory _$BrokenFittingMarkCopyWith(_BrokenFittingMark value, $Res Function(_BrokenFittingMark) _then) = __$BrokenFittingMarkCopyWithImpl;
@override @useResult
$Res call({
 String id, String view, double x, double y, String label, String? photoPath
});




}
/// @nodoc
class __$BrokenFittingMarkCopyWithImpl<$Res>
    implements _$BrokenFittingMarkCopyWith<$Res> {
  __$BrokenFittingMarkCopyWithImpl(this._self, this._then);

  final _BrokenFittingMark _self;
  final $Res Function(_BrokenFittingMark) _then;

/// Create a copy of BrokenFittingMark
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? view = null,Object? x = null,Object? y = null,Object? label = null,Object? photoPath = freezed,}) {
  return _then(_BrokenFittingMark(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as String,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
