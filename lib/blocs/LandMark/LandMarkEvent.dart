import 'package:equatable/equatable.dart';

abstract class LandmarkEvent extends Equatable {
  const LandmarkEvent();

  @override
  List<Object> get props => [];
}

class FetchLandmarks extends LandmarkEvent {
  final String governorate;

  const FetchLandmarks(this.governorate);

  @override
  List<Object> get props => [governorate];
}