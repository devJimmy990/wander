import 'package:flutter_test/flutter_test.dart';
import 'package:wander/controller/cubit/landmark/landmark_cubit.dart';
import 'package:wander/controller/cubit/landmark/landmark_state.dart';

void main() {
  group('LandmarkCubit Tests', () {
    late LandmarkCubit landmarkCubit;

    setUp(() {
      landmarkCubit = LandmarkCubit();
    });

    test('Initial state should be LandmarkInitial', () {
      expect(landmarkCubit.state, isA<LandmarkInitial>());
    });

    test('Fetching landmarks should emit LandmarkLoading and LandmarkLoaded', () async {
      landmarkCubit.onFetchLandmarks('Cairo');
      expect(landmarkCubit.state, isA<LandmarkLoading>());

      // Wait for async operation
      await Future.delayed(Duration(seconds: 1));

      expect(landmarkCubit.state, isA<LandmarkLoaded>());
    });

    test('Fetching unknown governorate should emit LandmarkError', () async {
      landmarkCubit.onFetchLandmarks('Unknown City');

      // Wait for async operation
      await Future.delayed(Duration(seconds: 1));

      expect(landmarkCubit.state, isA<LandmarkError>());
    });
  });
}
