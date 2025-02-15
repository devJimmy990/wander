import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:wander/controller/cubit/index.dart';
import 'package:wander/controller/provider/screen_index.dart';

// Import Screens
import 'package:wander/presentation/features/home/page.dart';
import 'package:wander/presentation/features/account/page.dart';
import 'package:wander/presentation/features/favorite/page.dart';
import 'package:wander/presentation/features/governorates/page.dart';

const List<Widget> pages = [
  HomeScreen(),
  GovernmentsScreen(),
  FavoriteScreen(),
  AccountScreen(),
];

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserCubit>().loadUser();
    return ChangeNotifierProvider(
      create: (_) => ScreenIndexController(),
      child: Consumer<ScreenIndexController>(
        builder: (context, controller, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(child: pages[controller.value]),
            bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: Colors.transparent,
              color: Color(0xFFf5ebe0),
              buttonBackgroundColor: Color(0xFFbc6c25),
              height: 60,
              animationDuration: Duration(milliseconds: 300),
              index: controller.value,
              items: [Icons.home, Icons.place, Icons.favorite, Icons.person]
                  .map((nav) {
                return Icon(
                  nav,
                  color: controller.value ==
                          [
                            Icons.home,
                            Icons.place,
                            Icons.favorite,
                            Icons.person
                          ].indexOf(nav)
                      ? Colors.white
                      : Colors.black,
                );
              }).toList(),
              onTap: (idx) => controller.value = idx,
            ),
          );
        },
      ),
    );
  }
}
