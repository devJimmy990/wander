import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wander/presentation/features/governorates/page.dart';

void main() {
  testWidgets('GovernmentsScreen UI renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: GovernmentsScreen()));

    expect(find.text("Cairo"), findsOneWidget);
    expect(find.text("Alexandria"), findsOneWidget);
    expect(find.text("Luxor"), findsOneWidget);
  });
}
