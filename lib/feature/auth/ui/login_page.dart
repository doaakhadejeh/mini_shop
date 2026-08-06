import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimi_shope/feature/auth/ui/widget/auth_listener.dart';
import 'package:mimi_shope/feature/auth/ui/widget/field_login_page.dart';
import 'package:mimi_shope/feature/auth/ui/widget/top_login_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: 10.h,
            bottom: 3.h,
            right: 16.w,
            left: 16.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              TopLoginPage(),
              SizedBox(height: 60.h),
              FieldLoginPage(),
              AuthListener(),
            ],
          ),
        ),
      ),
    );
  }
}
