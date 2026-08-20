import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';

class PriceRow extends StatelessWidget {
  final String title;
  final double value;
  final AppColors appColors;
  final bool isTotal;

  const PriceRow({
    super.key,
    required this.title,
    required this.value,
    required this.appColors,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: isTotal ? appColors.mainText : appColors.subText,
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: TextStyle(
            color: appColors.mainText,
            fontSize: isTotal ? 18.sp : 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
