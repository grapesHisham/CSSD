import 'package:shared_preferences/shared_preferences.dart';

class StorageKeys {
  static const String loginToken = "loginToken";
  static const String loggedinUser = "loggedinUser";
  static const String loggedinUserPrivilegesList= "loggedinUserPrivileges";
  static const String privilegeFlagCssdAndDept= "privilegeFlagCssdAndDept";
}
 
class LocalStorageManager {
  static late SharedPreferences _preferences;

  // Initialize the SharedPreferences instance
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Save a string value
  static Future<void> setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  // Get a string value
  static String? getString(String key) {
    return _preferences.getString(key);
  }

  // Save an integer value
  static Future<void> setInt(String key, int value) async {
    await _preferences.setInt(key, value);
  }

  // Get an integer value
  static int? getInt(String key) {
    return _preferences.getInt(key);
  }

  // Save a boolean value
  static Future<void> setBool(String key, bool value) async {
    await _preferences.setBool(key, value);
  }

  // Get a boolean value
  static bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  // Save a list of strings
  static Future<void> setStringList(String key, List<String> value) async {
    await _preferences.setStringList(key, value);
  }

  // Get a list of strings
  static List<String>? getStringList(String key) {
    return _preferences.getStringList(key);
  }

  // Remove a value
  static Future<void> remove(String key) async {
    await _preferences.remove(key);
  }

  // Clear all values
  static Future<void> clear() async {
    await _preferences.clear();
  }
}
