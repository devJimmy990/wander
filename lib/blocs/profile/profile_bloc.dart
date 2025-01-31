import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/core/shared_prefrence.dart';
import 'profile_event.dart'; 
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
    on<UpdateAvatar>(_onUpdateAvatar);
  }

  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      //to fetch profile data from SharedPreferences
      final profile = {
        'name': SharedPreference.getString(key: 'name'),
        'email': SharedPreference.getString(key: 'email'),
        'phone': SharedPreference.getString(key: 'phone'),
        'password': SharedPreference.getString(key: 'password'),
        'avatarUrl': SharedPreference.getString(key: 'avatarUrl'),
      };
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError('Failed to load profile: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateProfile(
  UpdateProfile event,
  Emitter<ProfileState> emit,
) async {
  emit(ProfileLoading());
  try {
    await SharedPreference.setString(key: 'name', value: event.updatedData['name']);
    await SharedPreference.setString(key: 'email', value: event.updatedData['email']);
    await SharedPreference.setString(key: 'phone', value: event.updatedData['phone']);
    await SharedPreference.setString(key: 'password', value: event.updatedData['password']);

    final updatedProfile = {
      'name': event.updatedData['name'],
      'email': event.updatedData['email'],
      'phone': event.updatedData['phone'],
      'password': event.updatedData['password'],
      'avatarUrl': SharedPreference.getString(key: 'avatarUrl'),
    };
    emit(ProfileUpdated(updatedProfile));
  } catch (e) {
    emit(ProfileError('Failed to update profile: ${e.toString()}'));
  }
}

  Future<void> _onUpdateAvatar(
    UpdateAvatar event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      await SharedPreference.setString(key: 'avatarUrl', value: event.imageUrl);

      final updatedProfile = {
        'name': SharedPreference.getString(key: 'name'),
        'email': SharedPreference.getString(key: 'email'),
        'phone': SharedPreference.getString(key: 'phone'),
        'password': SharedPreference.getString(key: 'password'),
        'avatarUrl': event.imageUrl,
      };
      emit(ProfileUpdated(updatedProfile));
    } catch (e) {
      emit(ProfileError('Failed to update avatar: ${e.toString()}'));
    }
  }
}