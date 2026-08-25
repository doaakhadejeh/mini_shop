import 'package:flutter/material.dart';

import 'package:mimi_shope/core/theme/theme_extention.dart';
import 'package:mimi_shope/feature/detailesOrders/ui/widget/order_detailes_content.dart';
import 'package:mimi_shope/feature/order/data/model/order_model.dart';

class OrderDetailsPage extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsPage({super.key, required this.order});

  @override
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Details',
          style: TextStyle(color: colors.mainText, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: colors.mainText),
      ),
      body: OrderDetailsContent(
        order: order,
        colors: colors,
        colorScheme: colorScheme,
      ),
    );
  }
}
