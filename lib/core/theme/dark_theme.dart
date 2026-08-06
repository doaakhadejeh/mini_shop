import 'package:flutter/material.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';

class DarkTheme {
  static ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarThemeData(
      backgroundColor: Colors.black,
      centerTitle: true,
      foregroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.grey.withAlpha(40),
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.brown.shade600,
      brightness: Brightness.dark,
    ),
    extensions: [
      const AppColors(
        categorySelector: Colors.white,

        categorySelectorText: Color(0xFF1F1F1F),
      ),
    ],
  );
}
