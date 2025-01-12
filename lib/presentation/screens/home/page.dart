import 'package:flutter/material.dart';
import 'package:wander/data/dummy.dart';
import 'package:wander/presentation/screens/home/suggested_places.dart';
import 'package:wander/presentation/screens/home/popular_places.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  final List<String> popularPlaces = [
    "River Nile",
    "Abo Sample",
    "Cairo Tower",
    "Luxor Temples",
    "The Red Sea",
    "Old Cairo",
    "Alexandria",
    "Mohamed Ali Mosque"
  ];

  final List<Map<String, dynamic>> pages = [
    {"label": "Home", "icon": Icons.home},
    {"label": "Places", "icon": Icons.place},
    {"label": "Favorite", "icon": Icons.favorite},
    {"label": "Profile", "icon": Icons.person}
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Popular Places",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cinzel'),
              ),
            ),
            PopularPlaces(places: popularPlaces),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Suggested Places",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cinzel'),
              ),
            ),
            const SizedBox(height: 15),
            SuggestedPlaces(places: items),
          ],
        ),
      ),
    );
  }
}

class LandmarkCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String governorate;

  const LandmarkCard({
    required this.imageUrl,
    required this.title,
    required this.governorate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        governorate,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
