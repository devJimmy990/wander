sealed class LandmarkState {}

class LandmarkInitial extends LandmarkState {}

class LandmarkLoading extends LandmarkState {}

class LandmarkLoaded extends LandmarkState {
  final List<Map<String, String>> landmarks;
  LandmarkLoaded(this.landmarks);
}

class LandmarkError extends LandmarkState {
  final String message;
  LandmarkError(this.message);
}
