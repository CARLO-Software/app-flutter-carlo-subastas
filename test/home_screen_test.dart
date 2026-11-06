import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_carlo_subastas_mobile/features/home/presentation/home_screen.dart';
import 'package:app_carlo_subastas_mobile/features/home/providers/registered_vehicles_provider.dart';

Widget _wrap(Widget child, {List<Override> overrides = const []}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(home: child),
  );
}

final _emptyOverride = registeredVehiclesProvider.overrideWith(() => _FakeNotifier([]));

final _withVehiclesOverride = registeredVehiclesProvider.overrideWith(() => _FakeNotifier([
      RegisteredVehicle(
        id: 'uuid-1',
        identifier: 'REG-001',
        vehicleLabel: 'Toyota Corolla 2022',
        plate: 'ABC-123',
        status: AuctionStatus.submitted,
        createdAt: DateTime(2026, 11, 6),
      ),
    ]));

class _FakeNotifier extends AsyncNotifier<List<RegisteredVehicle>>
    implements RegisteredVehiclesNotifier {
  final List<RegisteredVehicle> _data;
  _FakeNotifier(this._data);

  @override
  Future<List<RegisteredVehicle>> build() async => _data;

  @override
  Future<void> refresh() async {}
}

void main() {
  group('HomeScreen', () {
    testWidgets('shows empty state when no vehicles', (tester) async {
      await tester.pumpWidget(_wrap(const HomeScreen(), overrides: [_emptyOverride]));
      await tester.pumpAndSettle();

      expect(find.text('Sin vehículos registrados'), findsOneWidget);
      expect(find.text('Registrar vehículo'), findsWidgets);
    });

    testWidgets('shows FAB for new vehicle', (tester) async {
      await tester.pumpWidget(_wrap(const HomeScreen(), overrides: [_emptyOverride]));
      await tester.pumpAndSettle();

      expect(find.text('Nuevo vehículo'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('shows vehicle cards when vehicles exist', (tester) async {
      await tester.pumpWidget(_wrap(const HomeScreen(), overrides: [_withVehiclesOverride]));
      await tester.pumpAndSettle();

      expect(find.text('Mis vehículos'), findsOneWidget);
      expect(find.text('Toyota Corolla 2022'), findsOneWidget);
      expect(find.text('ABC-123'), findsOneWidget);
      expect(find.text('Enviado'), findsOneWidget);
    });
  });

  group('AuctionStatus labels', () {
    test('all labels are in Spanish', () {
      for (final status in AuctionStatus.values) {
        final rv = RegisteredVehicle(
          id: 't',
          identifier: '',
          vehicleLabel: 'Test',
          plate: 'T',
          status: status,
          createdAt: DateTime.now(),
        );
        expect(rv.statusLabel, isNotEmpty);
      }
    });

    test('sold label is Vendido', () {
      expect(
        RegisteredVehicle(
          id: 't',
          identifier: '',
          vehicleLabel: '',
          plate: '',
          status: AuctionStatus.sold,
          createdAt: DateTime.now(),
        ).statusLabel,
        'Vendido',
      );
    });
  });
}
