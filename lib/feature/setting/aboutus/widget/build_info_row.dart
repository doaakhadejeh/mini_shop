import 'package:flutter/material.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';

Widget buildInfoRow(
  BuildContext context, {
  required IconData icon,
  required String title,
  required String subtitle,
}) {
  final colors = Theme.of(context).extension<AppColors>()!;

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: colors.searchBarBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 22,
        ),
      ),

      const SizedBox(width: 14),

      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: colors.mainText,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              subtitle,
              style: TextStyle(
                color: colors.subText,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
