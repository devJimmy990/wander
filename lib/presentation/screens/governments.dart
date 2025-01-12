import 'package:flutter/material.dart';
import 'package:wander/presentation/screens/landmark.dart';

class GovernmentsScreen extends StatelessWidget {
  const GovernmentsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> governorates = [
      {
        'name': 'Cairo',
        'image': 'assets/images/cairo.jpg',
      },
      {
        'name': 'Alexandria',
        'image': 'assets/images/alex.jpg',
      },
      {
        'name': 'Luxor',
        'image': 'assets/images/luxorG.jpg',
      },
      {
        'name': 'Aswan',
        'image': 'assets/images/aswan.jpg',
      }
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: governorates.length,
        itemBuilder: (context, index) {
          final governorate = governorates[index];
          return Card(
            color: const Color(0xFFf5ebe0),
            elevation: 5.0,
            margin: const EdgeInsets.only(bottom: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LandmarksPage(
                      governorate: governorate['name']!,
                    ),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(10.0)),
                    child: Image.asset(
                      governorate['image']!,
                      height: 170.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      governorate['name']!,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
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
