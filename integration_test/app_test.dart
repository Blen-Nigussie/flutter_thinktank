import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:thinktank/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-end test', () {
    testWidgets('App should start and show login screen', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify login screen is shown
      expect(find.text('Login'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2)); // Email and password fields
      expect(find.byType(ElevatedButton), findsOneWidget); // Login button
    });

    testWidgets('User can login and see dashboard', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Enter credentials
      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
      await tester.enterText(find.byType(TextFormField).last, 'password123');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify dashboard is shown
      expect(find.text('Dashboard'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('User can create a new idea', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Login first
      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
      await tester.enterText(find.byType(TextFormField).last, 'password123');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Navigate to create idea screen
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Fill idea form
      await tester.enterText(find.byType(TextFormField).first, 'Test Idea');
      await tester.enterText(find.byType(TextFormField).last, 'Test Description');
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      // Verify idea is created
      expect(find.text('Test Idea'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
    });
  });
} 