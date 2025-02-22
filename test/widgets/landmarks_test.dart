import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wander/presentation/features/governorates/landmark.dart';

void main() {
  testWidgets('LandmarksPage UI renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LandmarksPage(governorate: "Cairo")));

    expect(find.text("Landmarks in Cairo"), findsOneWidget);
  });
}
