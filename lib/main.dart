import 'package:flutter/material.dart';
import 'package:wander/core/index.dart';
import 'package:wander/controller/cubit/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wander/presentation/features/_screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreference.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LandmarkCubit()),
        BlocProvider(create: (context) => FavoriteCubit()),
        BlocProvider(create: (context) => AuthenticationCubit()),
        BlocProvider(create: (context) => UserCubit()..loadUser()),
        BlocProvider(create: (context) => ThemeCubit()..loadTheme()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
        ThemeData themeData = ThemeData.light();

        if (state is ThemeLoaded || state is ToggleThemeState) {
          themeData = (state as dynamic).theme;
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeData,
          routes: {
            // Auth Screens {Login, Signup}
            Routes.login: (context) => const LoginScreen(),
            Routes.signup: (context) => const SignupScreen(),

            // Setting Screen
            Routes.settings: (context) => const AccountSettingsScreen(),

            // Landing Screen
            Routes.landing: (context) => const LandingScreen(),
          },
          initialRoute: Routes.landing,
        );
      }),
    );
  }
}
