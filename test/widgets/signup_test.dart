import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/controller/cubit/auth/auth_cubit.dart';
import 'package:wander/presentation/features/auth/signup.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  testWidgets('SignupScreen UI renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthenticationCubit>(
          create: (_) => AuthenticationCubit(),
          child: const SignupScreen(),
        ),
      ),
    );

    expect(find.text("Welcome"), findsOneWidget);
    expect(find.text("Full Name"), findsOneWidget);
    expect(find.text("Email"), findsOneWidget);
    expect(find.text("Password"), findsOneWidget);
    expect(find.text("Sign Up"), findsOneWidget);
  });

  testWidgets('Empty fields trigger validation messages', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthenticationCubit>(
          create: (_) => AuthenticationCubit(),
          child: const SignupScreen(),
        ),
      ),
    );

    final signUpButton = find.text("Sign Up");
    await tester.tap(signUpButton);
    await tester.pump();

    expect(find.text("Full name is required."), findsOneWidget);
    expect(find.text("Email is required."), findsOneWidget);
    expect(find.text("Password is required."), findsOneWidget);
    expect(find.text("Confirm password is required."), findsOneWidget);
  });

  testWidgets('Invalid email triggers error message', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthenticationCubit>(
          create: (_) => AuthenticationCubit(),
          child: const SignupScreen(),
        ),
      ),
    );

    final emailField = find.byType(TextFormField).at(1);
    await tester.enterText(emailField, "invalidEmail");
    await tester.tap(find.text("Sign Up"));
    await tester.pump();

    expect(find.text("Email must contain '@'."), findsOneWidget);
  });

  testWidgets('Password mismatch triggers validation error', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthenticationCubit>(
          create: (_) => AuthenticationCubit(),
          child: const SignupScreen(),
        ),
      ),
    );

    final passwordField = find.byType(TextFormField).at(2);
    final confirmPasswordField = find.byType(TextFormField).at(3);

    await tester.enterText(passwordField, "Test@password123");
    await tester.enterText(confirmPasswordField, "Testwrongpassword");

    await tester.tap(find.text("Sign Up"));
    await tester.pump();

    expect(find.text("Passwords do not match."), findsOneWidget);
  });

  testWidgets('Valid signup input does not trigger validation errors', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthenticationCubit>(
          create: (_) => AuthenticationCubit(),
          child: const SignupScreen(),
        ),
      ),
    );

    final nameField = find.byType(TextFormField).first;
    final emailField = find.byType(TextFormField).at(1);
    final passwordField = find.byType(TextFormField).at(2);
    final confirmPasswordField = find.byType(TextFormField).at(3);

    await tester.enterText(nameField, "ahmed");
    await tester.enterText(emailField, "ahmed@gmail.com");
    await tester.enterText(passwordField, "Test@123");
    await tester.enterText(confirmPasswordField, "Test@123");

    await tester.tap(find.text("Sign Up"));
    await tester.pump();

    expect(find.text("Full name is required."), findsNothing);
    expect(find.text("Email is required."), findsNothing);
    expect(find.text("Password is required."), findsNothing);
    expect(find.text("Confirm password is required."), findsNothing);
  });
}
