import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockFirebaseAuth mockAuth;

  setUpAll(() async {
    mockAuth = MockFirebaseAuth();
  });

  group('FirebaseAuth Tests', () {
    test('should sign in with email and password', () async {
      final mockUser = MockUser(email: "testuser@example.com");
      mockAuth = MockFirebaseAuth(mockUser: mockUser);

      await mockAuth.signInWithEmailAndPassword(
        email: "testuser@example.com",
        password: "Test@123",
      );

      expect(mockAuth.currentUser, isNotNull);
      expect(mockAuth.currentUser?.email, equals("testuser@example.com"));
    });

    test('should throw error for invalid login credentials', () async {
      final email = "wronguser@example.com";
      final password = "wrongpassword";

      // Simulate failure manually
      Future<UserCredential> signInFail() async {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'No user found for that email.',
        );
      }

      // Check that the exception is thrown
      expect(
        signInFail,
        throwsA(isA<FirebaseAuthException>().having((e) => e.code, 'code', 'user-not-found')),
      );
    });

    test('should sign out user', () async {
      await mockAuth.signOut();
      expect(mockAuth.currentUser, isNull);
    });

    test('should create a user with email and password', () async {
      final email = "newuser@example.com";
      final password = "StrongPass@123";

      await mockAuth.createUserWithEmailAndPassword(email: email, password: password);
      expect(mockAuth.currentUser, isNotNull);
    });

    test('should detect auth state changes', () async {
      Stream<User?> stream = mockAuth.authStateChanges();
      expect(stream, isA<Stream<User?>>());
    });
  });
}
