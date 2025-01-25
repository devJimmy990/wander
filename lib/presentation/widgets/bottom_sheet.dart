import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/blocs/profile/profile_bloc.dart';
import 'package:wander/blocs/profile/profile_event.dart';

class EditUserInfoBottomSheet extends StatefulWidget {
  final Map<String, dynamic> currentProfile;

  const EditUserInfoBottomSheet({super.key, required this.currentProfile});

  @override
  State<EditUserInfoBottomSheet> createState() =>
      _EditUserInfoBottomSheetState();
}

class _EditUserInfoBottomSheetState extends State<EditUserInfoBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.currentProfile['name'] ?? '';
    _emailController.text = widget.currentProfile['email'] ?? '';
    _phoneController.text = widget.currentProfile['phone'] ?? '';
    _passwordController.text = widget.currentProfile['password'] ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 252, 243, 234),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Edit Profile',
              style: TextStyle(
                fontFamily: 'Cinzel',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(250, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Color(0xFFbc6c25),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<ProfileBloc>().add(
                        UpdateProfile({
                          'name': _nameController.text,
                          'email': _emailController.text,
                          'phone': _phoneController.text,
                          'password': _passwordController.text,
                        }),
                      );
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Save Changes',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Cinzel',
                  fontSize: 23,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
