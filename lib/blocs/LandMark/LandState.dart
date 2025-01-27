import 'package:equatable/equatable.dart';

abstract class LandmarkState extends Equatable {
  const LandmarkState();

  @override
  List<Object> get props => [];
}

class LandmarkInitial extends LandmarkState {}

class LandmarkLoading extends LandmarkState {}

class LandmarkLoaded extends LandmarkState {
  final List<Map<String, String>> landmarks;

  const LandmarkLoaded(this.landmarks);

  @override
  List<Object> get props => [landmarks];
}

class LandmarkError extends LandmarkState {
  final String message;

  const LandmarkError(this.message);

  @override
  List<Object> get props => [message];
}