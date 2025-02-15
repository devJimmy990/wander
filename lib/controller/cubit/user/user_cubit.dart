import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/core/shared_preference.dart';
// ignore: library_prefixes
import 'package:wander/data/model/user.dart' as UserModel;
import 'package:wander/controller/cubit/user/user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserModel.User? _user;
  UserCubit() : super(UserInitial());

  void loadUser() async {
    emit(UserLoading());
    try {
      print("User Loading");
      final String cachedUser = SharedPreference.getString(key: 'user') ?? '';
      print("cachedUser: $cachedUser");
      _user = UserModel.User.fromJson(jsonDecode(cachedUser));
      print("_user: $_user");
      // _user = UserModel.User.fromJson();

      emit(UserLoaded(_user!));
    } catch (e) {
      print('Failed to load profile: ${e.toString()}');
      emit(UserError('Failed to load profile: ${e.toString()}'));
    }
  }

  void setUser(UserModel.User user) async {
    emit(UserLoading());
    try {
      _user = user;
      emit(UserLoaded(_user!));
    } catch (e) {
      emit(UserError('Failed to load profile: ${e.toString()}'));
    }
  }

  void onUpdateProfile(UserModel.User user) async {
    emit(UserLoading());
    try {
      _user = user;
      await SharedPreference.setString(
          key: 'user', value: _user!.toJson().toString());

      emit(UserLoaded(_user!));
    } catch (e) {
      emit(UserError('Failed to update profile: ${e.toString()}'));
    }
  }

  UserModel.User? get user => _user;
}
