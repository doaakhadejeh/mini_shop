import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mimi_shope/core/routing/const_rout.dart';
import 'package:mimi_shope/core/widget/custom_button.dart';
import 'package:mimi_shope/feature/auth/logic/auth_cubit.dart';

class ButtomLoginEmail extends StatelessWidget {
  const ButtomLoginEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CustomButton(
            isRectangleBorder: true,
            radiusRectangleBorder: 10.sp,
            onPressed: () {
              if (context
                  .read<AuthCubit>()
                  .loginFormKey
                  .currentState!
                  .validate()) {
                context.read<AuthCubit>().loginWithEmail();
              }
            },
            child: Text(
              "Login",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(height: 20.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
            GestureDetector(
              onTap: () {
                context.push(ConstRouter.register);
              },
              child: Text(
                "Register",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "OR ",
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
            IconButton(
              onPressed: () {
                context.push(ConstRouter.init);
              },
              icon: Icon(Icons.phone, color: Colors.brown),
            ),
          ],
        ),
      ],
    );
  }
}
