import 'package:flutter_test/flutter_test.dart';
import 'package:refocus_v1/main.dart';

void main() {
  testWidgets('App starts and renders successfully smoke test', (WidgetTester tester) async {
    await tester.runAsync(() async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Verify that the app starts up and doesn't crash.
      expect(find.byType(MyApp), findsOneWidget);
    });
  });
}
