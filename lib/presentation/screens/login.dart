import 'package:flutter/material.dart';
import 'package:wander/core/routes.dart';
import 'package:wander/core/user_credential.dart';

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

  //to validate entered credentials
  void _validateAndLogin() {
    if (_formKey.currentState!.validate()) {
      //to retrieve stored credentials from SignUpPage
      final storedEmail = UserCredential.getInstance().user.email;
      final storedPassword = UserCredential.getInstance().user.password;

      //to compare entered credentials with stored credentials
      if (emailController.text == storedEmail &&
          passwordController.text == storedPassword) {
        _showSnackBar('Logged in successfully');
        Navigator.pushReplacementNamed(context, Routes.home);
      } else {
        _showSnackBar('Invalid email or password');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
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
                      radius: 60,
                      backgroundColor: Color.fromARGB(255, 203, 166, 133),
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: ClipOval(
                          child: Image.asset('assets/images/signup.jpg'),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email cannot be empty';
                        }
                        if (!value.contains('@') || !value.endsWith('.com')) {
                          return 'Email must contain @ and end with .com';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password cannot be empty';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
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
                      onPressed: _validateAndLogin,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
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
                      Navigator.pushReplacementNamed(context, Routes.signup);
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
      ),
    );
  }
}
