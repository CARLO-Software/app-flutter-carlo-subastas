// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Vehicle {

 String get plate; String get brand; String get model; int get year; String get color; String get fuelType; String get bodyType; int get doors; String get transmission; String get engineSize; String get ownership; String get motExpiry; double get mileage; double get estimatedPrice;
/// Create a copy of Vehicle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehicleCopyWith<Vehicle> get copyWith => _$VehicleCopyWithImpl<Vehicle>(this as Vehicle, _$identity);

  /// Serializes this Vehicle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Vehicle;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Vehicle&&(identical(other.plate, _this.plate) || other.plate == _this.plate)&&(identical(other.brand, _this.brand) || other.brand == _this.brand)&&(identical(other.model, _this.model) || other.model == _this.model)&&(identical(other.year, _this.year) || other.year == _this.year)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.fuelType, _this.fuelType) || other.fuelType == _this.fuelType)&&(identical(other.bodyType, _this.bodyType) || other.bodyType == _this.bodyType)&&(identical(other.doors, _this.doors) || other.doors == _this.doors)&&(identical(other.transmission, _this.transmission) || other.transmission == _this.transmission)&&(identical(other.engineSize, _this.engineSize) || other.engineSize == _this.engineSize)&&(identical(other.ownership, _this.ownership) || other.ownership == _this.ownership)&&(identical(other.motExpiry, _this.motExpiry) || other.motExpiry == _this.motExpiry)&&(identical(other.mileage, _this.mileage) || other.mileage == _this.mileage)&&(identical(other.estimatedPrice, _this.estimatedPrice) || other.estimatedPrice == _this.estimatedPrice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Vehicle;
  return Object.hash(runtimeType,_this.plate,_this.brand,_this.model,_this.year,_this.color,_this.fuelType,_this.bodyType,_this.doors,_this.transmission,_this.engineSize,_this.ownership,_this.motExpiry,_this.mileage,_this.estimatedPrice);
}

@override
String toString() {
  final _this = this as Vehicle;
  return 'Vehicle(plate: ${_this.plate}, brand: ${_this.brand}, model: ${_this.model}, year: ${_this.year}, color: ${_this.color}, fuelType: ${_this.fuelType}, bodyType: ${_this.bodyType}, doors: ${_this.doors}, transmission: ${_this.transmission}, engineSize: ${_this.engineSize}, ownership: ${_this.ownership}, motExpiry: ${_this.motExpiry}, mileage: ${_this.mileage}, estimatedPrice: ${_this.estimatedPrice})';
}


}

