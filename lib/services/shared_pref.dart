import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future<T> read<T>(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) as T;
  }

  static void save<T>(String key, T value) async {
    final prefs = await SharedPreferences.getInstance();
    if (T is String) {
      prefs.setString(key, value as String);
    } else if (T is int) {
      prefs.setInt(key, value as int);
    }
  }

  static void remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
