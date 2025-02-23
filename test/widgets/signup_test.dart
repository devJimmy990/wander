import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/controller/cubit/auth/auth_state.dart';
import 'package:wander/presentation/features/auth/signup.dart';


class AuthenticationCubit extends Cubit<AuthenticationState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthenticationCubit() : super(AuthenticationInitial());

  Future<void> onSignUpRequested(model) async {
    // Immediately emit AccountCreated without calling Firebase.
    await Future.delayed(const Duration(seconds: 1));
    emit(AccountCreated());
  }
}

void main() {
  testWidgets('SignupScreen test account signup displays success dialog', (WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider<AuthenticationCubit>(
        create: (_) => AuthenticationCubit(),
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
