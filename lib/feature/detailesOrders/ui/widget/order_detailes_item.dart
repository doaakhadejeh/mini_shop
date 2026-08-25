import 'package:flutter/material.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';
import 'package:mimi_shope/feature/order/data/model/order_model.dart';

class OrderDetailesItems extends StatelessWidget {
  final OrderModel order;
  final AppColors colors;

  const OrderDetailesItems({
    super.key,
    required this.order,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.cardBorder),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(14),
        itemCount: order.items.length,
        separatorBuilder: (_, _) {
          return Divider(color: colors.cardBorder, height: 20);
        },
        itemBuilder: (context, index) {
          final item = order.items[index];

          return Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: colors.searchBarBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.coffee_outlined, color: colors.subText),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.productName,
                      style: TextStyle(
                        color: colors.mainText,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      'Qty: ${item.quantity}',
                      style: TextStyle(color: colors.subText, fontSize: 12),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: colors.mainText,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    '\$${item.totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(color: colors.subText, fontSize: 11),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
