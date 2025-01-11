class Validation {

  static String? validateFullName(String? value) {
  if (value == null || value.isEmpty) {
  return "Full name is required.";
  }
  if (value[0] != value[0].toUpperCase()) {
  return "The first letter must be capitalized.";
  }
  return null;
  }

  static String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
  return "Email is required.";
  }
  if (!value.contains("@")) {
  return "Email must contain '@'.";
  }
  return null;
  }

  static String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
  return "Password is required.";
  }
  if (value.length < 6) {
  return "Password must be at least 6 characters.";
  }
  return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
  if (value == null || value.isEmpty) {
  return "Confirm password is required.";
  }
  if (value != password) {
  return "Passwords do not match.";
  }
  return null;
  }
  }

