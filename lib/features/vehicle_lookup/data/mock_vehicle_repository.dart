import '../../../models/models.dart';

class MockVehicleRepository {
  Future<Vehicle?> lookupVehicle(String plate, int mileage) async {
    await Future.delayed(const Duration(seconds: 1));

    return Vehicle(
      plate: plate.toUpperCase(),
      brand: 'Toyota',
      model: 'Corolla',
      year: 2021,
      color: 'White',
      fuelType: 'Petrol',
      bodyType: 'Sedan',
      doors: 4,
      transmission: 'Automatic',
      engineSize: '1.8L',
      ownership: 'First Owner',
      motExpiry: '2025-06-15',
      mileage: mileage,
      estimatedPrice: _estimatePrice(mileage),
    );
  }

  double _estimatePrice(int mileage) {
    const basePrice = 55000.0;
    final deduction = (mileage / 1000) * 200;
    return (basePrice - deduction).clamp(8000.0, 55000.0);
  }
}

final mockVehicleRepository = MockVehicleRepository();
