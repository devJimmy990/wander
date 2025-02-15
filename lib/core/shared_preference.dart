import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static SharedPreferences? _shared;

  //initialize SharedPreferences
  static Future<void> initialize() async {
    try {
      _shared = await SharedPreferences.getInstance();
    } catch (e) {
      throw Exception('Failed to initialize SharedPreferences: $e');
    }
  }

  static Future<bool> setString({required String key, required String value}) async {
    return _shared!.setString(key, value);
  }

  static String? getString({required String key}) {
    return _shared!.getString(key);
  }

  static Future<bool> remove({required String key}) async {
    return _shared!.remove(key);
  }
}