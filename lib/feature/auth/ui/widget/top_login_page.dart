import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopLoginPage extends StatelessWidget {
  const TopLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Center(child: Icon(Icons.coffee, size: 60.sp)),
        SizedBox(height: 30.h),
        Text(
          "Login by your phone number:",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
