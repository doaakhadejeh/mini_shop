import 'package:flutter/material.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';

class PaymentStatus extends StatelessWidget {
  final String status;
  final AppColors colors;
  final ColorScheme colorScheme;

  const PaymentStatus({
    super.key,
    required this.status,
    required this.colors,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final isPaid = status.toLowerCase() == 'paid';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: (isPaid ? Colors.green : colors.subText).withAlpha(12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isPaid ? 'Paid' : 'Unpaid',
        style: TextStyle(
          color: isPaid ? Colors.green : colors.subText,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
