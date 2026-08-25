import 'package:flutter/material.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';
import 'package:mimi_shope/feature/chekout/logic/checkout_cubit.dart';

class OrderItems extends StatelessWidget {
  final CheckoutCubit cubit;
  final AppColors colors;

  const OrderItems({super.key, required this.cubit, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.cardBorder),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(14),
        itemCount: cubit.cartItems.length,
        separatorBuilder: (_, _) =>
            Divider(color: colors.cardBorder, height: 20),
        itemBuilder: (context, index) {
          final item = cubit.cartItems[index];

          return Row(
            children: [
              // Product image
              Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  color: colors.searchBarBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: item.product.image != null
                    ? Image.network(
                        item.product.image!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) {
                          return Icon(Icons.coffee, color: colors.subText);
                        },
                      )
                    : Icon(Icons.coffee, color: colors.subText),
              ),

              const SizedBox(width: 12),

              // Name + quantity
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.product.name,
                      style: TextStyle(
                        color: colors.mainText,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      'Qty: ${item.quantity}',
                      style: TextStyle(color: colors.subText, fontSize: 13),
                    ),
                  ],
                ),
              ),

              Text(
                '\$${item.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  color: colors.mainText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
