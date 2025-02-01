import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wander/blocs/Favourate/FavBloc.dart';
import 'package:wander/blocs/LandMark/LandMarkBloc.dart';
import 'package:wander/blocs/auth/auth_bloc.dart';
import 'package:wander/blocs/profile/profile_bloc.dart';
import 'package:wander/blocs/theme/theme_bloc.dart';
import 'package:wander/core/routes.dart';
import 'package:wander/core/shared_prefrence.dart';
import 'package:wander/home.dart';
import 'package:wander/presentation/screens/login.dart';
import 'package:wander/presentation/screens/signup.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPreference.initialize();

  final userId = SharedPreference.getString(key: 'userId') ?? '';

  runApp(MyApp(userId: userId));
}

class MyApp extends StatelessWidget {
  final String userId;

  const MyApp({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(create: (context) => FavoriteBloc()),
        BlocProvider(create: (context) => LandmarkBloc()),
        BlocProvider(create: (context) => ThemeBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          Routes.home: (context) => const MainScreen(),
          Routes.login: (context) => const LoginScreen(),
          Routes.signup: (context) => const SignupScreen(),
        },
        initialRoute: Routes.login,
      ),
    );
  }
}
