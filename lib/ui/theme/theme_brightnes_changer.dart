import 'package:chat/data/storage/shared_preferences_helper.dart';
import 'package:flutter/material.dart';

class ThemeBrightnesChanger with ChangeNotifier {
  var _themeMode = getInitialThemeMode();
  ThemeMode get themeMode => _themeMode;

  static ThemeMode getInitialThemeMode() {
    final mode = ThemeBrigtnessStorage.getMode();
    if (mode == "dark") {
      return ThemeMode.dark;
    } else if (mode == "light") {
      return ThemeMode.light;
    } else {
      return ThemeMode.system;
    }
  }

  void setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    if (themeMode == ThemeMode.system) {
      ThemeBrigtnessStorage.clearMode();
    } else {
      ThemeBrigtnessStorage.setMode(
          themeMode == ThemeMode.dark ? "dark" : "light");
    }
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.dark) {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.dark;
    }
    ThemeBrigtnessStorage.setMode(
        _themeMode == ThemeMode.dark ? "dark" : "light");
    notifyListeners();
  }
}
