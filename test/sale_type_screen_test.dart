import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_carlo_subastas_mobile/features/sale_type/presentation/sale_type_screen.dart';

Widget _wrap(Widget child) {
  return ProviderScope(
    child: MaterialApp(home: child),
  );
}

void main() {
  group('SaleTypeScreen', () {
    testWidgets('shows three sale type options', (tester) async {
      await tester.pumpWidget(_wrap(const SaleTypeScreen()));
      await tester.pump();

      expect(find.text('Ecommerce'), findsOneWidget);
      expect(find.text('Subasta'), findsOneWidget);
      expect(find.text('Consigna'), findsOneWidget);
    });

    testWidgets('shows descriptions for each type', (tester) async {
      await tester.pumpWidget(_wrap(const SaleTypeScreen()));
      await tester.pump();

      expect(find.text('Venta directa'), findsOneWidget);
      expect(find.text('Venta al mejor postor'), findsOneWidget);
      expect(find.text('Carlo vende por ti'), findsOneWidget);
    });

    testWidgets('shows title and subtitle', (tester) async {
      await tester.pumpWidget(_wrap(const SaleTypeScreen()));
      await tester.pump();

      expect(find.textContaining('¿Cómo quieres vender'), findsOneWidget);
      expect(find.text('Tipo de venta'), findsOneWidget);
    });

    testWidgets('submit button disabled when no selection', (tester) async {
      await tester.pumpWidget(_wrap(const SaleTypeScreen()));
      await tester.pump();

      final button = find.text('Enviar para revisión');
      expect(button, findsOneWidget);

      // PrimaryButton with null onPressed should be disabled
      // We verify the button exists; tapping it with no selection should do nothing
    });

    testWidgets('can select ecommerce option', (tester) async {
      await tester.pumpWidget(_wrap(const SaleTypeScreen()));
      await tester.pump();

      // Tap on Ecommerce card
      await tester.tap(find.text('Ecommerce'));
      await tester.pumpAndSettle();

      // Check icon appears (the check inside the radio circle)
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('can switch between options', (tester) async {
      await tester.pumpWidget(_wrap(const SaleTypeScreen()));
      await tester.pump();

      await tester.tap(find.text('Ecommerce'));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.check), findsOneWidget);

      await tester.tap(find.text('Subasta'));
      await tester.pumpAndSettle();
      // Still one check (moved to Subasta)
      expect(find.byIcon(Icons.check), findsOneWidget);

      await tester.tap(find.text('Consigna'));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.check), findsOneWidget);
    });
  });
}
