import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/controller/cubit/favorite/favorite_cubit.dart';
import 'package:wander/controller/cubit/user/user_cubit.dart';
import 'package:wander/data/model/user.dart';
import 'package:wander/presentation/features/favorite/page.dart';

/// A fake UserCubit for when the user is not logged in.
class FakeUserCubitLoggedOut extends UserCubit {
  @override
  get user => null;
}

/// A fake UserCubit for when the user is logged in.
class FakeUserCubitLoggedIn extends UserCubit {
  @override
  get user => User(id: "123", name: "Test User", email: "test@example.com");
}

/// A fake FavoriteCubit. It simply uses the default state (FavoriteInitial),
/// which causes the FavoriteScreen to show the "No favorites yet!" UI.
class FakeFavoriteCubit extends FavoriteCubit {}

void main() {
  group('FavoriteScreen Widget Tests', () {
    testWidgets('displays login prompt when user is not logged in', (tester) async {
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

      // When no user is logged in, the login prompt should be shown.
      expect(find.text("Please login first"), findsOneWidget);
      expect(find.text("Login"), findsOneWidget);
    });

    testWidgets('displays no favorites message when logged in and favorites are empty', (tester) async {
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

      // When logged in but with no favorites, the "No favorites yet!" UI is shown.
      expect(find.text("No favorites yet!"), findsOneWidget);
      expect(find.text("Add some places to your favorites."), findsOneWidget);
    });
  });
}
