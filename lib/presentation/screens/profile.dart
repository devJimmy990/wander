import 'package:flutter/material.dart';
import 'package:wander/core/routes.dart';
import 'package:wander/data/model/user.dart';
import 'package:wander/core/user_credential.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  //function to display asterisks instead of the actual password for security
  String _hashPassword(String password) {
    return '*' * password.length;
  }

  @override
  Widget build(BuildContext context) {
    //get stored user credentials from SignupScreen
    User user = UserCredential.getInstance().user;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: screenHeight * 0.7,
          width: screenWidth * 0.9,
          decoration: BoxDecoration(
            color: Color(0xFFf5ebe0),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Profile Details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cinzel',
                  ),
                ),
              ),
              Divider(
                indent: 10,
                endIndent: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'First Name:  ${user.firstName}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Last Name:   ${user.secondName}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Email:  ${user.email}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Phone Number:   ${user.phone}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Password:   ${_hashPassword(user.password!)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: MaterialButton(
                  height: screenHeight * 0.07,
                  minWidth: screenWidth * 0.36,
                  color: const Color(0xFFbc6c25),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.login);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.05,
                      fontFamily: 'Cinzel',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
