import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/controller/cubit/user/user_cubit.dart';
import 'package:wander/controller/cubit/favorite/favorite_cubit.dart';
import 'package:wander/presentation/features/favorite/page.dart';
import 'package:wander/data/model/user.dart';

/// Fake UserCubit for logged-out state.
class FakeUserCubitLoggedOut extends UserCubit {
  @override
  get user => null;
}

/// Fake UserCubit for logged-in state.
class FakeUserCubitLoggedIn extends UserCubit {
  @override
  get user => User(id: "123", name: "Test User", email: "test@example.com");
}

/// Fake FavoriteCubit that remains in its initial (empty) state.
class FakeFavoriteCubit extends FavoriteCubit {}

void main() {
  testWidgets('displays login prompt when user is not logged in', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<UserCubit>(
              create: (_) => FakeUserCubitLoggedOut(),
            ),
            BlocProvider<FavoriteCubit>(
              create: (_) => FakeFavoriteCubit(),
            ),
          ],
          child: const FavoriteScreen(),
        ),
      ),
    );

    // Wait for the widget tree to settle.
    await tester.pumpAndSettle();

    // Expect to see the login prompt.
    expect(find.text("Please login first"), findsOneWidget);
    expect(find.text("Login"), findsOneWidget);
  });

  testWidgets('displays no favorites message when logged in and favorites are empty', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<UserCubit>(
              create: (_) => FakeUserCubitLoggedIn(),
            ),
            BlocProvider<FavoriteCubit>(
              create: (_) => FakeFavoriteCubit(),
            ),
          ],
          child: const FavoriteScreen(),
        ),
      ),
    );

    // Wait for the widget tree to settle.
    await tester.pumpAndSettle();

    // Expect to see the "no favorites" UI.
    expect(find.text("No favorites yet!"), findsOneWidget);
    expect(find.text("Add some places to your favorites."), findsOneWidget);
  });
}
