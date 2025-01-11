import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:wander/core/routes.dart';
import 'package:wander/core/user_credential.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
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

  void _validateAndShowDialog() {
    if (_formKey.currentState!.validate()) {
      //to store user credentials in the static map
      UserCredential.getInstance().create(
        email: emailController.text,
        password: passwordController.text,
        firstName: firstNameController.text,
        secondName: secondNameController.text,
        phone: phoneController.text,
      );

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
    } else {
      _showSnackBar('Please correct the errors in the form');
    }
  }

  Widget _buildNameField(String label, TextEditingController controller) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Field cannot be empty';
            }
            if (value[0] != value[0].toUpperCase()) {
              return 'First letter must be capitalized';
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: const Icon(Icons.person),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.08),
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
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: screenWidth * 0.08,
                  fontFamily: 'Cinzel',
                ),
              ),
              Row(
                children: [
                  _buildNameField('First Name', firstNameController),
                  _buildNameField('Last Name', secondNameController),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
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
                  onPressed: _validateAndShowDialog,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
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
      ),
    );
  }
}
