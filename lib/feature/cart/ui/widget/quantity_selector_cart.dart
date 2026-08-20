import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final Color primaryColor;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.primaryColor,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: primaryColor.withAlpha(100)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onDecrease,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(minWidth: 30.w),
            icon: Icon(Icons.remove, size: 16.sp, color: primaryColor),
          ),

          Text(
            '$quantity',
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
          ),

          IconButton(
            onPressed: onIncrease,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(minWidth: 30.w),
            icon: Icon(Icons.add, size: 16.sp, color: primaryColor),
          ),
        ],
      ),
    );
  }
}
