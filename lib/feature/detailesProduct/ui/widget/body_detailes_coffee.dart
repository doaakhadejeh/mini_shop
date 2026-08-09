import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimi_shope/feature/detailesProduct/ui/logic/detailes_product_cubit.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';

class BodyDetailesCoffee extends StatelessWidget {
  final CoffeeItemModel item;

  const BodyDetailesCoffee({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DetailesProductCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 20.sp),
            SizedBox(width: 6.w),
            Text(
              '${item.rating}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.white.withAlpha(30)),
          ),
          child: Row(
            children: [
              InkWell(
                key: Key("remove"),
                onTap: () {
                  cubit.decrementQuantity();
                },
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(Icons.remove, color: Colors.white, size: 14.w),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Text(
                  '${cubit.quantity}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              InkWell(
                key: Key("add"),
                onTap: () {
                  cubit.incrementQuantity();
                },
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC67C4E),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 14.w),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
