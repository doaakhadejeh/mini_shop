import 'package:flutter/material.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';
import 'package:mimi_shope/feature/order/data/model/order_model.dart';
import 'package:mimi_shope/feature/order/ui/widget/order_footer.dart';
import 'package:mimi_shope/feature/order/ui/widget/order_header.dart';
import 'package:mimi_shope/feature/order/ui/widget/order_item_preview.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final AppColors colors;
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  const OrderCard({
    super.key,
    required this.order,
    required this.colors,
    required this.colorScheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.cardBackground,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: colors.cardBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrderHeader(
                order: order,
                colors: colors,
                colorScheme: colorScheme,
              ),

              const SizedBox(height: 14),

              Divider(color: colors.cardBorder, height: 1),

              const SizedBox(height: 14),

              OrderItemsPreview(order: order, colors: colors),

              const SizedBox(height: 16),

              OrderFooter(
                order: order,
                colors: colors,
                colorScheme: colorScheme,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
