import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';

Widget buildSectionTitle(BuildContext context, String title, AppColors colors) {
  return Padding(
    padding: EdgeInsets.only(left: 4.w, bottom: 10.h),
    child: Text(
      title,
      style: TextStyle(
        color: colors.mainText,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
