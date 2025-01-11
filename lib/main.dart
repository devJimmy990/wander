import 'package:wander/home.dart';
import 'package:flutter/material.dart';
import 'package:wander/core/routes.dart';
import 'package:wander/generated/l10n.dart';
import 'package:wander/presentation/splash_screen.dart';
import 'package:wander/presentation/screens/login.dart';
import 'package:wander/presentation/screens/signup.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      routes: {
        Routes.home: (context) => MainScreen(),
        Routes.login: (context) => LoginScreen(),
        Routes.signup: (context) => SignupScreen(),
        Routes.splash: (context) => const SplashScreen(),
      },
      initialRoute: Routes.login,
    );
  }
}
