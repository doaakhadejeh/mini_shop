import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mimi_shope/core/routing/const_rout.dart';
import 'package:mimi_shope/core/widget/custom_button.dart';
import 'package:mimi_shope/feature/auth/logic/auth_cubit.dart';

class ButtomRegister extends StatelessWidget {
  const ButtomRegister({super.key});

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
                  .registerFormKey
                  .currentState!
                  .validate()) {
                context.read<AuthCubit>().registerWithEmail();
              }
            },
            child: Text(
              "Register",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(height: 20.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account? ",
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
            GestureDetector(
              onTap: () {
                context.push(ConstRouter.loginEmail);
              },
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
