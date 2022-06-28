import 'package:shared_preferences/shared_preferences.dart';

class LocalRepo {

  static const _token = 'token';
  static const _id = 'id';

  static Future<void> saveToken(String token) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(_token, token);
  }

  static Future<String?> getToken() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(_token);
  }

  static void saveUserId(int id) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_id, id);
  }

  static Future<int?> getUserId() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_id);
  }
}