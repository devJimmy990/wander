import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/controller/cubit/landmark/landmark_cubit.dart';
import 'package:wander/presentation/features/governorates/landmark.dart';

void main() {
  testWidgets('LandmarksPage UI renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<LandmarkCubit>(
          create: (context) => LandmarkCubit()..onFetchLandmarks("Cairo"),
          child: const LandmarksPage(governorate: "Cairo"),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text("Landmarks in Cairo"), findsOneWidget);
  });
}
