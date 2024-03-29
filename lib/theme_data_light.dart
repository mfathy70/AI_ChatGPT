import 'package:flutter/material.dart';

ThemeData themeDataLight() {
  return ThemeData(
    useMaterial3: true,
    primaryColorDark: const Color(0xFF444654),
    scaffoldBackgroundColor: Colors.white,
    cardColor: const Color(0xFF444654).withOpacity(0.2),
    dividerColor: Colors.grey.withOpacity(0.6),
    highlightColor: Colors.white,
    indicatorColor: const Color(0xFF444654),
    textTheme: const TextTheme(
        titleLarge: TextStyle(
            color: Color(0xFF444654),
            fontSize: 24,
            fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600)),
  );
}
