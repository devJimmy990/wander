abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final Map<String, dynamic> updatedData;

  UpdateProfile(this.updatedData);
}

class UpdateAvatar extends ProfileEvent {
  final String imageUrl;

  UpdateAvatar(this.imageUrl);
}