import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimi_shope/core/theme/cubit/cubit_theme.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';
import 'package:mimi_shope/feature/setting/ui/widget/show_theme_bottom_sheet.dart';

Widget buildThemeTile(BuildContext context, AppColors colors) {
  final themeMode = context.watch<ThemeCubit>().state;

  return Container(
    decoration: BoxDecoration(
      color: colors.cardBackground,
      borderRadius: BorderRadius.circular(16.r),
      border: Border.all(color: colors.cardBorder),
    ),
    child: ListTile(
      onTap: () {
        showThemeBottomSheet(context);
      },
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      leading: Container(
        width: 44.w,
        height: 44.h,
        decoration: BoxDecoration(
          color: colors.searchBarBackground,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(
          Icons.dark_mode_outlined,
          color: colors.mainText,
          size: 22.sp,
        ),
      ),
      title: Text(
        'Theme',
        style: TextStyle(
          color: colors.mainText,
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        _themeLabel(themeMode),
        style: TextStyle(color: colors.subText, fontSize: 12.sp),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: colors.subText,
        size: 15.sp,
      ),
    ),
  );
}

String _themeLabel(ThemeMode mode) {
  switch (mode) {
    case ThemeMode.system:
      return 'System default';
    case ThemeMode.light:
      return 'Light';
    case ThemeMode.dark:
      return 'Dark';
  }
}
