import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopRegister extends StatelessWidget {
  const TopRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: Icon(Icons.coffee, size: 60.sp)),
        SizedBox(height: 20.h),
        Text(
          "Create New Account:",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
