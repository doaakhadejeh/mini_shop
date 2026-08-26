import 'package:flutter/material.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';

class TopChangePassword extends StatelessWidget {
  final AppColors? colors;
  const TopChangePassword({super.key, this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: colors!.cardBackground,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors!.cardBorder),
      ),
      child: Icon(
        Icons.lock_outline_rounded,
        size: 38,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
