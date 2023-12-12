import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  Future<bool> getTheme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool('darkMode') ?? false;
  }
}
