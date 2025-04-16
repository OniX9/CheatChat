import 'package:cheat_chat/imports/imports.dart';

class SharedPref {
  Variables variables = Variables();
  Utilities utils = Utilities();

  Future<bool> save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, json.encode(value));
  }

  Future<Map<String, dynamic>?> get(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? val = prefs.getString(key);
    if (val != null) {
      Map<String, dynamic> responseData = jsonDecode(val);
      return responseData;
    }
    return null;
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  Future<bool?> setUser(Map<String, dynamic>? userData) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    if (userData != null) {
      return sharedPreferences.setString(variables.user, jsonEncode(userData));
    }
    return null;
  }

  Future<Map<String, dynamic>?> getUser() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? val = sharedPreferences.getString(variables.user);
    if (val != null) {
      Map<String, dynamic> responseData = jsonDecode(val);
      return responseData;
    }
    return null;
  }

  hasOnBoarded() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(variables.onBoard) != null ? true : false;
  }

  Future<bool> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}