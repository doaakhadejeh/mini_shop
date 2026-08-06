import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color categorySelector;
  final Color categorySelectorText;

  const AppColors({
    required this.categorySelector,
    required this.categorySelectorText,
  });

  @override
  AppColors copyWith({Color? categorySelector, Color? categorySelectorText}) {
    return AppColors(
      categorySelector: categorySelector ?? this.categorySelector,
      categorySelectorText: categorySelectorText ?? this.categorySelectorText,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;

    return AppColors(
      categorySelector: Color.lerp(
        categorySelector,
        other.categorySelector,
        t,
      )!,
      categorySelectorText: Color.lerp(
        categorySelectorText,
        other.categorySelectorText,
        t,
      )!,
    );
  }
}
