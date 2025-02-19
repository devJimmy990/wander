import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/controller/cubit/landmark/landmark_cubit.dart';
import 'package:wander/controller/cubit/landmark/landmark_state.dart';
import 'package:wander/presentation/features/maps/map_view.dart';

class LandmarksPage extends StatelessWidget {
  final String governorate;

  const LandmarksPage({
    super.key,
    required this.governorate,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LandmarkCubit()..onFetchLandmarks(governorate),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Landmarks in $governorate',
            style: const TextStyle(fontFamily: 'Cinzel'),
          ),
          backgroundColor: const Color(0xFFf5ebe0),
        ),
        body: BlocBuilder<LandmarkCubit, LandmarkState>(
          builder: (context, state) {
            if (state is LandmarkLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LandmarkError) {
              return Center(child: Text(state.message));
            } else if (state is LandmarkLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(20.0),
                itemCount: state.landmarks.length,
                itemBuilder: (context, index) {
                  final landmark = state.landmarks[index];
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
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10.0)),
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
                        TextButton(
                            onPressed: () {
                              final double lat =
                                  double.tryParse(landmark['lat']!) ?? 0;
                              final double lng =
                                  double.tryParse(landmark['lng']!) ?? 0;
                              String name = landmark['name']!;

                              if (lat != 0 && lng != 0) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapScreen(
                                        latitude: lat, longitude: lng, name: name,),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Location data not available")),
                                );
                              }
                            },
                            child: Text("See location"))
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}
