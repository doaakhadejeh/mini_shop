import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimi_shope/feature/auth/ui/widget/auth_listener.dart';
import 'package:mimi_shope/feature/auth/ui/widget/button_otp.dart';
import 'package:mimi_shope/feature/auth/ui/widget/otp_field.dart';
import 'package:mimi_shope/feature/auth/ui/widget/resend_code.dart';
import 'package:mimi_shope/feature/auth/ui/widget/top_otp.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('verify code'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30.h),
              TopOtp(),
              SizedBox(height: 40.h),
              OtpField(),
              SizedBox(height: 40.h),
              ButtonOtp(),
              SizedBox(height: 20.h),
              ResendCode(),
              AuthListener(),
            ],
          ),
        ),
      ),
    );
  }
}
