import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/blocs/LandMark/LandMarkBloc.dart';
import 'package:wander/blocs/LandMark/LandMarkEvent.dart';
import 'package:wander/blocs/LandMark/LandState.dart';

class LandmarksPage extends StatelessWidget {
  final String governorate;

  LandmarksPage({
    super.key,
    required this.governorate,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LandmarkBloc()..add(FetchLandmarks(governorate)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Landmarks in $governorate',
            style: const TextStyle(fontFamily: 'Cinzel'),
          ),
          backgroundColor: const Color(0xFFf5ebe0),
        ),
        body: BlocBuilder<LandmarkBloc, LandmarkState>(
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