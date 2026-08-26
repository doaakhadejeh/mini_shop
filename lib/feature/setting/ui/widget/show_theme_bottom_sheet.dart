import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimi_shope/core/theme/cubit/cubit_theme.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';
import 'package:mimi_shope/feature/setting/ui/widget/build_theme_option.dart';

void showThemeBottomSheet(BuildContext context) {
  final currentTheme = context.read<ThemeCubit>().state;

  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
    ),
    builder: (sheetContext) {
      return Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Theme',
              style: TextStyle(
                color: Theme.of(context).extension<AppColors>()!.mainText,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 15.h),

            RadioGroup<ThemeMode>(
              groupValue: currentTheme,
              onChanged: (value) async {
                if (value == null) return;

                await context.read<ThemeCubit>().changeTheme(value);

                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: Column(
                children: [
                  buildThemeOption(
                    context: context,
                    title: 'System default',
                    subtitle: 'Follow your device theme',
                    icon: Icons.settings_suggest_outlined,
                    mode: ThemeMode.system,
                    onTap: () {
                      context
                          .read<ThemeCubit>()
                          .changeTheme(ThemeMode.system)
                          .then((_) {
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          });
                    },
                  ),

                  buildThemeOption(
                    context: context,
                    title: 'Light',
                    subtitle: 'Always use light theme',
                    icon: Icons.light_mode_outlined,
                    mode: ThemeMode.light,
                    onTap: () {
                      context
                          .read<ThemeCubit>()
                          .changeTheme(ThemeMode.light)
                          .then((_) {
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          });
                    },
                  ),

                  buildThemeOption(
                    context: context,
                    title: 'Dark',
                    subtitle: 'Always use dark theme',
                    icon: Icons.dark_mode_outlined,
                    mode: ThemeMode.dark,
                    onTap: () {
                      context
                          .read<ThemeCubit>()
                          .changeTheme(ThemeMode.dark)
                          .then((_) {
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          });
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h),
          ],
        ),
      );
    },
  );
}
