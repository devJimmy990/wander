import 'package:flutter/material.dart';
import 'package:wander/presentation/features/governorates/landmark.dart';
import 'package:wander/utils/constants/image_strings.dart';

class GovernmentsScreen extends StatelessWidget {
  const GovernmentsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final List<Map<String, String>>  governorates= [
      {
        'name': 'Cairo',
        'image': KImages.cairoImage,
      },
      {
        'name': 'Alexandria',
        'image': KImages.alexImage,
      },
      {
        'name': 'Luxor',
        'image': KImages.luxorImage,
      },
      {
        'name': 'Aswan',
        'image': KImages.aswanImage,
      }
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: governorates.length,
        itemBuilder: (context, index) {
          final governorate = governorates[index];
          return InkWell(
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      governorate['image']!,
                      height: screenHeight * 0.18,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                  Container(
                    height: screenHeight * 0.18,
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(20),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      governorate['name']!,
                      style: const TextStyle(
                        fontSize: 34.0,
                        fontFamily: 'Cinzel',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}