import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mimi_shope/core/helper/shared_pref.dart';
import 'package:mimi_shope/core/routing/const_rout.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';
import 'package:mimi_shope/feature/auth/logic/auth_cubit.dart';
import 'package:mimi_shope/feature/setting/ui/widget/build_section_title.dart';
import 'package:mimi_shope/feature/setting/ui/widget/build_setting_tile.dart';
import 'package:mimi_shope/feature/setting/ui/widget/build_theme_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    goToInit() => context.go(ConstRouter.init);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            color: colors.mainText,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        children: [
          buildSectionTitle(context, 'Account', colors),

          buildSettingTile(
            context: context,
            colors: colors,
            icon: Icons.lock_outline,
            title: 'Change Password',
            subtitle: 'Update your password',
            onTap: () {
              context.push(ConstRouter.changePassword);
            },
          ),

          SizedBox(height: 8.h),

          buildSettingTile(
            context: context,
            colors: colors,
            icon: Icons.logout_rounded,
            title: 'Logout',
            subtitle: 'Sign out from your account',
            onTap: () async {
              await context.read<AuthCubit>().logout();
              await SharedPrefHelper.clearAllData();
              await SharedPrefHelper.clearAllSecuredData();
              goToInit();
            },
            isDestructive: true,
          ),

          SizedBox(height: 28.h),

          buildSectionTitle(context, 'Preferences', colors),

          buildThemeTile(context, colors),

          SizedBox(height: 28.h),

          buildSectionTitle(context, 'More', colors),

          buildSettingTile(
            context: context,
            colors: colors,
            icon: Icons.info_outline_rounded,
            title: 'About',
            subtitle: 'About us',
            onTap: () {
              context.push(ConstRouter.aboutUs);
            },
          ),

          SizedBox(height: 30.h),

          Center(
            child: Text(
              'coffee Shop',
              style: TextStyle(color: colors.subText, fontSize: 13.sp),
            ),
          ),
        ],
      ),
    );
  }
}
