import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/core/shared_preference.dart';
import 'package:wander/controller/cubit/auth/auth_state.dart';
// ignore: library_prefixes
import 'package:wander/data/model/user.dart' as UserModel;

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AuthenticationCubit() : super(AuthenticationInitial());

  Future<void> onLoginRequested(
      {required String email, required String password}) async {
    emit(AuthenticationLoading());
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user != null) {
        _getUserData(user);
      } else {
        emit(AuthenticationError('Failed to retrieve user information.'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthenticationError('Login failed: ${e.message}'));
    }
  }

  Future<void> onLogoutRequested() async {
    emit(AuthenticationLoading());
    try {
      await _firebaseAuth.signOut();
      emit(UnAuthenticated());
    } catch (e) {
      emit(AuthenticationError('Logout failed: ${e.toString()}'));
    } finally {
      SharedPreference.remove(key: 'user');
    }
  }

  Future<void> onSignUpRequested(UserModel.User model) async {
    emit(AuthenticationLoading());
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: model.email!,
        password: model.password!,
      );
      final user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set(model.toJson());
        emit(AccountCreated());
      } else {
        emit(AuthenticationError('Failed to retrieve user information.'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthenticationError('Signup failed: ${e.message}'));
    }
  }

  UserModel.User? _getUserData(User user) {
    try {
      _firestore.collection('users').doc(user.uid).get().then((snapshot) {
        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          data.addAll({'id': user.uid});
          UserModel.User model = UserModel.User.fromJson(data);

          SharedPreference.setString(
              key: 'user', value: jsonEncode(model.toCachedJson()));
          emit(Authenticated(model));
          return model;
        } else {
          emit(AuthenticationError("User document does not exist"));
        }
      });
    } catch (e) {
      emit(AuthenticationError('Logout failed: ${e.toString()}'));
    }
    return null;
  }
}
