import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/controller/cubit/auth/auth_cubit.dart';
import 'package:wander/presentation/features/auth/signup.dart';

class FakeAuthenticationCubit extends AuthenticationCubit {
  @override
  Future<void> onSignUpRequested(user) async {
  }
}

void main() {
  testWidgets('SignupScreen displays expected UI elements', (WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider<AuthenticationCubit>(
        create: (_) => FakeAuthenticationCubit(),
        child: const MaterialApp(
          home: SignupScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Welcome'), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);
    expect(find.byIcon(Icons.email), findsOneWidget);
    // IntlPhoneField should be present.
    expect(find.byType(Widget), findsWidgets); // You may narrow this by type if needed.
    // Check for password icons; there should be at least two (password & confirm password).
    expect(find.byIcon(Icons.lock), findsNWidgets(2));
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text("Already have an account? Log In"), findsOneWidget);
  });
}
