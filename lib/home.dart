import 'package:flutter/material.dart';
import 'package:wander/core/user_credential.dart';
import 'package:wander/presentation/screens/favorite.dart';
import 'package:wander/presentation/screens/governments.dart';
import 'package:wander/presentation/screens/home/page.dart';
import 'package:wander/presentation/screens/profile.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFf5ebe0),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Welcome ${UserCredential.getInstance().user.firstName}",
            style: TextStyle(fontFamily: 'Cinzel', fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SafeArea(child: pages[index]),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        backgroundColor: Color(0xFFf5ebe0),
        currentIndex: index,
        selectedItemColor: Color(0xFFbc6c25),
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: TextStyle(
          color: Colors.black,
        ),
        items: bottomNav.map((nav) {
          return BottomNavigationBarItem(
            backgroundColor: Color(0xFFf5ebe0),
            activeIcon: Icon(nav["icon"], color: Color(0xFFbc6c25)),
            icon: Icon(
              nav["icon"],
              color: Colors.black,
            ),
            label: nav["label"],
          );
        }).toList(),
        onTap: (idx) => setState(() => index = idx),
      ),
    );
  }
}
