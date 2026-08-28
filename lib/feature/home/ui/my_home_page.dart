import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimi_shope/feature/home/data/model/category_model.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';
import 'package:mimi_shope/feature/home/logic/home_cubit.dart';
import 'package:mimi_shope/feature/home/logic/home_state.dart';
import 'package:mimi_shope/feature/home/ui/widget/category_selector.dart';
import 'package:mimi_shope/feature/home/ui/widget/coffee_card.dart';
import 'package:mimi_shope/feature/home/ui/widget/header_section.dart';
import 'package:mimi_shope/feature/home/ui/widget/promo_banner_section.dart';
import 'package:mimi_shope/feature/home/ui/widget/search_bar_section.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 16.0.h),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return Center(
                  child: CircularProgressIndicator(color: Colors.amber),
                );
              }
              if (state is HomeSearch) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeaderSection(),
                    SizedBox(height: 24.h),
                    const SearchBarSection(),

                    SizedBox(height: 20.h),

                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.5,
                        crossAxisSpacing: 16.w,
                        mainAxisSpacing: 16.h,
                      ),
                      itemBuilder: (context, index) {
                        return CoffeeCard(item: state.products[index]);
                      },
                    ),
                  ],
                );
              } else if (state is HomeSuccess) {
                final List<CategoryModel> categories = state.categories;
                final List<CoffeeItemModel> coffeeList = state.products;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeaderSection(),
                    SizedBox(height: 15.h),
                    const SearchBarSection(),
                    SizedBox(height: 20.h),
                    const PromoBannerSection(),
                    SizedBox(height: 24.h),
                    CategorySelector(
                      categories: categories,
                      selectedIndex: context
                          .read<HomeCubit>()
                          .selectedCategoryIndex,
                      onCategorySelected: (index) {
                        if (index == 0) {
                          context.read<HomeCubit>().selectCategory(null);
                          return;
                        }

                        final categoryId = categories[index - 1].id;

                        context.read<HomeCubit>().selectCategory(categoryId);
                      },
                    ),
                    SizedBox(height: 20.h),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: coffeeList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.68,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16.sp,
                      ),
                      itemBuilder: (context, index) {
                        return CoffeeCard(item: coffeeList[index]);
                      },
                    ),
                  ],
                );
              } else if (state is HomeError) {
                return Center(
                  child: Column(
                    children: [
                      Text(state.message),
                      const Icon(Icons.error, color: Colors.red),
                    ],
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
