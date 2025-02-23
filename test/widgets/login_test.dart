import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wander/controller/cubit/auth/index.dart';
import 'package:wander/controller/cubit/user/user_cubit.dart';
import 'package:wander/presentation/features/auth/login.dart';
import 'package:wander/utils/constants/image_strings.dart';


void main() {
  testWidgets('LoginScreen renders correctly', (tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthenticationCubit()),
          BlocProvider(create: (_) => UserCubit()),
        ],
        child: const MaterialApp(home: LoginScreen()),
      ),
    );

    // Verify "Wander" text
    expect(find.text('Wander'), findsOneWidget);
    // Verify email field
    expect(find.byIcon(Icons.email), findsOneWidget);
    // Verify password field
    expect(find.byIcon(Icons.lock), findsNWidgets(2));
    // Verify login button
    expect(find.text('Login'), findsOneWidget);
    // Verify signup link
    expect(find.text("Don't have an account? Sign up"), findsOneWidget);
  });
}