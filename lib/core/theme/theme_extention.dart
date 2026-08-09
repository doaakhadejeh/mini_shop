import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color cardBackground;
  final Color cardBorder;
  final Color mainText;
  final Color subText;
  final Color searchBarBackground;
  final Color categoryUnselectedBg;
  final Color categoryUnselectedText;

  const AppColors({
    required this.cardBackground,
    required this.cardBorder,
    required this.mainText,
    required this.subText,
    required this.searchBarBackground,
    required this.categoryUnselectedBg,
    required this.categoryUnselectedText,
  });

  @override
  AppColors copyWith({
    Color? cardBackground,
    Color? cardBorder,
    Color? mainText,
    Color? subText,
    Color? searchBarBackground,
    Color? categoryUnselectedBg,
    Color? categoryUnselectedText,
  }) {
    return AppColors(
      cardBackground: cardBackground ?? this.cardBackground,
      cardBorder: cardBorder ?? this.cardBorder,
      mainText: mainText ?? this.mainText,
      subText: subText ?? this.subText,
      searchBarBackground: searchBarBackground ?? this.searchBarBackground,
      categoryUnselectedBg: categoryUnselectedBg ?? this.categoryUnselectedBg,
      categoryUnselectedText:
          categoryUnselectedText ?? this.categoryUnselectedText,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      cardBorder: Color.lerp(cardBorder, other.cardBorder, t)!,
      mainText: Color.lerp(mainText, other.mainText, t)!,
      subText: Color.lerp(subText, other.subText, t)!,
      searchBarBackground: Color.lerp(
        searchBarBackground,
        other.searchBarBackground,
        t,
      )!,
      categoryUnselectedBg: Color.lerp(
        categoryUnselectedBg,
        other.categoryUnselectedBg,
        t,
      )!,
      categoryUnselectedText: Color.lerp(
        categoryUnselectedText,
        other.categoryUnselectedText,
        t,
      )!,
    );
  }
}
