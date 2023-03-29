import 'package:flutter/material.dart';

ThemeData themeDataDark() {
  return ThemeData(
    useMaterial3: true,
    primaryColorLight: Colors.white70,
    scaffoldBackgroundColor: const Color(0xFF343541),
    cardColor: const Color(0xFF444654),
    dividerColor: Colors.black.withOpacity(0.6),
    highlightColor: const Color(0xFF444654),
    indicatorColor: Colors.white70,
    textTheme: const TextTheme(
        titleLarge: TextStyle(
            color: Colors.white70, fontSize: 24, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(
            color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w600)),
  );
}
