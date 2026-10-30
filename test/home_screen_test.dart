import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_carlo_subastas_mobile/features/home/presentation/home_screen.dart';
import 'package:app_carlo_subastas_mobile/features/home/providers/registered_vehicles_provider.dart';
import 'package:app_carlo_subastas_mobile/models/vehicle.dart';

Widget _wrap(Widget child) {
  return ProviderScope(
    child: MaterialApp(home: child),
  );
}

void main() {
  group('HomeScreen', () {
    testWidgets('shows empty state when no vehicles', (tester) async {
      await tester.pumpWidget(_wrap(const HomeScreen()));
      await tester.pump();

      expect(find.text('Sin vehículos registrados'), findsOneWidget);
      expect(find.text('Registrar vehículo'), findsWidgets);
    });

    testWidgets('shows FAB for new vehicle', (tester) async {
      await tester.pumpWidget(_wrap(const HomeScreen()));
      await tester.pump();

      expect(find.text('Nuevo vehículo'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('drawer opens with menu items', (tester) async {
      await tester.pumpWidget(_wrap(const HomeScreen()));
      await tester.pump();

      // Open drawer
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      expect(find.text('Registrar vehículo'), findsWidgets);
      expect(find.text('Mis vehículos'), findsOneWidget);
      expect(find.text('Mis subastas'), findsOneWidget);
      expect(find.text('Mi perfil'), findsOneWidget);
      expect(find.text('Cerrar sesión'), findsOneWidget);
    });

    testWidgets('shows vehicle cards when vehicles exist', (tester) async {
      final container = ProviderContainer(
        overrides: [
          registeredVehiclesProvider.overrideWith(() {
            final notifier = RegisteredVehiclesNotifier();
            return notifier;
          }),
        ],
      );

      // Add a vehicle via the notifier
      container.read(registeredVehiclesProvider.notifier).add(
        RegisteredVehicle(
          vehicle: const Vehicle(
            plate: 'ABC-123',
            brand: 'Toyota',
            model: 'Corolla',
            year: 2022,
            color: 'Blanco',
            fuelType: 'Gasolina',
            estimatedPrice: 45000,
          ),
          progress: 75,
          status: AuctionStatus.draft,
          createdAt: DateTime.now(),
        ),
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(home: HomeScreen()),
        ),
      );
      await tester.pump();

      expect(find.text('Mis vehículos'), findsOneWidget);
      expect(find.text('Toyota Corolla'), findsOneWidget);
      expect(find.text('ABC-123'), findsOneWidget);
      expect(find.text('Borrador'), findsOneWidget);
      expect(find.text('75% completado'), findsOneWidget);
    });
  });

  group('RegisteredVehiclesNotifier', () {
    test('starts empty', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(registeredVehiclesProvider), isEmpty);
    });

    test('add and remove vehicles', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(registeredVehiclesProvider.notifier);

      final v = RegisteredVehicle(
        vehicle: const Vehicle(
          plate: 'XYZ-789',
          brand: 'Honda',
          model: 'Civic',
          year: 2023,
          color: 'Negro',
          fuelType: 'Gasolina',
        ),
        progress: 100,
        status: AuctionStatus.submitted,
        createdAt: DateTime.now(),
      );

      notifier.add(v);
      expect(container.read(registeredVehiclesProvider).length, 1);

      notifier.remove(0);
      expect(container.read(registeredVehiclesProvider), isEmpty);
    });

    test('AuctionStatus labels are in Spanish', () {
      for (final status in AuctionStatus.values) {
        final rv = RegisteredVehicle(
          vehicle: const Vehicle(
            plate: 'T', brand: 'T', model: 'T', year: 2024, color: '', fuelType: '',
          ),
          progress: 0,
          status: status,
          createdAt: DateTime.now(),
        );
        expect(rv.statusLabel, isNotEmpty);
      }

      expect(
        RegisteredVehicle(
          vehicle: const Vehicle(plate: '', brand: '', model: '', year: 0, color: '', fuelType: ''),
          progress: 0,
          status: AuctionStatus.sold,
          createdAt: DateTime.now(),
        ).statusLabel,
        'Vendido',
      );
    });
  });
}
