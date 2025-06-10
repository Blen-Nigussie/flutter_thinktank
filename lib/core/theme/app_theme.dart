import 'package:flutter/material.dart';

class AppTheme {
  AppTheme(bool isDarkMode);

  // your existing code

  ThemeData get lightTheme => ThemeData.light();
  // Optionally, also define darkTheme and themeMode if not already present
  ThemeData get darkTheme => ThemeData.dark();
  ThemeMode get themeMode => ThemeMode.system;
}