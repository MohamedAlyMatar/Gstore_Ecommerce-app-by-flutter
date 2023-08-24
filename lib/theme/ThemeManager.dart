import 'package:flutter/material.dart';

class ThemeManager {
  static bool isDarkMode = false;

  static ThemeData lightTheme = ThemeData.light();
  static ThemeData darkTheme = ThemeData.dark();

  static ThemeData get currentTheme =>
      isDarkMode ? darkTheme : lightTheme;

  static void toggleTheme(BuildContext context) {
    isDarkMode = !isDarkMode;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(
          isDarkMode ? 'Switched to Dark Mode' : 'Switched to Light Mode',
        ),
      ),
    );
  }
}
