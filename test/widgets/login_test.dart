import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/controller/cubit/auth/auth_cubit.dart';
import 'package:wander/controller/cubit/user/user_cubit.dart';
import 'package:wander/presentation/features/auth/login.dart';

class FakeAuthenticationCubit extends AuthenticationCubit {
  @override
  Future<void> onLoginRequested({required String email, required String password}) async {

  }
}

class FakeUserCubit extends UserCubit {
  @override
  get user => null;
}

void main() {
  testWidgets('LoginScreen displays expected UI elements', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationCubit>(
              create: (context) => FakeAuthenticationCubit(),
            ),
            BlocProvider<UserCubit>(
              create: (context) => FakeUserCubit(),
            ),
          ],
          child: const LoginScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Wander'), findsOneWidget);
    expect(find.byIcon(Icons.email), findsOneWidget);
    // Two icons: one for prefix on email and one for prefix on password.
    expect(find.byIcon(Icons.lock), findsNWidgets(2));
    expect(find.text('Login'), findsOneWidget);
    expect(find.text("Don't have an account? Sign up"), findsOneWidget);
  });
}
