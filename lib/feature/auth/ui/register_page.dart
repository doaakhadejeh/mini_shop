import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimi_shope/feature/auth/ui/widget/auth_listener.dart';
import 'package:mimi_shope/feature/auth/ui/widget/buttom_register.dart';
import 'package:mimi_shope/feature/auth/ui/widget/field_register.dart';
import 'package:mimi_shope/feature/auth/ui/widget/top_register.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
              SizedBox(height: 20.h),

              TopRegister(),
              SizedBox(height: 24.h),

              FieldRegister(),
              SizedBox(height: 35.h),
              ButtomRegister(),
              AuthListener(),
            ],
          ),
        ),
      ),
    );
  }
}
