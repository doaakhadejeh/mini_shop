import 'package:flutter/material.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';
import 'package:mimi_shope/feature/order/data/model/order_model.dart';

class OrderItemsPreview extends StatelessWidget {
  final OrderModel order;
  final AppColors colors;

  const OrderItemsPreview({
    super.key,
    required this.order,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final itemNames = order.items
        .map((item) => '${item.productName} ×${item.quantity}')
        .toList();

    String text = itemNames.join(', ');

    if (text.length > 70) {
      text = '${text.substring(0, 67)}...';
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.shopping_bag_outlined, size: 20, color: colors.subText),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            text,
            style: TextStyle(color: colors.subText, fontSize: 13, height: 1.4),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
