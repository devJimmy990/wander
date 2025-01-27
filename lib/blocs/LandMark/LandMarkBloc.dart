import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/blocs/LandMark/LandMarkEvent.dart';
import 'package:wander/blocs/LandMark/LandState.dart';

class LandmarkBloc extends Bloc<LandmarkEvent, LandmarkState> {
  LandmarkBloc() : super(LandmarkInitial()) {
    on<FetchLandmarks>(_onFetchLandmarks);
  }

  void _onFetchLandmarks(FetchLandmarks event, Emitter<LandmarkState> emit) async {
    emit(LandmarkLoading());

    // Simulate fetching data
    await Future.delayed(const Duration(seconds: 1));

    final Map<String, List<Map<String, String>>> landmarks = {
      'Cairo': [
        {
          'name': 'Egyptian Museum',
          'image': 'assets/images/EM.jpg',
          'description': 'A museum dedicated to the history of Egypt and its people.',
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
          'description': 'It is one of the most important libraries in the world.',
        },
      ],
      'Luxor': [
        {
          'name': 'Valley of the Kings',
          'image': 'assets/images/ht.jpg',
          'description': 'It is one of the most important archaeological sites in the world.',
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

    if (landmarks.containsKey(event.governorate)) {
      emit(LandmarkLoaded(landmarks[event.governorate]!));
    } else {
      emit(LandmarkError('No landmarks found for ${event.governorate}'));
    }
  }
}