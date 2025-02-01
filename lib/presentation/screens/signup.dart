import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:wander/core/routes.dart';
import 'package:wander/core/shared_prefrence.dart';
import 'package:wander/core/validation.dart';
import 'package:wander/blocs/auth/auth_bloc.dart';
import 'package:wander/blocs/auth/auth_event.dart';
import 'package:wander/blocs/auth/auth_state.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  FocusNode focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool hiddenPassword = true;
  bool hiddenConfirmPassword = true;

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
        listener: (context, state) async {
          if (state is AuthAuthenticated) {
            //to store user data to SharedPreferences
            await SharedPreference.setString(
                key: 'name', value: nameController.text);
            SharedPreference.setString(key: 'userId', value: state.userId);
            SharedPreference.setString(
                key: 'email', value: emailController.text);
            SharedPreference.setString(key: 'name', value: nameController.text);
            SharedPreference.setString(
                key: 'phone', value: phoneController.text);

            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Success'),
                content: const Text('Account Created Successfully'),
                actions: [
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, Routes.login);
                    },
                  ),
                ],
              ),
            );
          } else if (state is AuthError) {
            _showSnackBar(state.message);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.05),
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
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: screenWidth * 0.08,
                      fontFamily: 'Cinzel',
                    ),
                  ),
                  Row(
                    children: [
                      _buildNameField('Full Name', nameController),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: emailController,
                      validator: Validation
                          .validateEmail,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: IntlPhoneField(
                      controller: phoneController,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        labelText: 'Phone Number (optional)',
                      ),
                      languageCode: "en",
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: passwordController,
                      validator: Validation
                          .validatePassword, 
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
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: confirmPasswordController,
                      validator: (value) => Validation.validateConfirmPassword(
                        value,
                        passwordController.text,
                      ), 
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(hiddenConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              hiddenConfirmPassword = !hiddenConfirmPassword;
                            });
                          },
                        ),
                      ),
                      obscureText: hiddenConfirmPassword,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenWidth * 0.05),
                    child: MaterialButton(
                      height: screenHeight * 0.07,
                      minWidth: screenWidth * 0.6,
                      color: const Color(0xFFbc6c25),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Attempt to create a user with Firebase


                          context.read<AuthBloc>().add(
                                SignUpRequested(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                ),
                              );
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: state is AuthLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Sign Up',
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
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, Routes.login),
                    child: Text(
                      "Already have an account? Log In",
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                  ),
                  Positioned(
                    child: Image.asset(
                      'assets/images/get-started.jpg',
                      fit: BoxFit.cover,
                      width: screenWidth,
                      height: screenHeight * 0.2,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNameField(String label, TextEditingController controller) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          controller: controller,
          validator: Validation
              .validateFullName, 
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: const Icon(Icons.person),
          ),
        ),
      ),
    );
  }
}
