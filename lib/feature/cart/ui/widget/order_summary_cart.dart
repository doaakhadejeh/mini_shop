import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';
import 'package:mimi_shope/feature/cart/ui/widget/price_row_cart.dart';

class OrderSummary extends StatelessWidget {
  final double subtotal;
  final double deliveryFee;
  final double total;
  final AppColors appColors;
  final Color primaryColor;

  const OrderSummary({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.appColors,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 20.h),
      decoration: BoxDecoration(
        color: appColors.cardBackground,
        border: Border(top: BorderSide(color: appColors.cardBorder)),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        children: [
          PriceRow(title: 'Subtotal', value: subtotal, appColors: appColors),

          SizedBox(height: 10.h),

          PriceRow(title: 'Delivery', value: deliveryFee, appColors: appColors),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: Divider(color: appColors.cardBorder, height: 1),
          ),

          PriceRow(
            title: 'Total',
            value: total,
            appColors: appColors,
            isTotal: true,
          ),

          SizedBox(height: 18.h),

          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: Text(
                'Checkout',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
