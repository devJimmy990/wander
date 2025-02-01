import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:wander/blocs/theme/theme_bloc.dart';
import 'package:wander/blocs/theme/theme_event.dart';
import 'package:wander/blocs/theme/theme_state.dart';
import 'package:wander/core/routes.dart';
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

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return Scaffold(
          backgroundColor: themeState.themeMode == ThemeMode.light
              ? Colors.white
              : Colors.grey[900],
          body: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthAuthenticated) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: themeState.themeMode == ThemeMode.light
                        ? Color(0xFFf5ebe0)
                        : Colors.grey[800],
                    title: Text(
                      'Success',
                      style: TextStyle(
                        color: themeState.themeMode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                    content: Text(
                      'Account Created Successfully',
                      style: TextStyle(
                        color: themeState.themeMode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
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
                              context.read<ThemeBloc>().add(ToggleThemeEvent());
                            },
                          ),
                        ],
                      ),
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
                      Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: screenWidth * 0.08,
                          fontFamily: 'Cinzel',
                          color: themeState.themeMode == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          _buildNameField(
                              'Full Name', nameController, themeState),
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
                        padding: const EdgeInsets.all(10.0),
                        child: IntlPhoneField(
                          dropdownTextStyle: TextStyle(
                            color: themeState.themeMode == ThemeMode.light
                                ? Colors.black
                                : Colors.white,
                          ),
                          style: TextStyle(
                            color: themeState.themeMode == ThemeMode.light
                                ? Colors.black
                                : Colors.white,
                          ),
                          cursorColor: Color(0xFFbc6c25),
                          pickerDialogStyle: PickerDialogStyle(
                            backgroundColor:
                                themeState.themeMode == ThemeMode.light
                                    ? Colors.white
                                    : Colors.grey[500],
                          ),
                          dropdownIcon: Icon(
                            Icons.arrow_drop_down,
                            color: themeState.themeMode == ThemeMode.light
                                ? Colors.black
                                : Colors.white,
                          ),
                          controller: phoneController,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFbc6c25),
                              ),
                            ),
                            helperStyle: TextStyle(
                              color: themeState.themeMode == ThemeMode.light
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            labelText: 'Phone Number (optional)',
                            labelStyle: TextStyle(
                              color: themeState.themeMode == ThemeMode.light
                                  ? Colors.black
                                  : Colors.white,
                            ),
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
                              color: themeState.themeMode == ThemeMode.light
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                hiddenPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: themeState.themeMode == ThemeMode.light
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
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                          obscureText: hiddenPassword,
                          style: TextStyle(
                            color: themeState.themeMode == ThemeMode.light
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          cursorColor: Color(0xFFbc6c25),
                          controller: confirmPasswordController,
                          validator: (value) =>
                              Validation.validateConfirmPassword(
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
                              color: themeState.themeMode == ThemeMode.light
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                hiddenConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: themeState.themeMode == ThemeMode.light
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  hiddenConfirmPassword =
                                      !hiddenConfirmPassword;
                                });
                              },
                            ),
                            labelStyle: TextStyle(
                              color: themeState.themeMode == ThemeMode.light
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                          obscureText: hiddenConfirmPassword,
                          style: TextStyle(
                            color: themeState.themeMode == ThemeMode.light
                                ? Colors.black
                                : Colors.white,
                          ),
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
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
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
                        onPressed: () => Navigator.pushReplacementNamed(
                            context, Routes.login),
                        child: Text(
                          "Already have an account? Log In",
                          style: TextStyle(
                            color: themeState.themeMode == ThemeMode.light
                                ? Colors.blueGrey
                                : Colors.white,
                          ),
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
      },
    );
  }

  Widget _buildNameField(
      String label, TextEditingController controller, ThemeState themeState) {
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
    );
  }
}
