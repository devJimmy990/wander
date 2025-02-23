import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/controller/cubit/auth/auth_cubit.dart';
import 'package:wander/presentation/features/auth/login.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  testWidgets('LoginScreen UI renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthenticationCubit>(
          create: (_) => AuthenticationCubit(),
          child: const LoginScreen(),
        ),
      ),
    );

    expect(find.text("Wander"), findsOneWidget);
    expect(find.text("Email"), findsOneWidget);
    expect(find.text("Password"), findsOneWidget);
    expect(find.text("Login"), findsOneWidget);
  });

  testWidgets('Empty fields trigger validation messages', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthenticationCubit>(
          create: (_) => AuthenticationCubit(),
          child: const LoginScreen(),
        ),
      ),
    );

    final loginButton = find.text("Login");
    await tester.tap(loginButton);
    await tester.pump();

    expect(find.text("Email is required."), findsOneWidget);
    expect(find.text("Password is required."), findsOneWidget);
  });

  testWidgets('Invalid email triggers error message', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthenticationCubit>(
          create: (_) => AuthenticationCubit(),
          child: const LoginScreen(),
        ),
      ),
    );

    final emailField = find.byType(TextFormField).first;
    await tester.enterText(emailField, "invalidEmail");
    await tester.tap(find.text("Login"));
    await tester.pump();

    expect(find.text("Email must contain '@'."), findsOneWidget);
  });

  testWidgets('Valid login input does not trigger validation errors', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthenticationCubit>(
          create: (_) => AuthenticationCubit(),
          child: const LoginScreen(),
        ),
      ),
    );

    final emailField = find.byType(TextFormField).first;
    final passwordField = find.byType(TextFormField).last;

    await tester.enterText(emailField, "test@gmail.com");
    await tester.enterText(passwordField, "testpassword123");

    await tester.tap(find.text("Login"));
    await tester.pump();

    expect(find.text("Email is required."), findsNothing);
    expect(find.text("Password is required."), findsNothing);
  });
}
