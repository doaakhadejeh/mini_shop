import 'package:flutter/material.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';

class EmptyOrders extends StatelessWidget {
  final AppColors colors;
  final ColorScheme colorScheme;

  const EmptyOrders({
    super.key,
    required this.colors,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: colorScheme.primary.withAlpha(12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.receipt_long_outlined,
                size: 45,
                color: colorScheme.primary,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'No Orders Yet',
              style: TextStyle(
                color: colors.mainText,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Your orders will appear here once you place your first order.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.subText,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
