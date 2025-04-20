import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static late SharedPreferences prefs;

  static Future initialize() async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      prefs = preferences;
    } catch (e) {
      if (kDebugMode) {
        print("Error initializing SharedPreferences: $e");
      }
    }
  }

  static const String themeMode = 'theme-mode';
  static const String theme = 'theme';
  static const String token = 'auth_token';
}

class ThemeBrigtnessStorage {
  static String getMode() {
    final prefs = SharedPreferencesHelper.prefs;
    return prefs.getString(SharedPreferencesHelper.themeMode) ?? "system";
  }

  static void setMode(String mode) {
    final prefs = SharedPreferencesHelper.prefs;
    prefs.setString(SharedPreferencesHelper.themeMode, mode);
  }

  static void clearMode() {
    final prefs = SharedPreferencesHelper.prefs;
    prefs.remove(SharedPreferencesHelper.themeMode);
  }
}

class ThemeStorage {
  static String getTheme() {
    final prefs = SharedPreferencesHelper.prefs;
    return prefs.getString(SharedPreferencesHelper.theme) ?? "default";
  }

  static void setTheme(String theme) {
    final prefs = SharedPreferencesHelper.prefs;
    prefs.setString(SharedPreferencesHelper.theme, theme);
  }

  static void clearTheme() {
    final prefs = SharedPreferencesHelper.prefs;
    prefs.remove(SharedPreferencesHelper.theme);
  }
}

class AuthTokenStorage {
  static String getToken() {
    final prefs = SharedPreferencesHelper.prefs;
    return prefs.getString(SharedPreferencesHelper.token) ?? "";
  }

  static void setToken(String token) {
    final prefs = SharedPreferencesHelper.prefs;
    prefs.setString(SharedPreferencesHelper.token, token);
  }

  static void clearToken() {
    final prefs = SharedPreferencesHelper.prefs;
    prefs.remove(SharedPreferencesHelper.token);
  }
}
