import 'package:flutter/material.dart';
import 'package:new_calculator/components/theme_pref.dart';

class ThemeProvider with ChangeNotifier {
  ThemePrefs themePrefs = ThemePrefs();
  bool _darkTheme = false;

  bool get getDarkTheme => _darkTheme;
  set setDarkTheme(bool value) {
    _darkTheme = value;
    themePrefs.setDarkTheme(value);
    notifyListeners();
  }
}
