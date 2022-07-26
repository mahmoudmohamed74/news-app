import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolean({
    required String key,
    required bool value,
  }) async {
    return sharedPreferences.setBool(key, value);
  }

  static dynamic getBoolean({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }
}
