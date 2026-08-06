import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopOtp extends StatelessWidget {
  const TopOtp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .start,
      children: [
        Icon(Icons.mark_email_read_outlined, size: 80.r, color: Colors.brown),

        SizedBox(height: 24.h),

        Text(
          ' verify code',
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 8.h),

        Text(
          'we send your verify code , contains 4 numbers',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
