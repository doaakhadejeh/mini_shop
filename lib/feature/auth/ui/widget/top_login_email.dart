import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopLoginEmail extends StatelessWidget {
  const TopLoginEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: Icon(Icons.coffee, size: 60.sp)),
        SizedBox(height: 30.h),
        Text(
          "Login with Email:",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
