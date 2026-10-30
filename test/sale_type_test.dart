import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_carlo_subastas_mobile/models/vehicle_registration_state.dart';
import 'package:app_carlo_subastas_mobile/shared/providers/vehicle_registration_provider.dart';

void main() {
  group('SaleType enum', () {
    test('has all three values', () {
      expect(SaleType.values.length, 3);
      expect(SaleType.values, contains(SaleType.ecommerce));
      expect(SaleType.values, contains(SaleType.auction));
      expect(SaleType.values, contains(SaleType.consignment));
    });

    test('serializes to correct names', () {
      expect(SaleType.ecommerce.name, 'ecommerce');
      expect(SaleType.auction.name, 'auction');
      expect(SaleType.consignment.name, 'consignment');
    });
  });

  group('VehicleRegistrationState.saleType', () {
    test('defaults to null', () {
      const state = VehicleRegistrationState();
      expect(state.saleType, isNull);
    });

    test('can be set via copyWith', () {
      const state = VehicleRegistrationState();
      final updated = state.copyWith(saleType: SaleType.auction);
      expect(updated.saleType, SaleType.auction);
    });

    test('serializes to JSON and back', () {
      const state = VehicleRegistrationState(saleType: SaleType.consignment);
      final json = state.toJson();
      expect(json['saleType'], 'consignment');

      final restored = VehicleRegistrationState.fromJson(json);
      expect(restored.saleType, SaleType.consignment);
    });

    test('null saleType serializes correctly', () {
      const state = VehicleRegistrationState();
      final json = state.toJson();
      expect(json['saleType'], isNull);

      final restored = VehicleRegistrationState.fromJson(json);
      expect(restored.saleType, isNull);
    });
  });

  group('VehicleRegistrationNotifier.setSaleType', () {
    test('updates state with sale type', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(vehicleRegistrationProvider.notifier);

      expect(container.read(vehicleRegistrationProvider).saleType, isNull);

      notifier.setSaleType(SaleType.ecommerce);
      expect(container.read(vehicleRegistrationProvider).saleType, SaleType.ecommerce);

      notifier.setSaleType(SaleType.consignment);
      expect(container.read(vehicleRegistrationProvider).saleType, SaleType.consignment);
    });

    test('reset clears sale type', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(vehicleRegistrationProvider.notifier);
      notifier.setSaleType(SaleType.auction);
      expect(container.read(vehicleRegistrationProvider).saleType, SaleType.auction);

      notifier.reset();
      expect(container.read(vehicleRegistrationProvider).saleType, isNull);
    });
  });

  group('Review screen data completeness', () {
    test('state holds all fields shown in review', () {
      final state = VehicleRegistrationState(
        ownerFullName: 'Juan Pérez',
        phoneNumber: '+51 999 888 777',
        collectionAddressLine1: 'Av. Javier Prado 123',
        collectionCity: 'Lima',
        interiorConditionIssues: ['manchas', 'rasgaduras'],
        chargingCables: ['tipo_2'],
        parcelShelfOption: 'tiene',
        paintworkMarks: [
          PaintworkMark(id: '1', view: 'left', x: 100, y: 200, size: 'small'),
        ],
        bonusPhotos: ['/path/photo1.jpg'],
        serviceHistoryPhotos: ['/path/doc1.jpg'],
        serviceDocuments: ['/path/doc2.jpg'],
        v5cLogBookOption: 'tiene',
        registeredKeeperOption: 'si',
      );

      // All these fields should be non-null/non-empty for review display
      expect(state.ownerFullName, isNotEmpty);
      expect(state.phoneNumber, isNotEmpty);
      expect(state.collectionAddressLine1, isNotEmpty);
      expect(state.collectionCity, isNotEmpty);
      expect(state.interiorConditionIssues, isNotEmpty);
      expect(state.chargingCables, isNotEmpty);
      expect(state.parcelShelfOption, isNotNull);
      expect(state.paintworkMarks, isNotEmpty);
      expect(state.bonusPhotos, isNotEmpty);
      expect(state.serviceHistoryPhotos, isNotEmpty);
      expect(state.serviceDocuments, isNotEmpty);
      expect(state.v5cLogBookOption, isNotNull);
      expect(state.registeredKeeperOption, isNotNull);
    });

    test('submission payload includes saleType', () {
      const state = VehicleRegistrationState(saleType: SaleType.auction);
      // saleType.name produces the string for the API payload
      expect(state.saleType?.name, 'auction');
    });
  });
}
