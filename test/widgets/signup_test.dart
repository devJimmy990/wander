import 'package:firebase_auth/firebase_auth.dart' as UserModel;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/controller/cubit/auth/auth_state.dart';
import 'package:wander/presentation/features/auth/signup.dart';

// Fake cubit to bypass real signup logic.
class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  Future<void> onSignUpRequested(UserModel.User model) async => emit(AuthenticationLoading());
}

void main() {
  testWidgets('SignupScreen renders UI elements and validates input', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthenticationCubit>(
          create: (context) => AuthenticationCubit(),
          child: const SignupScreen(),
        ),
      ),
    );

    // Verify essential UI elements.
    expect(find.text("Welcome"), findsOneWidget);
    expect(find.text("Full Name"), findsOneWidget);
    expect(find.text("Email"), findsOneWidget);
    expect(find.text("Password"), findsOneWidget);
    expect(find.text("Sign Up"), findsOneWidget);

    // Tap the Sign Up button without entering any data.
    final signUpButton = find.text("Sign Up");
    await tester.tap(signUpButton);
    await tester.pump();

    // Expect validation errors for all required fields.
    expect(find.text("Full name is required."), findsOneWidget);
    expect(find.text("Email is required."), findsOneWidget);
    expect(find.text("Password is required."), findsOneWidget);
    expect(find.text("Confirm password is required."), findsOneWidget);

    // Enter an invalid email.
    final emailField = find.byType(TextFormField).at(1); // first is full name
    await tester.enterText(emailField, "invalidEmail");
    await tester.tap(signUpButton);
    await tester.pump();

    expect(find.text("Email must contain '@'."), findsOneWidget);

    // Test password mismatch:
    final passwordField = find.byType(TextFormField).at(2);
    final confirmPasswordField = find.byType(TextFormField).at(3);
    await tester.enterText(passwordField, "Test@password123");
    await tester.enterText(confirmPasswordField, "Testwrongpassword");
    await tester.tap(signUpButton);
    await tester.pump();

    expect(find.text("Passwords do not match."), findsOneWidget);
  });
}
