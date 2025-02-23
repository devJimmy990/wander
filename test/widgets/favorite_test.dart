import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/controller/cubit/favorite/favorite_cubit.dart';
import 'package:wander/controller/cubit/user/user_cubit.dart';
import 'package:wander/data/model/user.dart';
import 'package:wander/presentation/features/favorite/page.dart';

/// A fake UserCubit simulating a logged-out state.
class FakeUserCubitLoggedOut extends UserCubit {
  @override
  get user => null;
}

/// A fake UserCubit simulating a logged-in user.
class FakeUserCubitLoggedIn extends UserCubit {
  @override
  get user => User(id: "123", name: "Test User", email: "test@example.com");
}

/// A fake FavoriteCubit that stays in the initial state.
class FakeFavoriteCubit extends FavoriteCubit {}

void main() {
  group('FavoriteScreen Widget Tests', () {
    testWidgets('displays login prompt when user is not logged in', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<UserCubit>(
                create: (context) => FakeUserCubitLoggedOut(),
              ),
              BlocProvider<FavoriteCubit>(
                create: (context) => FakeFavoriteCubit(),
              ),
            ],
            child: const FavoriteScreen(),
          ),
        ),
      );

      // Allow asynchronous events to settle.
      await tester.pumpAndSettle();

      // Verify the login prompt is shown.
      expect(find.text("Please login first"), findsOneWidget);
      expect(find.text("Login"), findsOneWidget);
    });

    testWidgets('displays no favorites message when logged in and favorites are empty', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<UserCubit>(
                create: (context) => FakeUserCubitLoggedIn(),
              ),
              BlocProvider<FavoriteCubit>(
                create: (context) => FakeFavoriteCubit(),
              ),
            ],
            child: const FavoriteScreen(),
          ),
        ),
      );

      // Allow asynchronous events to settle.
      await tester.pumpAndSettle();

      // Verify that the "No favorites yet!" message is displayed.
      expect(find.text("No favorites yet!"), findsOneWidget);
      expect(find.text("Add some places to your favorites."), findsOneWidget);
    });
  });
}
