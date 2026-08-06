import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimi_shope/feature/home/ui/widget/category_selector.dart';
import 'package:mimi_shope/feature/home/ui/widget/coffee_card.dart';
import 'package:mimi_shope/feature/home/ui/widget/header_section.dart';
import 'package:mimi_shope/feature/home/ui/widget/promo_banner_section.dart';
import 'package:mimi_shope/feature/home/ui/widget/search_bar_section.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedCategoryIndex = 0;

  final List<String> _categories = [
    'All Coffee',
    'Machiato',
    'Latte',
    'Americano',
    'Capuchino',
  ];

  final List<CoffeeItem> _coffeeList = const [
    CoffeeItem(
      name: 'Caffe Mocha',
      subtitle: 'Deep Foam & Cocoa',
      price: 4.53,
      rating: 4.8,
      imageUrl:
          'https://images.unsplash.com/photo-1578314675249-a6910f80cc4e?w=500&q=80',
    ),
    CoffeeItem(
      name: 'Flat White',
      subtitle: 'Espresso & Steamed Milk',
      price: 3.90,
      rating: 4.7,
      imageUrl:
          'https://images.unsplash.com/photo-1534778101976-62847782c213?w=500&q=80',
    ),
    CoffeeItem(
      name: 'Caramel Macchiato',
      subtitle: 'Rich Caramel Drizzle',
      price: 5.20,
      rating: 4.9,
      imageUrl:
          'https://images.unsplash.com/photo-1485808191679-5f86510681a2?w=500&q=80',
    ),
    CoffeeItem(
      name: 'Iced Latte',
      subtitle: 'Cold Brew & Whole Milk',
      price: 4.10,
      rating: 4.6,
      imageUrl:
          'https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=500&q=80',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                // Header
                const HeaderSection(),
                const SizedBox(height: 24),

                // Search Bar
                const SearchBarSection(),
                const SizedBox(height: 24),

                // Promo Banner
                const PromoBannerSection(),
                const SizedBox(height: 24),

                // Category Selector
                CategorySelector(
                  categories: _categories,
                  selectedIndex: _selectedCategoryIndex,
                  onCategorySelected: (index) {
                    setState(() {
                      _selectedCategoryIndex = index;
                    });
                  },
                ),
                const SizedBox(height: 20),

                // Coffee Grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _coffeeList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.68,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    return CoffeeCard(item: _coffeeList[index]);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CoffeeItem {
  final String name;
  final String subtitle;
  final double price;
  final double rating;
  final String imageUrl;

  const CoffeeItem({
    required this.name,
    required this.subtitle,
    required this.price,
    required this.rating,
    required this.imageUrl,
  });
}
