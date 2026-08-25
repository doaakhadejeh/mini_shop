import 'package:flutter/material.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';
import 'package:mimi_shope/feature/chekout/ui/widget/section_title.dart';
import 'package:mimi_shope/feature/detailesOrders/ui/widget/delivery_card.dart';
import 'package:mimi_shope/feature/detailesOrders/ui/widget/order_detailes_item.dart';
import 'package:mimi_shope/feature/detailesOrders/ui/widget/payment.dart';
import 'package:mimi_shope/feature/detailesOrders/ui/widget/price_detailes_order_detailes.dart';
import 'package:mimi_shope/feature/order/data/model/order_model.dart';
import 'package:mimi_shope/feature/order/ui/widget/order_header.dart';

class OrderDetailsContent extends StatelessWidget {
  final OrderModel order;
  final AppColors colors;
  final ColorScheme colorScheme;

  const OrderDetailsContent({
    super.key,
    required this.order,
    required this.colors,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderHeader(order: order, colors: colors, colorScheme: colorScheme),

          const SizedBox(height: 24),

          SectionTitle(title: 'Items', colors: colors),

          const SizedBox(height: 12),

          OrderDetailesItems(order: order, colors: colors),

          const SizedBox(height: 24),

          SectionTitle(title: 'Delivery', colors: colors),

          const SizedBox(height: 12),

          DeliveryCard(order: order, colors: colors, colorScheme: colorScheme),

          const SizedBox(height: 24),

          SectionTitle(title: 'Payment', colors: colors),

          const SizedBox(height: 12),

          PaymentCard(order: order, colors: colors, colorScheme: colorScheme),

          const SizedBox(height: 24),

          SectionTitle(title: 'Price Details', colors: colors),

          const SizedBox(height: 12),

          PriceDetailesOrderDetailes(order: order, colors: colors),
        ],
      ),
    );
  }
}
