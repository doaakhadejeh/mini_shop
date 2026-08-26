import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';

Widget buildThemeOption({
  required BuildContext context,
  required String title,
  required String subtitle,
  required IconData icon,
  required ThemeMode mode,
  required VoidCallback onTap,
}) {
  final colors = Theme.of(context).extension<AppColors>()!;

  return ListTile(
    onTap: onTap,
    contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
    leading: Icon(icon, color: colors.mainText, size: 24.sp),
    title: Text(
      title,
      style: TextStyle(
        color: colors.mainText,
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
    subtitle: Text(
      subtitle,
      style: TextStyle(color: colors.subText, fontSize: 12.sp),
    ),
    trailing: Radio<ThemeMode>(value: mode),
  );
}
