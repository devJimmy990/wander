import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:wander/core/routes.dart';
import 'package:wander/core/validation.dart';
import 'package:wander/controller/cubit/auth/index.dart';
import 'package:wander/data/model/user.dart';
import 'package:wander/utils/constants/image_strings.dart';

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
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AccountCreated) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  'Success',
                  style: TextStyle(),
                ),
                content: Text(
                  'Account Created Successfully',
                  style: TextStyle(),
                ),
                actions: [
                  TextButton(
                    child: Text(
                      'OK',
                      style: TextStyle(
                        color: Color(0xFFbc6c25),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, Routes.login);
                    },
                  ),
                ],
              ),
            );
          } else if (state is AuthenticationError) {
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
                  SizedBox(height: screenHeight * 0.07),
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
                      cursorColor: Color(0xFFbc6c25),
                      controller: emailController,
                      validator: Validation.validateEmail,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFbc6c25),
                          ),
                        ),
                        labelText: 'Email',
                        prefixIcon: Icon(
                          Icons.email,
                        ),
                        labelStyle: TextStyle(),
                      ),
                      style: TextStyle(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: IntlPhoneField(
                      dropdownTextStyle: TextStyle(),
                      style: TextStyle(),
                      cursorColor: Color(0xFFbc6c25),
                      pickerDialogStyle: PickerDialogStyle(),
                      dropdownIcon: Icon(
                        Icons.arrow_drop_down,
                      ),
                      controller: phoneController,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFbc6c25),
                          ),
                        ),
                        helperStyle: TextStyle(),
                        labelText: 'Phone Number (optional)',
                        labelStyle: TextStyle(),
                      ),
                      languageCode: "en",
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      cursorColor: Color(0xFFbc6c25),
                      controller: passwordController,
                      validator: Validation.validatePassword,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFbc6c25),
                          ),
                        ),
                        labelText: 'Password',
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
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      cursorColor: Color(0xFFbc6c25),
                      controller: confirmPasswordController,
                      validator: (value) => Validation.validateConfirmPassword(
                        value,
                        passwordController.text,
                      ),
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFbc6c25),
                          ),
                        ),
                        labelText: 'Confirm Password',
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            hiddenConfirmPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              hiddenConfirmPassword = !hiddenConfirmPassword;
                            });
                          },
                        ),
                        labelStyle: TextStyle(),
                      ),
                      obscureText: hiddenConfirmPassword,
                      style: TextStyle(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenWidth * 0.05),
                    child: MaterialButton(
                      height: screenHeight * 0.07,
                      minWidth: screenWidth * 0.6,
                      color: const Color(0xFFbc6c25),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context
                              .read<AuthenticationCubit>()
                              .onSignUpRequested(User(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                              ));
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: state is AuthenticationLoading
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
                      style: TextStyle(),
                    ),
                  ),
                  Positioned(
                    child: Image.asset(
                      KImages.footerSignupImage,
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
}

Widget _buildNameField(String label, TextEditingController controller) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        cursorColor: Color(0xFFbc6c25),
        controller: controller,
        validator: Validation.validateFullName,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFbc6c25),
            ),
          ),
          labelText: label,
          prefixIcon: Icon(
            Icons.person,
          ),
          labelStyle: TextStyle(),
        ),
        style: TextStyle(),
      ),
    ),
  );
}
