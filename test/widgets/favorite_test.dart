import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/controller/cubit/user/user_cubit.dart';
import 'package:wander/controller/cubit/favorite/favorite_cubit.dart';
import 'package:wander/presentation/features/favorite/page.dart';
import 'package:wander/data/model/user.dart';

class FakeUserCubit extends UserCubit {
  @override
  get user => User(id: "123", name: "Test User", email: "test@gmail.com");
}

void main() {
  testWidgets('FavoriteScreen UI renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<UserCubit>(
              create: (context) => FakeUserCubit(),
            ),
            BlocProvider<FavoriteCubit>(
              create: (context) => FavoriteCubit(),
            ),
          ],
          child: const FavoriteScreen(),
        ),
      ),
    );

    // Allow all asynchronous events to settle.
    await tester.pumpAndSettle();

    // Expect the "No favorites yet!" branch to be rendered.
    expect(find.text("No favorites yet!"), findsOneWidget);
    expect(find.text("Add some places to your favorites."), findsOneWidget);
  });
}
