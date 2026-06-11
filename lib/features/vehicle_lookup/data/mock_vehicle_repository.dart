import '../../../models/models.dart';

class MockVehicleRepository {
  Future<Vehicle?> lookupVehicle(String plate, int mileage) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Return mock vehicle data
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
    );
  }
}

final mockVehicleRepository = MockVehicleRepository();