/// @nodoc
abstract mixin class $VehicleCopyWith<$Res>  {
  factory $VehicleCopyWith(Vehicle value, $Res Function(Vehicle) _then) = _$VehicleCopyWithImpl;
@useResult
$Res call({
 String plate, String brand, String model, int year, String color, String fuelType, String bodyType, int doors, String transmission, String engineSize, String ownership, String motExpiry, double mileage, double estimatedPrice
});




}
/// @nodoc
class _$VehicleCopyWithImpl<$Res>
    implements $VehicleCopyWith<$Res> {
  _$VehicleCopyWithImpl(this._self, this._then);

  final Vehicle _self;
  final $Res Function(Vehicle) _then;

/// Create a copy of Vehicle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? plate = null,Object? brand = null,Object? model = null,Object? year = null,Object? color = null,Object? fuelType = null,Object? bodyType = null,Object? doors = null,Object? transmission = null,Object? engineSize = null,Object? ownership = null,Object? motExpiry = null,Object? mileage = null,Object? estimatedPrice = null,}) {
  return _then(Vehicle(
plate: null == plate ? _self.plate : plate // ignore: cast_nullable_to_non_nullable
as String,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,fuelType: null == fuelType ? _self.fuelType : fuelType // ignore: cast_nullable_to_non_nullable
as String,bodyType: null == bodyType ? _self.bodyType : bodyType // ignore: cast_nullable_to_non_nullable
as String,doors: null == doors ? _self.doors : doors // ignore: cast_nullable_to_non_nullable
as int,transmission: null == transmission ? _self.transmission : transmission // ignore: cast_nullable_to_non_nullable
as String,engineSize: null == engineSize ? _self.engineSize : engineSize // ignore: cast_nullable_to_non_nullable
as String,ownership: null == ownership ? _self.ownership : ownership // ignore: cast_nullable_to_non_nullable
as String,motExpiry: null == motExpiry ? _self.motExpiry : motExpiry // ignore: cast_nullable_to_non_nullable
as String,mileage: null == mileage ? _self.mileage : mileage // ignore: cast_nullable_to_non_nullable
as double,estimatedPrice: null == estimatedPrice ? _self.estimatedPrice : estimatedPrice // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [Vehicle].
extension VehiclePatterns on Vehicle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Vehicle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Vehicle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Vehicle value)  $default,){
final _that = this;
switch (_that) {
case _Vehicle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Vehicle value)?  $default,){
final _that = this;
switch (_that) {
case _Vehicle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String plate,  String brand,  String model,  int year,  String color,  String fuelType,  String bodyType,  int doors,  String transmission,  String engineSize,  String ownership,  String motExpiry,  double mileage,  double estimatedPrice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Vehicle() when $default != null:
return $default(_that.plate,_that.brand,_that.model,_that.year,_that.color,_that.fuelType,_that.bodyType,_that.doors,_that.transmission,_that.engineSize,_that.ownership,_that.motExpiry,_that.mileage,_that.estimatedPrice);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String plate,  String brand,  String model,  int year,  String color,  String fuelType,  String bodyType,  int doors,  String transmission,  String engineSize,  String ownership,  String motExpiry,  double mileage,  double estimatedPrice)  $default,) {final _that = this;
switch (_that) {
case _Vehicle():
return $default(_that.plate,_that.brand,_that.model,_that.year,_that.color,_that.fuelType,_that.bodyType,_that.doors,_that.transmission,_that.engineSize,_that.ownership,_that.motExpiry,_that.mileage,_that.estimatedPrice);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String plate,  String brand,  String model,  int year,  String color,  String fuelType,  String bodyType,  int doors,  String transmission,  String engineSize,  String ownership,  String motExpiry,  double mileage,  double estimatedPrice)?  $default,) {final _that = this;
switch (_that) {
case _Vehicle() when $default != null:
return $default(_that.plate,_that.brand,_that.model,_that.year,_that.color,_that.fuelType,_that.bodyType,_that.doors,_that.transmission,_that.engineSize,_that.ownership,_that.motExpiry,_that.mileage,_that.estimatedPrice);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Vehicle implements Vehicle {
  const _Vehicle({required this.plate, required this.brand, required this.model, required this.year, required this.color, required this.fuelType, this.bodyType = '', this.doors = 4, this.transmission = '', this.engineSize = '', this.ownership = '', this.motExpiry = '', this.mileage = 0, this.estimatedPrice = 0});
  factory _Vehicle.fromJson(Map<String, dynamic> json) => _$VehicleFromJson(json);

@override final  String plate;
@override final  String brand;
@override final  String model;
@override final  int year;
@override final  String color;
@override final  String fuelType;
@override@JsonKey() final  String bodyType;
@override@JsonKey() final  int doors;
@override@JsonKey() final  String transmission;
@override@JsonKey() final  String engineSize;
@override@JsonKey() final  String ownership;
@override@JsonKey() final  String motExpiry;
@override@JsonKey() final  double mileage;
@override@JsonKey() final  double estimatedPrice;

/// Create a copy of Vehicle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VehicleCopyWith<_Vehicle> get copyWith => __$VehicleCopyWithImpl<_Vehicle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VehicleToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Vehicle&&(identical(other.plate, plate) || other.plate == plate)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.model, model) || other.model == model)&&(identical(other.year, year) || other.year == year)&&(identical(other.color, color) || other.color == color)&&(identical(other.fuelType, fuelType) || other.fuelType == fuelType)&&(identical(other.bodyType, bodyType) || other.bodyType == bodyType)&&(identical(other.doors, doors) || other.doors == doors)&&(identical(other.transmission, transmission) || other.transmission == transmission)&&(identical(other.engineSize, engineSize) || other.engineSize == engineSize)&&(identical(other.ownership, ownership) || other.ownership == ownership)&&(identical(other.motExpiry, motExpiry) || other.motExpiry == motExpiry)&&(identical(other.mileage, mileage) || other.mileage == mileage)&&(identical(other.estimatedPrice, estimatedPrice) || other.estimatedPrice == estimatedPrice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,plate,brand,model,year,color,fuelType,bodyType,doors,transmission,engineSize,ownership,motExpiry,mileage,estimatedPrice);
}

@override
String toString() {
    return 'Vehicle(plate: $plate, brand: $brand, model: $model, year: $year, color: $color, fuelType: $fuelType, bodyType: $bodyType, doors: $doors, transmission: $transmission, engineSize: $engineSize, ownership: $ownership, motExpiry: $motExpiry, mileage: $mileage, estimatedPrice: $estimatedPrice)';
}


}

/// @nodoc
abstract mixin class _$VehicleCopyWith<$Res> implements $VehicleCopyWith<$Res> {
  factory _$VehicleCopyWith(_Vehicle value, $Res Function(_Vehicle) _then) = __$VehicleCopyWithImpl;
@override @useResult
$Res call({
 String plate, String brand, String model, int year, String color, String fuelType, String bodyType, int doors, String transmission, String engineSize, String ownership, String motExpiry, double mileage, double estimatedPrice
});




}
/// @nodoc
class __$VehicleCopyWithImpl<$Res>
    implements _$VehicleCopyWith<$Res> {
  __$VehicleCopyWithImpl(this._self, this._then);

  final _Vehicle _self;
  final $Res Function(_Vehicle) _then;

/// Create a copy of Vehicle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? plate = null,Object? brand = null,Object? model = null,Object? year = null,Object? color = null,Object? fuelType = null,Object? bodyType = null,Object? doors = null,Object? transmission = null,Object? engineSize = null,Object? ownership = null,Object? motExpiry = null,Object? mileage = null,Object? estimatedPrice = null,}) {
  return _then(_Vehicle(
plate: null == plate ? _self.plate : plate // ignore: cast_nullable_to_non_nullable
as String,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,fuelType: null == fuelType ? _self.fuelType : fuelType // ignore: cast_nullable_to_non_nullable
as String,bodyType: null == bodyType ? _self.bodyType : bodyType // ignore: cast_nullable_to_non_nullable
as String,doors: null == doors ? _self.doors : doors // ignore: cast_nullable_to_non_nullable
as int,transmission: null == transmission ? _self.transmission : transmission // ignore: cast_nullable_to_non_nullable
as String,engineSize: null == engineSize ? _self.engineSize : engineSize // ignore: cast_nullable_to_non_nullable
as String,ownership: null == ownership ? _self.ownership : ownership // ignore: cast_nullable_to_non_nullable
as String,motExpiry: null == motExpiry ? _self.motExpiry : motExpiry // ignore: cast_nullable_to_non_nullable
as String,mileage: null == mileage ? _self.mileage : mileage // ignore: cast_nullable_to_non_nullable
as double,estimatedPrice: null == estimatedPrice ? _self.estimatedPrice : estimatedPrice // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
