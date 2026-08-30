import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimi_shope/feature/detailesProduct/ui/widget/body_detailes_coffee.dart';
import 'package:mimi_shope/feature/detailesProduct/ui/widget/buttom_detailes_coffee.dart';
import 'package:mimi_shope/feature/detailesProduct/ui/widget/top_detailes_coffee.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';

class CoffeeDetailsScreen extends StatelessWidget {
  final CoffeeItemModel item;

  const CoffeeDetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TopDetailesCoffee(item: item),
                      SizedBox(height: 20.h),
                      BodyDetailesCoffee(item: item),
                    ],
                  ),
                ),
              ),

              BottomDetailsCoffee(product: item),
            ],
          ),
        ),
      ),
    );
  }
}
