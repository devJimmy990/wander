import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:wander/blocs/profile/profile_state.dart';
import 'package:wander/blocs/theme_cubit/theme_cubit.dart';
import 'package:wander/core/shared_prefrence.dart';
import 'package:wander/presentation/screens/governments.dart';
import 'package:wander/presentation/screens/home/page.dart';
import 'package:wander/presentation/screens/favorite.dart';
import 'package:wander/presentation/screens/profile.dart';
import 'package:wander/blocs/profile/profile_bloc.dart';

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
    _loadUserName(); //to fetch the user's name from SharedPreferences
  }

  void _loadUserName() async {
    final name = SharedPreference.getString(key: 'name');
    setState(() {
      userName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return Scaffold(
          backgroundColor: themeState.themeData.scaffoldBackgroundColor,
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
            /// icon to change dark and light mode
            actions: [
              IconButton(
                  onPressed: () => context.read<ThemeCubit>().changeTheme(),
                  icon: Icon(
                    themeState is DarkTheme
                        ? Icons.light_mode
                        : Icons.dark_mode,
                    color: themeState.themeData.iconTheme.color,
                  ))
            ],
          ),
          body: SafeArea(
            child: BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ProfileUpdated) {
                  setState(() {
                    userName = state.updatedProfile['name'];
                  });
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
    );
  }
}
