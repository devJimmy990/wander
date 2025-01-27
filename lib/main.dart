import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/blocs/Favourate/FavBloc.dart';
import 'package:wander/blocs/LandMark/LandMarkBloc.dart';
import 'package:wander/core/routes.dart';
import 'package:wander/home.dart';
import 'package:wander/presentation/screens/login.dart';
import 'package:wander/presentation/screens/signup.dart';
import 'package:wander/blocs/auth/auth_bloc.dart';
import 'package:wander/blocs/profile/profile_bloc.dart'; 
import 'core/shared_prefrence.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await SharedPreference.initialize(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(), 
        ),
        BlocProvider(
          create: (context) => FavoriteBloc(),
        ),
        BlocProvider(
          create: (context) => LandmarkBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          Routes.home: (context) => MainScreen(),
          Routes.login: (context) => LoginScreen(),
          Routes.signup: (context) => SignupScreen(),
        },
        initialRoute: Routes.login,
      ),
    );
  }
}