import 'package:flutter/material.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';
import 'package:mimi_shope/feature/detailesOrders/ui/widget/statuse_widget.dart';
import 'package:mimi_shope/feature/order/data/model/order_model.dart';

class OrderHeader extends StatelessWidget {
  final OrderModel order;
  final AppColors colors;
  final ColorScheme colorScheme;

  const OrderHeader({
    super.key,
    required this.order,
    required this.colors,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.cardBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: colorScheme.primary.withAlpha(12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.receipt_long_outlined,
              color: colorScheme.primary,
              size: 27,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order #${order.id}',
                  style: TextStyle(
                    color: colors.mainText,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  _formatDate(order.createdAt),
                  style: TextStyle(color: colors.subText, fontSize: 12),
                ),
              ],
            ),
          ),

          StatusBadgeOrderDetailes(
            status: order.orderStatus,
            colorScheme: colorScheme,
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}
