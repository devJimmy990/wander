abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Map<String, dynamic> profile;

  ProfileLoaded(this.profile);
}

class ProfileUpdated extends ProfileState {
  final Map<String, dynamic> updatedProfile;

  ProfileUpdated(this.updatedProfile);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}
// for image picker
class AvatarSelected extends ProfileState {
  final String avatarPath;
  AvatarSelected(this.avatarPath);
}