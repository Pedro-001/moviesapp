import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static String _name = '';
  static bool _isDarkmode = false;
  static String _tokenFcm = '';

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //setters y getters

  static String get name {
    return _prefs.getString('name') ?? _name;
  }

  static set name(String name) {
    _name = name;
    _prefs.setString('name', name);
  }

  static bool get isDarkMode {
    return _prefs.getBool('isDarkmode') ?? _isDarkmode;
  }

  static set isDarkMode(bool darkMode) {
    _isDarkmode = darkMode;
    _prefs.setBool('isDarkmode', darkMode);
  }

  static String get tokenFcm {
    return _prefs.getString('tokenFcm') ?? _tokenFcm;
  }

  static set tokenFcm(String tokenFcm) {
    _tokenFcm = tokenFcm;
    _prefs.setString('tokenFcm', tokenFcm);
  }
}
