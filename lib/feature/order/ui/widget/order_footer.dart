import 'package:flutter/material.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';
import 'package:mimi_shope/feature/order/data/model/order_model.dart';

class OrderFooter extends StatelessWidget {
  final OrderModel order;
  final AppColors colors;
  final ColorScheme colorScheme;

  const OrderFooter({
    super.key,
    required this.order,
    required this.colors,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total',
              style: TextStyle(color: colors.subText, fontSize: 12),
            ),

            const SizedBox(height: 3),

            Text(
              '\$${order.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(
                color: colors.mainText,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        const Spacer(),

        Row(
          children: [
            Icon(
              order.paymentMethod == 'cash'
                  ? Icons.payments_outlined
                  : Icons.credit_card_outlined,
              size: 18,
              color: colors.subText,
            ),

            const SizedBox(width: 5),

            Text(
              order.paymentMethod == 'cash' ? 'Cash' : 'Card',
              style: TextStyle(color: colors.subText, fontSize: 12),
            ),

            const SizedBox(width: 12),

            Icon(Icons.arrow_forward_ios, size: 14, color: colors.subText),
          ],
        ),
      ],
    );
  }
}
