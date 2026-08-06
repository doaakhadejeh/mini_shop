import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  SharedPrefHelper._();

  static late final SharedPreferences _prefs;
  static late final FlutterSecureStorage _secureStorage;

  /// Initializes SharedPreferences and FlutterSecureStorage instances.
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _secureStorage = const FlutterSecureStorage();
  }

  /// Clears all locally stored user data.
  static Future<void> logout() async {
    await clearAllSecuredData();
    await clearAllData();
  }

  /// Gets a String value from SharedPreferences with the given [key].
  static String getString(String key) {
    debugPrint('SharedPrefHelper : getString with key : $key');
    return _prefs.getString(key) ?? '';
  }

  /// Gets a bool value from SharedPreferences with the given [key].
  static bool getBool(String key) {
    debugPrint('SharedPrefHelper : getBool with key : $key');
    return _prefs.getBool(key) ?? false;
  }

  /// Gets a double value from SharedPreferences with the given [key].
  static double getDouble(String key) {
    debugPrint('SharedPrefHelper : getDouble with key : $key');
    return _prefs.getDouble(key) ?? 0.0;
  }

  /// Gets an int value from SharedPreferences with the given [key].
  static int getInt(String key) {
    debugPrint('SharedPrefHelper : getInt with key : $key');
    return _prefs.getInt(key) ?? 0;
  }

  /// Saves a [value] with the given [key] in SharedPreferences.
  static Future<void> setData(String key, dynamic value) async {
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else {
      throw UnsupportedError('Unsupported type: ${value.runtimeType}');
    }
  }

  /// Removes the value associated with the given [key] from SharedPreferences.
  static Future<void> removeData(String key) async {
    debugPrint('SharedPrefHelper : data with key : $key has been removed');
    await _prefs.remove(key);
  }

  /// Removes all keys and values from SharedPreferences.
  static Future<void> clearAllData() async {
    debugPrint('SharedPrefHelper : all data has been cleared');
    await _prefs.clear();
  }

  /// Saves a String [value] with the given [key] in FlutterSecureStorage.
  static Future<void> setSecuredString(String key, String value) async {
    debugPrint(
      'FlutterSecureStorage : setSecuredString with key : $key and value : $value',
    );
    await _secureStorage.write(key: key, value: value);
  }

  /// Gets a String value from FlutterSecureStorage with the given [key].
  static Future<String> getSecuredString(String key) async {
    debugPrint('FlutterSecureStorage : getSecuredString with key : $key');
    return await _secureStorage.read(key: key) ?? '';
  }

  /// Removes all keys and values from FlutterSecureStorage.
  static Future<void> clearAllSecuredData() async {
    debugPrint('FlutterSecureStorage : all data has been cleared');
    await _secureStorage.deleteAll();
  }
}
