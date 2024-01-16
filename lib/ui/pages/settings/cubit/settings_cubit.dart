import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SettingsState { isDarkTheme, isLightTheme }

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState.isLightTheme);

  void init() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? isDarkMode = pref.getBool('darkMode');
    if (isDarkMode == null || isDarkMode) {
      await setIsDarkMode(true);
      emit(SettingsState.isDarkTheme);
    } else {
      await setIsDarkMode(false);
      emit(SettingsState.isLightTheme);
    }
  }

  void switchTheme() => emit((state == SettingsState.isDarkTheme)
      ? SettingsState.isLightTheme
      : SettingsState.isDarkTheme);

  Future<void> setIsDarkMode(bool value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('darkMode', value);
    if (value) {
      emit(SettingsState.isDarkTheme);
    } else {
      emit(SettingsState.isLightTheme);
    }
  }
}
