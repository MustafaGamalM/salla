import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CasheHelper {
  static SharedPreferences prefs;
  static inite() async {
    prefs = await SharedPreferences.getInstance();
  }

  static dynamic getData({@required String key}) {
    return prefs.get(key);
  }

  static Future<bool> removeData({@required String key}) async {
    return await prefs.remove(key);
  }

  static Future<bool> saveData(
      {@required String key, @required dynamic value}) async {
    if (value is bool) return await prefs.setBool(key, value);
    if (value is String) return await prefs.setString(key, value);
    if (value is int) return await prefs.setInt(key, value);
    return await prefs.setDouble(key, value);
  }
}
