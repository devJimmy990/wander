import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/controller/cubit/auth/auth_cubit.dart';
import 'package:wander/controller/cubit/auth/auth_state.dart';
import 'package:wander/presentation/features/auth/signup.dart';
import 'package:wander/data/model/user.dart';

class FakeAuthenticationCubitForSignup extends AuthenticationCubit {
  @override
  Future<void> onSignUpRequested(User model) async {
    // Immediately emit AccountCreated without calling Firebase.
    await Future.delayed(Duration.zero);
    emit(AccountCreated());
  }
}

void main() {
  testWidgets('SignupScreen test account signup displays success dialog', (WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider<AuthenticationCubit>(
        create: (_) => FakeAuthenticationCubitForSignup(),
        child: const MaterialApp(home: SignupScreen()),
      ),
    );
    await tester.pumpAndSettle();

    final nameField = find.byType(TextFormField).at(0);
    final emailField = find.byType(TextFormField).at(1);
    final passwordField = find.byType(TextFormField).at(2);
    final confirmPasswordField = find.byType(TextFormField).at(3);

    // Enter valid test values.
    await tester.enterText(nameField, "Test User");
    await tester.enterText(emailField, "test@example.com");
    await tester.enterText(passwordField, "Test@123");
    await tester.enterText(confirmPasswordField, "Test@123");

    // Tap the "Sign Up" button.
    final signUpButton = find.text("Sign Up");
    await tester.tap(signUpButton);
    await tester.pumpAndSettle();

    // Verify that the success dialog is shown.
    expect(find.text("Success"), findsOneWidget);
    expect(find.text("Account Created Successfully"), findsOneWidget);
  });
}
