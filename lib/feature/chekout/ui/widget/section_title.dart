import 'package:flutter/material.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final AppColors colors;

  const SectionTitle({super.key, required this.title, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: colors.mainText,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
