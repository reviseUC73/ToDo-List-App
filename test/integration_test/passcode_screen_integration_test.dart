import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todo_list/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Passcode Screen Test', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1200, 1800));


    await tester.pumpWidget(const MyApp());

    expect(find.text("This is just sample UI.\nOpen to create your style :D"), findsOneWidget);
    expect(find.byType(CircleAvatar), findsNWidgets(11)); 

    // ป้อนรหัสผ่านผิด
    await tester.tap(find.text('1'));
    await tester.tap(find.text('2'));
    await tester.tap(find.text('3'));
    await tester.tap(find.text('4'));
    await tester.tap(find.text('5'));
    await tester.tap(find.text('7'));
    await tester.pumpAndSettle(); 

    expect(find.text('Incorrect Passcode'), findsOneWidget);
  });
}
