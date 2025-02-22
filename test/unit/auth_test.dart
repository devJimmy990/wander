import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wander/controller/cubit/auth/auth_cubit.dart';
import 'package:wander/controller/cubit/auth/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Mock classes
class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockUser extends Mock implements User {}

void main() {
  group('AuthenticationCubit Tests', () {
    late AuthenticationCubit authCubit;
    late MockFirebaseAuth mockFirebaseAuth;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      authCubit = AuthenticationCubit();
    });

    test('Initial state should be AuthenticationInitial', () {
      expect(authCubit.state, isA<AuthenticationInitial>());
    });

    test('Login failure emits AuthenticationError state', () async {
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'test@gmail.com',
        password: 'testpassword',
      )).thenThrow(FirebaseAuthException(code: 'user-not-found'));

      authCubit.onLoginRequested(email: 'test@gmail.com', password: 'testpassword');

      await Future.delayed(Duration(milliseconds: 100));

      expect(authCubit.state, isA<AuthenticationError>());
    });

    test('Logout emits UnAuthenticated state', () async {
      authCubit.onLogoutRequested();
      await Future.delayed(Duration(milliseconds: 100));
      expect(authCubit.state, isA<UnAuthenticated>());
    });
  });
}
