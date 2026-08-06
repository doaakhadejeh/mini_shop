import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimi_shope/feature/auth/logic/auth_cubit.dart';

class OtpField extends StatelessWidget {
  const OtpField({super.key});

  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      numberOfFields: 6,
      borderColor: Colors.brown,
      focusedBorderColor: Colors.brown,
      showFieldAsBox: true,
      fieldWidth: 40.w,
      borderRadius: BorderRadius.circular(12.r),
      textStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
      onCodeChanged: (String code) {},
      onSubmit: (code) {
        context.read<AuthCubit>().otpCode = code;
      },
    );
  }
}
