import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/core/connection.dart';
import 'package:wander/core/shared_prefrence.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wander/data/model/firebase_user_model.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Connection _connection = Connection.instance;

  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<SignUpRequested>(_onSignUpRequested);
    _checkAuthenticationStatus();           //to check if the user is already authenticated
  }

  Future<void> _checkAuthenticationStatus() async {
    final userId = SharedPreference.getString(key: 'userId');
    if (userId != null) {
      emit(AuthAuthenticated(userId));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onSignUpRequested(
  SignUpRequested event,
  Emitter<AuthState> emit,

) async {
  emit(AuthLoading());

  // adding firebase to create users
  try {
    final firestoreInstance = FirebaseFirestore.instance;
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: event.email,
    password: event.password,

  );
    FirebaseUserModel user = FirebaseUserModel(email: event.email,name: event.name,phone: event.phone);
    final response = await firestoreInstance.collection('users').add(user.toFirestore());
    debugPrint('as,db asm b${response.toString()}');
    await Future.delayed(const Duration(seconds: 2));

    //to store user data to SharedPreferences
    await SharedPreference.setString(key: 'email', value: event.email);
    await SharedPreference.setString(key: 'password', value: event.password);
    await SharedPreference.setString(key: 'name', value: event.name);
    await SharedPreference.setString(key: 'phone', value: event.phone);


    
    emit(AuthAuthenticated(event.email));

    
  }on FirebaseAuthException catch (e) {
    emit(AuthError(e.message ?? 'Signup failed'));}
  catch (e) {
    debugPrint('e is e${e.toString()}');
    emit(AuthError('Signup failed: ${e.toString()}'));
  }
}

  Future<void> _onLoginRequested(
  LoginRequested event,
  Emitter<AuthState> emit,
) async {
  emit(AuthLoading());
  try {
     await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: event.email,
      password: event.password,
    );
    // Retrieve stored user data from SharedPreferences
    final storedEmail = SharedPreference.getString(key: 'email');
    final storedPassword = SharedPreference.getString(key: 'password');

    // Check if the entered credentials match the stored data
    if (storedEmail == event.email && storedPassword == event.password) {
      emit(AuthAuthenticated(storedEmail!)); // Use email as a unique identifier
    } else {
      emit(AuthError('User not found'));
    }
  } catch (e) {
    emit(AuthError('Login failed: ${e.toString()}'));
  }
}

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    // Remove the user ID from SharedPreferences
    await SharedPreference.remove(key: 'userId');
    emit(AuthUnauthenticated());
  }
}
