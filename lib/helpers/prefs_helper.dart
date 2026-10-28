
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_constant.dart';

class PrefsHelper {
  // The auth token goes to the Keychain / encrypted storage instead of plain preferences.
  static const _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static bool _isSecure(String key) => key == AppConstants.bearerToken;

  static Future<String> getString(String key) async {
    if (_isSecure(key)) return await _secureStorage.read(key: key) ?? "";
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getString(key) ?? "";
  }
  static Future<void> setString(String key, String value) async {
    if (_isSecure(key)) return _secureStorage.write(key: key, value: value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<bool> getBool(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getBool(key) ?? false;
  }



  static Future setBool(String key, bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(key, value);
  }
  static  Future setInt(String key,int value)async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt(key, value);
  }
  static Future<int> getInt(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key)??(-1);
  }
  static Future remove(String key) async {
    if (_isSecure(key)) return _secureStorage.delete(key: key);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(key);
  }
}