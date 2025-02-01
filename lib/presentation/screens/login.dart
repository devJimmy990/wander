import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/blocs/theme/theme_bloc.dart';
import 'package:wander/blocs/theme/theme_event.dart';
import 'package:wander/blocs/theme/theme_state.dart';
import 'package:wander/core/routes.dart';
import 'package:wander/blocs/auth/auth_bloc.dart';
import 'package:wander/blocs/auth/auth_event.dart';
import 'package:wander/blocs/auth/auth_state.dart';
import 'package:wander/core/validation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool hiddenPassword = true;

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return Scaffold(
          backgroundColor: themeState.themeMode == ThemeMode.light
              ? Colors.white
              : Colors.grey[900],
          body: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthAuthenticated) {
                Navigator.pushReplacementNamed(context, Routes.home);
              } else if (state is AuthError) {
                _showSnackBar(state.message);
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: screenHeight * 0.07),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(
                                  themeState.themeMode == ThemeMode.light
                                      ? Icons.dark_mode
                                      : Icons.light_mode,
                                  color: themeState.themeMode == ThemeMode.light
                                      ? Colors.black
                                      : Colors.white,
                                ),
                                onPressed: () {
                                  context
                                      .read<ThemeBloc>()
                                      .add(ToggleThemeEvent());
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 18.0),
                            child: CircleAvatar(
                              radius: 100,
                              backgroundColor:
                                  themeState.themeMode == ThemeMode.light
                                      ? Colors.white
                                      : Colors.grey[900],
                              child: Padding(
                                padding: const EdgeInsets.all(1),
                                child: ClipOval(
                                  child: Image.asset('assets/images/logo.png'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              "Wander",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Cinzel',
                                color: themeState.themeMode == ThemeMode.light
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextFormField(
                              cursorColor: Color(0xFFbc6c25),
                              controller: emailController,
                              validator: (value) =>
                                  Validation.validateEmail(value),
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFbc6c25),
                                  ),
                                ),
                                labelText: "Email",
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: themeState.themeMode == ThemeMode.light
                                      ? Colors.black
                                      : Colors.white,
                                ),
                                labelStyle: TextStyle(
                                  color: themeState.themeMode == ThemeMode.light
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                              style: TextStyle(
                                color: themeState.themeMode == ThemeMode.light
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextFormField(
                              cursorColor: Color(0xFFbc6c25),
                              controller: passwordController,
                              validator: (value) =>
                                  Validation.validatePassword(value),
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFbc6c25),
                                  ),
                                ),
                                labelText: "Password",
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: themeState.themeMode == ThemeMode.light
                                      ? Colors.black
                                      : Colors.white,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    hiddenPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color:
                                        themeState.themeMode == ThemeMode.light
                                            ? Colors.black
                                            : Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      hiddenPassword = !hiddenPassword;
                                    });
                                  },
                                ),
                                labelStyle: TextStyle(
                                  color: themeState.themeMode == ThemeMode.light
                                      ? Colors.black // Light theme label color
                                      : Colors.white, // Dark theme label color
                                ),
                              ),
                              obscureText: hiddenPassword,
                              style: TextStyle(
                                color: themeState.themeMode == ThemeMode.light
                                    ? Colors.black // Light theme text color
                                    : Colors.white, // Dark theme text color
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: screenWidth * 0.08),
                            child: MaterialButton(
                              height: screenHeight * 0.07,
                              minWidth: screenWidth * 0.6,
                              color: const Color(
                                  0xFFbc6c25), // Button color remains the same
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                        LoginRequested(
                                          emailController.text,
                                          passwordController.text,
                                        ),
                                      );
                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: state is AuthLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.06,
                                        fontFamily: 'Cinzel',
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, Routes.signup);
                            },
                            child: Text(
                              "Don't have an account? Sign up",
                              style: TextStyle(
                                color: themeState.themeMode == ThemeMode.light
                                    ? Colors.blueGrey // Light theme text color
                                    : Colors.white, // Dark theme text color
                              ),
                            ),
                          ),
                          Positioned(
                            child: Image.asset(
                              'assets/images/login.png',
                              fit: BoxFit.cover,
                              width: screenWidth,
                              height: screenHeight * 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
