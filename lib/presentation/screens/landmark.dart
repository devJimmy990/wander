import 'package:flutter/material.dart';

class LandmarksPage extends StatelessWidget {
  final String governorate;

  LandmarksPage({
    super.key,
    required this.governorate,
  });

  final Map<String, List<Map<String, String>>> landmarks = {
    'Cairo': [
      {
        'name': 'Egyptian Museum',
        'image': 'assets/images/EM.jpg',
        'description':
            'A museum dedicated to the history of Egypt and its people.',
      },
      {
        'name': 'Salah Al-Din Al-Ayoubi Citadel',
        'image': 'assets/images/mma.jpeg',
        'description': 'It is one of the oldest citadels in the world.',
      },
    ],
    'Alexandria': [
      {
        'name': 'Qaitbay Citadel',
        'image': 'assets/images/alexQ.jpg',
        'description': 'It is one of the oldest citadels in the world.',
      },
      {
        'name': 'Bibliotheca Alexandrina',
        'image': 'assets/images/alexL.jpg',
        'description':
            'It is one of the most important libraries in the world.',
      },
    ],
    'Luxor': [
      {
        'name': 'Valley of the Kings',
        'image': 'assets/images/ht.jpg',
        'description':
            'It is one of the most important archaeological sites in the world.',
      },
      {
        'name': 'Karnak Temple',
        'image': 'assets/images/KT.jpg',
        'description': 'It is one of the oldest temples in the world.',
      },
    ],
    'Aswan': [
      {
        'name': 'Philae Temple',
        'image': 'assets/images/PT.jpg',
        'description': 'It is one of the oldest temples in the world.',
      },
      {
        'name': 'Ramesses Temple',
        'image': 'assets/images/RT.jpg',
        'description': 'It has a breathtaking light show.',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Landmarks in $governorate',
          style: const TextStyle(fontFamily: 'Cinzel'),
        ),
        backgroundColor: const Color(0xFFf5ebe0),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20.0),
        itemCount: landmarks[governorate]!.length,
        itemBuilder: (context, index) {
          final landmark = landmarks[governorate]![index];
          return Card(
            color: const Color(0xFFf5ebe0),
            elevation: 5.0,
            margin: const EdgeInsets.only(bottom: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10.0)),
                  child: Image.asset(
                    landmark['image']!,
                    height: 170.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    landmark['name']!,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    landmark['description']!,
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
