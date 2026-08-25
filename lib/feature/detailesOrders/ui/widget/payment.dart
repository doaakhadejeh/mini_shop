import 'package:flutter/material.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';
import 'package:mimi_shope/feature/detailesOrders/ui/widget/payment_statuse.dart';
import 'package:mimi_shope/feature/order/data/model/order_model.dart';

class PaymentCard extends StatelessWidget {
  final OrderModel order;
  final AppColors colors;
  final ColorScheme colorScheme;

  const PaymentCard({
    super.key,
    required this.order,
    required this.colors,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final isCash = order.paymentMethod == 'cash';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.cardBorder),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colorScheme.primary.withAlpha(12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCash ? Icons.payments_outlined : Icons.credit_card_outlined,
              color: colorScheme.primary,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Method',
                  style: TextStyle(
                    color: colors.mainText,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  isCash ? 'Cash on Delivery' : 'Credit / Debit Card',
                  style: TextStyle(color: colors.subText, fontSize: 13),
                ),
              ],
            ),
          ),

          PaymentStatus(
            status: order.paymentStatus,
            colors: colors,
            colorScheme: colorScheme,
          ),
        ],
      ),
    );
  }
}
