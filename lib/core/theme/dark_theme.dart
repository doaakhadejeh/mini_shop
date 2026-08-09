import 'package:flutter/material.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';

class DarkTheme {
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF0C0C0C),
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFC67C4E),
      brightness: Brightness.dark,
    ),
    extensions: [
      const AppColors(
        cardBackground: Color(0xFF1A1A1A),
        cardBorder: Color(0xFF2A2A2A),
        mainText: Colors.white,
        subText: Color(0xFFA2A2A2),
        searchBarBackground: Color.fromARGB(255, 61, 61, 61),
        categoryUnselectedBg: Color.fromARGB(255, 61, 61, 61),
        categoryUnselectedText: Color(0xFFA2A2A2),
      ),
    ],
  );
}
