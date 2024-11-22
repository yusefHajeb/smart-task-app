import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrenceHelper {
  SharedPrefrenceHelper._();

  static Future<String?> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> setData(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    }
  }

  static Future<void> remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static Future<dynamic> getData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  static Future<void> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }
}
