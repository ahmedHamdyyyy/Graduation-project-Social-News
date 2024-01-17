import 'package:shared_preferences/shared_preferences.dart';

class CacheServices {
  static late SharedPreferences shared;
  static Future get initialize async =>
      shared = await SharedPreferences.getInstance();

  Future<bool> setString(String key, String value) async =>
      await shared.setString(key, value);

  Future<bool> setBool(String key, bool value) async =>
      await shared.setBool(key, value);

  Future<bool> setInt(String key, int value) async =>
      await shared.setInt(key, value);

  String? getString(String key) => shared.getString(key);

  bool? getBool(String key) => shared.getBool(key)!;

  int? getInt(String key) => shared.getInt(key)!;

  bool checkKey(String key) => shared.containsKey(key);

  Future<bool> remove(String key) async => await shared.remove(key);
}
