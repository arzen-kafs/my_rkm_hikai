import 'package:shared_preferences/shared_preferences.dart';

class Session {
  SharedPreferences prefs;
  void addString(String key, String value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  void addInteger(String key, int value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  void addDouble(String key, double value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }

  void addBool(String key, bool value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  Future<String> getString(String key) async {
    prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString(key) ?? "AAAAAA";
    return stringValue;
  }

  Future<bool> getBool(String key) async {
    prefs = await SharedPreferences.getInstance();
    bool boolValue = prefs.getBool(key) ?? false;
    return boolValue;
  }

  Future<int> getInteger(String key) async {
    prefs = await SharedPreferences.getInstance();
    int intValue = prefs.getInt(key) ?? 0;
    return intValue;
  }

  Future<double> getDouble(String key) async {
    prefs = await SharedPreferences.getInstance();
    double doubleValue = prefs.getDouble(key) ?? 0.0;
    return doubleValue;
  }

  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("stringValue");
    //Remove bool
    prefs.remove("boolValue");
    //Remove int
    prefs.remove("intValue");
    //Remove double
    prefs.remove("doubleValue");
  }

  Future<bool> isset(String key) async {
    prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey(key);
    return checkValue;
  }
}

