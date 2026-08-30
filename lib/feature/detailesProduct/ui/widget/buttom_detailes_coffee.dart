import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimi_shope/core/widget/custom_button.dart';
import 'package:mimi_shope/feature/cart/logic/cart_cubit.dart';
import 'package:mimi_shope/feature/detailesProduct/logic/detailes_product_cubit.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';

class BottomDetailsCoffee extends StatelessWidget {
  final CoffeeItemModel product;

  const BottomDetailsCoffee({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<DetailesProductCubit>();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.white.withAlpha(20))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Total Price',
                  style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                ),
                SizedBox(height: 4.h),
                Text(
                  '\$${cubit.getTotalPrice(product.price).toStringAsFixed(2)}',
                  style: TextStyle(
                    color: const Color(0xFFC67C4E),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          CustomButton(
            width: 80.w,
            onPressed: () {
              context.read<CartCubit>().addToCart(
                product: product,
                quantity: cubit.quantity,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added ${cubit.quantity} ${product.name} to cart!',
                  ),
                  backgroundColor: const Color(0xFFC67C4E),
                ),
              );
            },

            backgroundColor: const Color(0xFFC67C4E),
            borderColor: const Color(0xFFC67C4E),
            foregroundColor: Colors.white,
            isRectangleBorder: true,
            radiusRectangleBorder: 10.r,
            child: Text("Add to cart", style: TextStyle(fontSize: 10.sp)),
          ),
        ],
      ),
    );
  }
}
