import 'package:flutter/material.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';
import 'package:mimi_shope/feature/order/data/model/order_model.dart';
import 'package:mimi_shope/feature/order/ui/widget/status_badge.dart';

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
    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: colorScheme.primary.withAlpha(12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.receipt_long_outlined, color: colorScheme.primary),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order #${order.id}',
                style: TextStyle(
                  color: colors.mainText,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 5),

              Text(
                _formatDate(order.createdAt),
                style: TextStyle(color: colors.subText, fontSize: 12),
              ),
            ],
          ),
        ),

        StatusBadge(
          status: order.orderStatus,
          colors: colors,
          colorScheme: colorScheme,
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}
