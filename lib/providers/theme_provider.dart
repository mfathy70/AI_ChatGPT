import 'package:flutter/material.dart';
import 'package:robo_ai/theme_data_dark.dart';
import 'package:robo_ai/theme_data_light.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData? currentTheme;
  ThemeMode? themeMode;

  setLightMode() {
    currentTheme = themeDataLight();
    themeMode = ThemeMode.light;
    notifyListeners();
  }

  setDarkmode() {
    currentTheme = themeDataDark();
    themeMode = ThemeMode.dark;
    notifyListeners();
  }
}
