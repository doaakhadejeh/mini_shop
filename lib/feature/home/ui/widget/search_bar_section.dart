import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';

class SearchBarSection extends StatelessWidget {
  const SearchBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 52.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: appColors.searchBarBackground,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: appColors.subText),
                SizedBox(width: 12.w),
                Expanded(
                  child: TextField(
                    style: TextStyle(color: appColors.mainText),
                    decoration: InputDecoration(
                      hintText: 'Search coffee...',
                      hintStyle: TextStyle(
                        color: appColors.subText,
                        fontSize: 14.sp,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Container(
          width: 52.w,
          height: 52.h,
          decoration: BoxDecoration(
            color: const Color(0xFFC67C4E),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: const Icon(Icons.tune_rounded, color: Colors.white),
        ),
      ],
    );
  }
}
