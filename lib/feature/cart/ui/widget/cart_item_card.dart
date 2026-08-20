import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';
import 'package:mimi_shope/feature/cart/data/model/cart_model.dart';
import 'package:mimi_shope/feature/cart/logic/cart_cubit.dart';
import 'package:mimi_shope/feature/cart/ui/widget/quantity_selector_cart.dart';

class CartItemCard extends StatelessWidget {
  final CartItemModel item;
  final AppColors appColors;
  final Color primaryColor;

  const CartItemCard({
    super.key,
    required this.item,
    required this.appColors,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: appColors.cardBackground,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: appColors.cardBorder),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            child: SizedBox(
              width: 90.w,
              height: 90.h,
              child: Image.network(
                item.product.image ?? '',
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) {
                  return Icon(
                    Icons.local_cafe,
                    size: 35.sp,
                    color: appColors.subText,
                  );
                },
              ),
            ),
          ),

          SizedBox(width: 14.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: appColors.mainText,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        cartCubit.removeFromCart(productId: item.product.id);
                      },
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(
                        minWidth: 30.w,
                        minHeight: 30.h,
                      ),
                      icon: Icon(
                        Icons.delete_outline,
                        color: appColors.subText,
                        size: 21.sp,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 4.h),

                Text(
                  item.product.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: appColors.subText, fontSize: 12.sp),
                ),

                SizedBox(height: 10.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item.totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: appColors.mainText,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    QuantitySelector(
                      quantity: item.quantity,
                      primaryColor: primaryColor,
                      onIncrease: () {
                        cartCubit.increaseQuantity(productId: item.product.id);
                      },
                      onDecrease: () {
                        cartCubit.decreaseQuantity(productId: item.product.id);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
