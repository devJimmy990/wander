import 'package:local_auth/local_auth.dart';

class BiometricAuth {
  static final LocalAuthentication auth = LocalAuthentication();

  /// Authenticates the user using biometrics (fingerprint).

  static Future<bool> authenticate() async {
    bool isAuthenticated = false;
    try {
      // First, check if biometrics can be used
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      if (!canCheckBiometrics) return false;

      // Request biometric authentication
      isAuthenticated = await auth.authenticate(
        localizedReason:
        "Please authenticate with your fingerprint to access your profile",
        options: const AuthenticationOptions(
          biometricOnly: true, // Use only biometric authentication
          stickyAuth: true,
        ),
      );
    } catch (e) {
      print("Error during biometric authentication: $e");
    }
    return isAuthenticated;
  }
}
