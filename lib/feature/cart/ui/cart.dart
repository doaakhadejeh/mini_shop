import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';
import 'package:mimi_shope/feature/cart/logic/cart_cubit.dart';
import 'package:mimi_shope/feature/cart/logic/cart_state.dart';
import 'package:mimi_shope/feature/cart/ui/widget/cart_item_card.dart';
import 'package:mimi_shope/feature/cart/ui/widget/empty_cart.dart';
import 'package:mimi_shope/feature/cart/ui/widget/order_summary_cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Cart',
          style: TextStyle(
            color: appColors.mainText,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }

          if (state is CartSuccess) {
            final items = state.items;

            if (items.isEmpty) {
              return EmptyCart(appColors: appColors);
            }

            final subtotal = items.fold<double>(
              0,
              (sum, item) => sum + item.totalPrice,
            );

            const deliveryFee = 2.0;
            final total = subtotal + deliveryFee;

            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    itemCount: items.length,
                    separatorBuilder: (_, _) => SizedBox(height: 14.h),
                    itemBuilder: (context, index) {
                      return CartItemCard(
                        item: items[index],
                        appColors: appColors,
                        primaryColor: primaryColor,
                      );
                    },
                  ),
                ),

                OrderSummary(
                  subtotal: subtotal,
                  deliveryFee: deliveryFee,
                  total: total,
                  appColors: appColors,
                  primaryColor: primaryColor,
                ),
              ],
            );
          }

          if (state is CartError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: TextStyle(
                      color: appColors.mainText,
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Icon(Icons.error, color: Colors.red, size: 30.sp),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
