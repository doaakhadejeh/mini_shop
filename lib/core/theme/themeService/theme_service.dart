import 'package:flutter/material.dart';
import 'package:mimi_shope/core/helper/shared_pref.dart';

class ThemeService {
  Future<void> saveTheme(ThemeMode mode) async {
    SharedPrefHelper.setData("theme", mode.name);
  }

  Future<ThemeMode> loadTheme() async {
    final theme = SharedPrefHelper.getString("theme");

    switch (theme) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
