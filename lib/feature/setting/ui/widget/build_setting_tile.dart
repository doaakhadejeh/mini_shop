import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';

Widget buildSettingTile({
  required BuildContext context,
  required AppColors colors,
  required IconData icon,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
  bool isDestructive = false,
}) {
  final Color titleColor = isDestructive
      ? Theme.of(context).colorScheme.error
      : colors.mainText;

  final Color iconColor = isDestructive
      ? Theme.of(context).colorScheme.error
      : colors.mainText;

  return Container(
    decoration: BoxDecoration(
      color: colors.cardBackground,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: colors.cardBorder),
    ),
    child: ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      leading: Container(
        width: 44.w,
        height: 44.h,
        decoration: BoxDecoration(
          color: colors.searchBarBackground,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(icon, color: iconColor, size: 22.w),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor,
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: colors.subText, fontSize: 12.sp),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 15.sp,
        color: colors.subText,
      ),
    ),
  );
}
