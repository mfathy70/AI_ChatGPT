import 'package:flutter/material.dart';
import 'package:robo_ai/theme_data_dark.dart';
import 'package:robo_ai/theme_data_light.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  String? initTheme;
  ThemeMode? themeMode;

  setLightMode(String theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('theme', theme);
    themeMode = ThemeMode.light;
    initTheme = 'light';
    print(initTheme);
    notifyListeners();
  }

  setDarkmode(String theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('theme', theme);

    themeMode = ThemeMode.dark;
    initTheme = 'dark';
    print(initTheme);
    notifyListeners();
  }

  initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    initTheme = prefs.getString('theme');
    initTheme == 'light' ? themeMode = ThemeMode.light : ThemeMode.dark;
    print(initTheme);
    notifyListeners();
  }
}
