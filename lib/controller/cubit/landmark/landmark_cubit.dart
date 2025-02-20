import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/controller/cubit/landmark/landmark_state.dart';
import 'package:wander/utils/constants/image_strings.dart';

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
          'image': KImages.egyptianMuseum,
          'description':
              'A museum dedicated to the history of Egypt and its people.',
          'lat': '30.0478',
          'lng': '31.2336',
        },
        {
          'name': 'Salah Al-Din Al-Ayoubi Citadel',
          'image': KImages.salahAlDinCitadel,
          'description': 'It is one of the oldest citadels in the world.',
          'lat': '30.0265',
          'lng': '31.2272',
        },
      ],
      'Alexandria': [
        {
          'name': 'Qaitbay Citadel',
          'image': KImages.qaitbayCitadel,
          'description': 'It is one of the oldest citadels in the world.',
          'lat': '31.2135',
          'lng': '29.8858',
        },
        {
          'name': 'Bibliotheca Alexandrina',
          'image': KImages.bibliothecaAlexandrina ,
          'description':
              'It is one of the most important libraries in the world.',
          'lat': '31.2089',
          'lng': '29.9092',
        },
      ],
      'Luxor': [
        {
          'name': 'Valley of the Kings',
          'image': KImages.valleyOfTheKings,
          'description':
              'It is one of the most important archaeological sites in the world.',
          'lat': '25.7402',
          'lng': '32.6014',
        },
        {
          'name': 'Karnak Temple',
          'image': KImages.karnakTemple,
          'description': 'It is one of the oldest temples in the world.',
          'lat': '25.7186',
          'lng': '32.6573',
        },
      ],
      'Aswan': [
        {
          'name': 'Philae Temple',
          'image': KImages.philaeTemple,
          'description': 'It is one of the oldest temples in the world.',
          'lat': '24.8612',
          'lng': '32.8855',
        },
        {
          'name': 'Ramesses Temple',
          'image': KImages.ramessesTemple,
          'description': 'It has a breathtaking light show.',
          'lat': '22.3372',
          'lng': '31.6258',
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
