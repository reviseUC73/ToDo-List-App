import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart'; // Import the integration_test package
import 'package:todo_list/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      'Test PasscodeScreen and navigation to TaskManagerScreen on correct passcode',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Enter passcode
    await tester.tap(find.text('1'));
    await tester.tap(find.text('2'));
    await tester.tap(find.text('3'));
    await tester.tap(find.text('4'));
    await tester.tap(find.text('5'));
    await tester.tap(find.text('6'));
    await tester.pumpAndSettle();

    // Verify navigation to TaskManagerScreen
    expect(find.text('Hi! User'), findsOneWidget);
  });
}
