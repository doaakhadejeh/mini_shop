import 'package:flutter/material.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';

class LightTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFF9F9F9),
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFC67C4E),
      brightness: Brightness.light,
    ),
    extensions: [
      const AppColors(
        cardBackground: Colors.white,
        cardBorder: Color(0xFFEAEAEA),
        mainText: Color(0xFF2F2D2C),
        subText: Color(0xFF989898),
        searchBarBackground: Color.fromARGB(255, 231, 231, 231),
        categoryUnselectedBg: Color.fromARGB(255, 231, 231, 231),
        categoryUnselectedText: Color(0xFF2F2D2C),
      ),
    ],
  );
}
