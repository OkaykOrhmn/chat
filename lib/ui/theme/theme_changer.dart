import 'package:chat/data/storage/shared_preferences_helper.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  var _theme = initialTheme();

  FlexScheme get theme => _theme;

  static FlexScheme initialTheme() {
    final theme = ThemeStorage.getTheme();
    if (theme == "default") {
      return FlexScheme.values.first;
    } else {
      return FlexScheme.values.firstWhere((element) => element.name == theme);
    }
  }

  void setTheme(FlexScheme theme) {
    _theme = theme;
    ThemeStorage.setTheme(theme.name);
    notifyListeners();
  }
}
