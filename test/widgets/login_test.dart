import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/controller/cubit/auth/auth_cubit.dart';
import 'package:wander/controller/cubit/auth/auth_state.dart';
import 'package:wander/presentation/features/auth/login.dart';

/// A fake AuthenticationCubit that bypasses real authentication logic.
class FakeAuthenticationCubit extends AuthenticationCubit {
  @override
  Future<void> onLoginRequested({required String email, required String password}) async {
    emit(AuthenticationInitial());
  }
}

Future<void> main() async {
  // Ensure the binding is initialized.
  TestWidgetsFlutterBinding.ensureInitialized();

  // Set a mock handler to prevent native channel calls.
  FirebaseCorePlatform.instance.setMethodCallHandler((call) async {
    return null;
  });

  // Initialize Firebase with dummy options.
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'fake_api_key',
      appId: 'fake_app_id',
      messagingSenderId: 'fake_sender_id',
      projectId: 'fake_project_id',
    ),
  );

  testWidgets('LoginScreen renders UI elements and validates input', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthenticationCubit>(
          create: (_) => FakeAuthenticationCubit(),
          child: const LoginScreen(),
        ),
      ),
    );

    // Let the widget build completely.
    await tester.pumpAndSettle();

    // Verify key UI elements are present.
    expect(find.text("Wander"), findsOneWidget);
    expect(find.text("Email"), findsOneWidget);
    expect(find.text("Password"), findsOneWidget);
    expect(find.text("Login"), findsOneWidget);

    // Tap the Login button without entering any text.
    final loginButton = find.text("Login");
    await tester.tap(loginButton);
    await tester.pump();

    // Expect validation messages for empty email and password.
    expect(find.text("Email is required."), findsOneWidget);
    expect(find.text("Password is required."), findsOneWidget);

    // Enter an invalid email and a valid password.
    final emailField = find.byType(TextFormField).first;
    final passwordField = find.byType(TextFormField).last;
    await tester.enterText(emailField, "invalidEmail");
    await tester.enterText(passwordField, "password123");
    await tester.tap(loginButton);
    await tester.pump();

    // Expect the invalid email error message.
    expect(find.text("Email must contain '@'."), findsOneWidget);

    // Now enter valid values.
    await tester.enterText(emailField, "test@gmail.com");
    await tester.enterText(passwordField, "password123");
    await tester.tap(loginButton);
    await tester.pump();

    // With valid input, validation errors should disappear.
    expect(find.text("Email is required."), findsNothing);
    expect(find.text("Password is required."), findsNothing);
  });
}
