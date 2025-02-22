import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wander/presentation/features/favorite/page.dart';

void main() {
  testWidgets('FavoriteScreen UI renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: FavoriteScreen()));

    expect(find.text("No favorites yet!"), findsOneWidget);
    expect(find.text("Add some places to your favorites."), findsOneWidget);
  });
}
