import 'package:wander/home.dart';
import 'package:flutter/material.dart';
import 'package:wander/core/routes.dart';
import 'package:wander/presentation/screens/login.dart';
import 'package:wander/presentation/screens/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Routes.home: (context) => MainScreen(),
        Routes.login: (context) => LoginScreen(),
        Routes.signup: (context) => SignupScreen(),
      },
      initialRoute: Routes.login,
    );
  }
}
