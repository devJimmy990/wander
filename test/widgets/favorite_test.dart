import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/controller/cubit/user/user_cubit.dart';
import 'package:wander/presentation/features/favorite/page.dart';

void main() {
  testWidgets('FavoriteScreen UI renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<UserCubit>(
          create: (context) => UserCubit(),
          child: const FavoriteScreen(),
        ),
      ),
    );

    // Allow all asynchronous events to settle.
    await tester.pumpAndSettle();

    expect(find.text("No favorites yet!"), findsOneWidget);
    expect(find.text("Add some places to your favorites."), findsOneWidget);
  });
}
