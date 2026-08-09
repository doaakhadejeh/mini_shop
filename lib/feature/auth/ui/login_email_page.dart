import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimi_shope/feature/auth/ui/widget/auth_listener.dart';
import 'package:mimi_shope/feature/auth/ui/widget/buttom_login_email.dart';
import 'package:mimi_shope/feature/auth/ui/widget/field_login_email.dart';
import 'package:mimi_shope/feature/auth/ui/widget/top_login_email.dart';

class LoginEmailPage extends StatelessWidget {
  const LoginEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SizedBox(height: 30.h),

              TopLoginEmail(),
              SizedBox(height: 30.h),

              FieldLoginEmail(),
              SizedBox(height: 40.h),

              ButtomLoginEmail(),
              AuthListener(),
            ],
          ),
        ),
      ),
    );
  }
}
