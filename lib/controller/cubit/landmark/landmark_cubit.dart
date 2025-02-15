import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/controller/cubit/landmark/landmark_state.dart';

class LandmarkCubit extends Cubit<LandmarkState> {
  LandmarkCubit() : super(LandmarkInitial());
  void onFetchLandmarks(String governorate) async {
    emit(LandmarkLoading());

    // Simulate fetching data
    await Future.delayed(const Duration(seconds: 1));

    final Map<String, List<Map<String, String>>> landmarks = {
      'Cairo': [
        {
          'name': 'Egyptian Museum',
          'image': 'assets/images/landmark/EM.jpg',
          'description':
              'A museum dedicated to the history of Egypt and its people.',
        },
        {
          'name': 'Salah Al-Din Al-Ayoubi Citadel',
          'image': 'assets/images/landmark/mma.jpeg',
          'description': 'It is one of the oldest citadels in the world.',
        },
      ],
      'Alexandria': [
        {
          'name': 'Qaitbay Citadel',
          'image': 'assets/images/landmark/alexQ.jpg',
          'description': 'It is one of the oldest citadels in the world.',
        },
        {
          'name': 'Bibliotheca Alexandrina',
          'image': 'assets/images/landmark/alexL.jpg',
          'description':
              'It is one of the most important libraries in the world.',
        },
      ],
      'Luxor': [
        {
          'name': 'Valley of the Kings',
          'image': 'assets/images/landmark/ht.jpg',
          'description':
              'It is one of the most important archaeological sites in the world.',
        },
        {
          'name': 'Karnak Temple',
          'image': 'assets/images/landmark/KT.jpg',
          'description': 'It is one of the oldest temples in the world.',
        },
      ],
      'Aswan': [
        {
          'name': 'Philae Temple',
          'image': 'assets/images/landmark/PT.jpg',
          'description': 'It is one of the oldest temples in the world.',
        },
        {
          'name': 'Ramesses Temple',
          'image': 'assets/images/landmark/RT.jpg',
          'description': 'It has a breathtaking light show.',
        },
      ],
    };

    if (landmarks.containsKey(governorate)) {
      emit(LandmarkLoaded(landmarks[governorate]!));
    } else {
      emit(LandmarkError('No landmarks found for $governorate'));
    }
  }
}
