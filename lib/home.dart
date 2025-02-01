import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wander/blocs/profile/profile_state.dart';
import 'package:wander/blocs/theme/theme_bloc.dart';
import 'package:wander/blocs/theme/theme_event.dart';
import 'package:wander/core/shared_prefrence.dart';
import 'package:wander/presentation/screens/governments.dart';
import 'package:wander/presentation/screens/home/page.dart';
import 'package:wander/presentation/screens/favorite.dart';
import 'package:wander/presentation/screens/profile.dart';
import 'package:wander/blocs/profile/profile_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'blocs/theme/theme_state.dart';

const List<Widget> pages = [
  HomeScreen(),
  GovernmentsScreen(),
  FavoriteScreen(),
  ProfileScreen(),
];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  final List<Map<String, dynamic>> bottomNav = [
    {"label": "Home", "icon": Icons.home},
    {"label": "Places", "icon": Icons.place},
    {"label": "Favorite", "icon": Icons.favorite},
    {"label": "Profile", "icon": Icons.person}
  ];

  String? userName;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _fetchUserNameFromFirestore();
  }

  void _loadUserName() async {
    final name = SharedPreference.getString(key: 'name');
    setState(() {
      userName = name;
    });
  }

  void _fetchUserNameFromFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        final name = userDoc.data()?['name'];
        if (name != null) {
          setState(() {
            userName = name;
          });
          SharedPreference.setString(key: 'name', value: name);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return Scaffold(
            backgroundColor: themeState.themeMode == ThemeMode.light
                ? Colors.white
                : Colors.grey[900],
            appBar: AppBar(
              backgroundColor: Color(0xFFf5ebe0),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(
                        fontFamily: 'Cinzel',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (userName != null) ...[
                      SizedBox(width: 5),
                      Text(
                        userName!,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFbc6c25),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    themeState.themeMode == ThemeMode.light
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    context.read<ThemeBloc>().add(ToggleThemeEvent());
                  },
                ),
              ],
            ),
            body: SafeArea(
              child: BlocListener<ProfileBloc, ProfileState>(
                listener: (context, state) {
                  if (state is ProfileUpdated) {
                    setState(() {
                      userName = state.updatedProfile['name'];
                    });
                    SharedPreference.setString(
                        key: 'name', value: state.updatedProfile['name']);
                  }
                },
                child: pages[index],
              ),
            ),
            bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: Colors.transparent,
              color: Color(0xFFf5ebe0),
              buttonBackgroundColor: Color(0xFFbc6c25),
              height: 60,
              animationDuration: Duration(milliseconds: 300),
              index: index,
              items: bottomNav.map((nav) {
                return Icon(
                  nav["icon"],
                  color: index == bottomNav.indexOf(nav)
                      ? Colors.white
                      : Colors.black,
                );
              }).toList(),
              onTap: (idx) => setState(() => index = idx),
            ),
          );
        },
      ),
    );
  }
}
