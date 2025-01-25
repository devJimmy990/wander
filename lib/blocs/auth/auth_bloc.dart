import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:wander/core/connection.dart';
import 'package:wander/core/shared_prefrence.dart';

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
  try {
    await Future.delayed(const Duration(seconds: 2));

    //to store user data to SharedPreferences
    await SharedPreference.setString(key: 'email', value: event.email);
    await SharedPreference.setString(key: 'password', value: event.password);
    await SharedPreference.setString(key: 'name', value: event.name);
    await SharedPreference.setString(key: 'phone', value: event.phone);

    emit(AuthAuthenticated(event.email)); 
  } catch (e) {
    emit(AuthError('Signup failed: ${e.toString()}'));
  }
}

  Future<void> _onLoginRequested(
  LoginRequested event,
  Emitter<AuthState> emit,
) async {
  emit(AuthLoading());
  try {
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
