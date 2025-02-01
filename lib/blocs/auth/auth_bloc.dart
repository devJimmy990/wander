import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<SignUpRequested>(_onSignUpRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      final user = userCredential.user;
      if (user != null) {
        emit(AuthAuthenticated(user.uid)); // Pass UID to the state
      } else {
        emit(AuthError('Failed to retrieve user information.'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError('Login failed: ${e.message}'));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _firebaseAuth.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError('Logout failed: ${e.toString()}'));
    }
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      final user = userCredential.user;
      if (user != null) {
        // Store user details in Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'name': event.name,
          'email': event.email,
          'phone': event.phone,
          'id': user.uid,
        });

        emit(AuthAuthenticated(user.uid)); // Pass UID to the state
      } else {
        emit(AuthError('Failed to retrieve user information.'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError('Signup failed: ${e.message}'));
    }
  }
}