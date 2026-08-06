import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimi_shope/feature/auth/logic/auth_cubit.dart';

class ResendCode extends StatelessWidget {
  const ResendCode({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'the verify code isnot send?',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
        ),
        GestureDetector(
          onTap: () {
            context.read<AuthCubit>().sendOtp(
              cubit.selectedCountryCode + cubit.phone.text,
            );
          },
          child: Text(
            'resend verify code',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
        ),
      ],
    );
  }
}
