import 'package:flutter/material.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';

class LightTheme {
  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarThemeData(
      backgroundColor: Colors.brown,
      centerTitle: true,
      foregroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.brown.shade600,
      brightness: Brightness.light,
    ),
    extensions: [
      const AppColors(
        categorySelector: Color(0xFF1F1F1F),
        categorySelectorText: Colors.grey,
      ),
    ],
  );
}
