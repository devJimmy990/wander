import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wander/core/routes.dart';
import 'package:wander/controller/cubit/auth/auth_cubit.dart';
import 'package:wander/controller/cubit/user/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/presentation/widgets/image_sheet.dart';
import 'package:wander/presentation/widgets/bottom_sheet.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, Routes.settings),
          ),
          if (context.read<UserCubit>().user != null)
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                BlocProvider.of<AuthenticationCubit>(context)
                    .onLogoutRequested();
                Navigator.pushReplacementNamed(context, Routes.login);
              },
            )
        ],
      ),
      body: context.read<UserCubit>().user == null
          ? Column(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Please login first', textAlign: TextAlign.center),
                FractionallySizedBox(
                  widthFactor: .3,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, Routes.login),
                    child: Text('Login'),
                  ),
                )
              ],
            )
          : BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is UserLoaded) {
                  final user = state.user;
                  return Center(
                    child: Container(
                      height: screenHeight * 0.6,
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
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundColor:
                                        Color.fromARGB(255, 203, 166, 133),
                                    child: Padding(
                                      padding: const EdgeInsets.all(1),
                                      child: ClipOval(
                                        child: user.avatar != null
                                            ? _buildProfileImage(user.avatar!)
                                            : Icon(
                                                Icons.person,
                                                size: 60,
                                                color: Colors.white,
                                              ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) =>
                                            AvatarBottomSheet(),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFbc6c25),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
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
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildProfileDetails(
                                label: "Full Name",
                                value: user.name ?? 'Not provided',
                              ),
                              _buildProfileDetails(
                                label: "Email",
                                value: user.email ?? 'Not provided',
                              ),
                              _buildProfileDetails(
                                label: "Phone Number",
                                value: user.phone ?? 'Not provided',
                              ),
                            ],
                          ),
                          Spacer(),
                          Center(
                            child: MaterialButton(
                              height: screenHeight * 0.07,
                              minWidth: screenWidth * 0.36,
                              color: const Color(0xFFbc6c25),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return BlocProvider.value(
                                      value:
                                          BlocProvider.of<UserCubit>(context),
                                      child: EditUserInfoBottomSheet(
                                        user: user,
                                      ),
                                    );
                                  },
                                );
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Edit Profile',
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
                  );
                } else if (state is UserError) {
                  return Center(child: Text(state.errorMessage));
                } else {
                  return Center(child: Text('Something went wrong!'));
                }
              },
            ),
    );
  }
}

Widget _buildProfileDetails({required String label, required String value}) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '$label: $value',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

/// todo refine

Widget _buildProfileImage(String avatarPath) {
  if (avatarPath.startsWith('assets/')) {
    // Load predefined avatar from assets
    return Image.asset(avatarPath, fit: BoxFit.cover);
  } else {
    // Load user-uploaded image from device storage
    return Image.file(File(avatarPath), fit: BoxFit.cover);
  }
}
