import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mimi_shope/core/routing/const_rout.dart';
import 'package:mimi_shope/core/widget/custom_button.dart';
import 'package:mimi_shope/feature/auth/logic/auth_cubit.dart';

class ButtonLoginPage extends StatelessWidget {
  final TextEditingController phone;
  final String countryCode;
  const ButtonLoginPage({
    super.key,
    required this.phone,
    required this.countryCode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          isRectangleBorder: true,
          radiusRectangleBorder: 10.sp,
          onPressed: () {
            if (context
                .read<AuthCubit>()
                .phoneFormKey
                .currentState!
                .validate()) {
              context.read<AuthCubit>().sendOtp(
                "$countryCode${phone.text.replaceFirst(RegExp(r'^0'), '')}",
              );
            }
          },
          child: Text(
            "Login",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
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
                context.push(ConstRouter.loginEmail);
              },
              icon: Icon(Icons.email, color: Colors.brown),
            ),
          ],
        ),
      ],
    );
  }
}
