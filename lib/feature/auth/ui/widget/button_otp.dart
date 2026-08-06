import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mimi_shope/core/routing/const_rout.dart';
import 'package:mimi_shope/core/widget/custom_button.dart';
import 'package:mimi_shope/feature/auth/logic/auth_cubit.dart';

class ButtonOtp extends StatelessWidget {
  const ButtonOtp({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return CustomButton(
      onPressed: () {
        if (cubit.otpCode.length == 6) {
          // cubit.verifyOtp(
          //   verificationId: cubit.verificationId,
          //   userOtpCode: cubit.otpCode,
          // );
          context.go(ConstRouter.home);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('enter your verify code')),
          );
        }
      },
      backgroundColor: Colors.brown,
      isRectangleBorder: true,
      radiusRectangleBorder: 12.r,
      child: Text(
        'submit',
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}
