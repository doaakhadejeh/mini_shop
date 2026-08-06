import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimi_shope/core/theme/themeService/theme_service.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final ThemeService themeService;
  ThemeCubit(this.themeService) : super(ThemeMode.system);

  Future<void> loadTheme() async {
    final mode = await themeService.loadTheme();

    emit(mode);
  }

  Future<void> changeTheme(ThemeMode mode) async {
    await themeService.saveTheme(mode);
    emit(mode);
  }
}
