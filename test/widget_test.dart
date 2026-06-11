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

    // Wait for the splash screen to render
    await tester.pump();

    // Verify the app has launched
    expect(find.text('Carlo'), findsOneWidget);
  });
}
