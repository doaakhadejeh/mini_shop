import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';

class EmptyCart extends StatelessWidget {
  final AppColors appColors;

  const EmptyCart({super.key, required this.appColors});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 80.sp,
              color: appColors.subText,
            ),

            SizedBox(height: 20.h),

            Text(
              'Your cart is empty',
              style: TextStyle(
                color: appColors.mainText,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              'Looks like you haven’t added anything to your cart yet.',
              textAlign: TextAlign.center,
              style: TextStyle(color: appColors.subText, fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }
}
