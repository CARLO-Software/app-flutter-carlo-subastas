import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle.freezed.dart';
part 'vehicle.g.dart';

@freezed
class Vehicle with _$Vehicle {
  const factory Vehicle({
    required String plate,
    required String brand,
    required String model,
    required int year,
    required String color,
    required String fuelType,
    @Default('') String bodyType,
    @Default(4) int doors,
    @Default('') String transmission,
    @Default('') String engineSize,
    @Default('') String ownership,
    @Default('') String motExpiry,
    @Default(0) int mileage,
  }) = _Vehicle;

  factory Vehicle.fromJson(Map<String, dynamic> json) => _$VehicleFromJson(json);
}
