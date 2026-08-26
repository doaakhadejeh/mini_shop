import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';

class TopDetailesCoffee extends StatelessWidget {
  final CoffeeItemModel item;
  const TopDetailesCoffee({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 240.h,
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Image.network(
              item.image!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.local_cafe,
                  color: Colors.grey,
                  size: 60,
                );
              },
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          item.name,
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6.h),
        Text(
          item.subtitle,
          style: TextStyle(color: Colors.grey, fontSize: 14.sp),
        ),
      ],
    );
  }
}
