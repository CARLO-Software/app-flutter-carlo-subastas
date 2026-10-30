import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_carlo_subastas_mobile/main.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: CarloVehicleApp(),
      ),
    );

    await tester.pump();

    expect(find.text('Carlo Subastas'), findsOneWidget);

    // Drain the splash screen's navigation timer
    await tester.pumpAndSettle(const Duration(seconds: 2));
  });
}
