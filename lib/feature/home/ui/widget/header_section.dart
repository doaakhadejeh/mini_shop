import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 7.h),
          child: Text(
            'Coffee Shop',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
        ),
        // Column(
        //   crossAxisAlignment: .start,
        //   children: [
        //     Text(
        //       'Location',
        //       style: TextStyle(color: Colors.grey.shade600, fontSize: 12.sp),
        //     ),
        //     SizedBox(height: 4),
        //     Row(
        //       children: [
        //         Text(
        //           'Damascus, Syria',
        //           style: TextStyle(
        //             fontSize: 16.sp,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //         Icon(
        //           Icons.keyboard_arrow_down_rounded,
        //           color: Color(0xFFC67C4E),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
        Container(
          width: 44.w,
          height: 44.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),

            // image: const DecorationImage(
            //   image: NetworkImage(
            //     'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&q=80',
            //   ),
            //   fit: BoxFit.cover,
            // ),
            color: Colors.grey,
          ),
          child: Icon(Icons.person),
        ),
      ],
    );
  }
}
