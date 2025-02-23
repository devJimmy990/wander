import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:wander/controller/cubit/auth/index.dart';
import 'package:wander/presentation/features/auth/signup.dart';

void main() {
  testWidgets('SignupScreen renders correctly', (tester) async {
    await tester.pumpWidget(
      BlocProvider(
        create: (_) => AuthenticationCubit(),
        child: const MaterialApp(home: SignupScreen()),
      ),
    );

    // Verify logo image
    expect(find.byType(CircleAvatar), findsOneWidget);
    // Verify "Welcome" text
    expect(find.text('Welcome'), findsOneWidget);
    // Verify name field
    expect(find.byIcon(Icons.person), findsOneWidget);
    // Verify email field
    expect(find.byIcon(Icons.email), findsOneWidget);
    // Verify phone field
    expect(find.byType(IntlPhoneField), findsOneWidget);
    // Verify password fields
    expect(find.byIcon(Icons.lock), findsNWidgets(3));
    // Verify signup button
    expect(find.text('Sign Up'), findsOneWidget);
  });
}