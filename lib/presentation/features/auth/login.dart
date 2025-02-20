import 'package:flutter/material.dart';
import 'package:wander/core/routes.dart';
import 'package:wander/core/validation.dart';
import 'package:wander/controller/cubit/auth/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/controller/cubit/user/user_cubit.dart';
import 'package:wander/utils/constants/image_strings.dart';

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
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.read<UserCubit>().setUser(state.user);
            Navigator.pushReplacementNamed(context, Routes.landing);
          } else if (state is AuthenticationError) {
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
                      SizedBox(height: screenHeight * 0.02),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: CircleAvatar(
                          radius: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(1),
                            child: ClipOval(
                              child: Image.asset(KImages.logoApp),
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
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          cursorColor: Color(0xFFbc6c25),
                          controller: emailController,
                          validator: (value) => Validation.validateEmail(value),
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFbc6c25),
                              ),
                            ),
                            labelText: "Email",
                            prefixIcon: Icon(
                              Icons.email,
                            ),
                            labelStyle: TextStyle(),
                          ),
                          style: TextStyle(),
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
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                hiddenPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  hiddenPassword = !hiddenPassword;
                                });
                              },
                            ),
                            labelStyle: TextStyle(),
                          ),
                          obscureText: hiddenPassword,
                          style: TextStyle(),
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
                              context
                                  .read<AuthenticationCubit>()
                                  .onLoginRequested(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: state is AuthenticationLoading
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
                          style: TextStyle(),
                        ),
                      ),
                      Positioned(
                        child: Image.asset(
                          KImages.footerLoginImage,
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
