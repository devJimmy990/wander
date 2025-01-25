import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    return Scaffold(
      backgroundColor: Colors.white,
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
                      SizedBox(height: screenHeight * 0.1),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: CircleAvatar(
                          radius: 100,
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(1),
                            child: ClipOval(
                              child: Image.asset('assets/images/logo.png'),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          controller: emailController,
                          validator: (value) => Validation.validateEmail(value),
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          controller: passwordController,
                          validator: (value) =>
                              Validation.validatePassword(value),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(hiddenPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  hiddenPassword = !hiddenPassword;
                                });
                              },
                            ),
                          ),
                          obscureText: hiddenPassword,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenWidth * 0.08),
                        child: MaterialButton(
                          height: screenHeight * 0.07,
                          minWidth: screenWidth * 0.6,
                          color: const Color(0xFFbc6c25),
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
                                  'Log In',
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
                          "Don't have an account? Create new account",
                          style: TextStyle(color: Colors.blueGrey),
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
  }
}
