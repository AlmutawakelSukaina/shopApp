import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  // Singleton instance
  static final PreferencesHelper _instance = PreferencesHelper._internal();

  // SharedPreferences instance
  static SharedPreferences? _prefs;

  // Private constructor
  PreferencesHelper._internal();

  // Factory constructor
  factory PreferencesHelper() {
    return _instance;
  }

  // Initialize the SharedPreferences instance
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Getters and setters
  bool getBool(String key) {
    return _prefs?.getBool(key) ?? false;
  }

  Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  int getInt(String key) {
    return _prefs?.getInt(key) ?? 0;
  }

  Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  String getString(String key) {
    return _prefs?.getString(key) ?? '';
  }

  Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  double getDouble(String key) {
    return _prefs?.getDouble(key) ?? 0.0;
  }

  Future<void> setDouble(String key, double value) async {
    await _prefs?.setDouble(key, value);
  }
}
