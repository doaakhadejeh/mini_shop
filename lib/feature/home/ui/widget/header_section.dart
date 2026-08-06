import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              'Location',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12.sp),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Damascus, Syria',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFFC67C4E),
                ),
              ],
            ),
          ],
        ),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            image: const DecorationImage(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&q=80',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
