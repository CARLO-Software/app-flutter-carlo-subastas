// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VehicleImpl _$$VehicleImplFromJson(Map<String, dynamic> json) =>
    _$VehicleImpl(
      plate: json['plate'] as String,
      brand: json['brand'] as String,
      model: json['model'] as String,
      year: (json['year'] as num).toInt(),
      color: json['color'] as String,
      fuelType: json['fuelType'] as String,
      bodyType: json['bodyType'] as String? ?? '',
      doors: (json['doors'] as num?)?.toInt() ?? 4,
      transmission: json['transmission'] as String? ?? '',
      engineSize: json['engineSize'] as String? ?? '',
      ownership: json['ownership'] as String? ?? '',
      motExpiry: json['motExpiry'] as String? ?? '',
      mileage: (json['mileage'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$VehicleImplToJson(_$VehicleImpl instance) =>
    <String, dynamic>{
      'plate': instance.plate,
      'brand': instance.brand,
      'model': instance.model,
      'year': instance.year,
      'color': instance.color,
      'fuelType': instance.fuelType,
      'bodyType': instance.bodyType,
      'doors': instance.doors,
      'transmission': instance.transmission,
      'engineSize': instance.engineSize,
      'ownership': instance.ownership,
      'motExpiry': instance.motExpiry,
      'mileage': instance.mileage,
    };
