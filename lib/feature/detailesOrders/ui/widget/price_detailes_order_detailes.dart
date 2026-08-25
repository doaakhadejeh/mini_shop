import 'package:flutter/material.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';
import 'package:mimi_shope/feature/order/data/model/order_model.dart';

class PriceDetailesOrderDetailes extends StatelessWidget {
  final OrderModel order;
  final AppColors colors;

  const PriceDetailesOrderDetailes({
    super.key,
    required this.order,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.cardBorder),
      ),
      child: Column(
        children: [
          _PriceRow(
            title: 'Subtotal',
            value: '\$${order.totalPrice.toStringAsFixed(2)}',
            colors: colors,
          ),

          const SizedBox(height: 12),

          _PriceRow(title: 'Delivery Fee', value: 'Free', colors: colors),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Divider(color: colors.cardBorder),
          ),

          _PriceRow(
            title: 'Total',
            value: '\$${order.totalPrice.toStringAsFixed(2)}',
            colors: colors,
            isTotal: true,
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String title;
  final String value;
  final AppColors colors;
  final bool isTotal;

  const _PriceRow({
    required this.title,
    required this.value,
    required this.colors,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: isTotal ? colors.mainText : colors.subText,
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: colors.mainText,
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
