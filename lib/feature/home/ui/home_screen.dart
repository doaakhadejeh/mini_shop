import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimi_shope/core/di/dependency_injection.dart';
import 'package:mimi_shope/feature/cart/logic/cart_cubit.dart';
import 'package:mimi_shope/feature/cart/ui/cart.dart';
import 'package:mimi_shope/feature/favorites/logic/favorites_cubit.dart';
import 'package:mimi_shope/feature/favorites/ui/favorites.dart';
import 'package:mimi_shope/feature/home/logic/home_cubit.dart';
import 'package:mimi_shope/feature/home/ui/my_home_page.dart';
import 'package:mimi_shope/feature/home/ui/widget/custom_bottom_nav_bar.dart';
import 'package:mimi_shope/feature/order/logic/order_cubit.dart';
import 'package:mimi_shope/feature/order/ui/order_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final myList = [
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<HomeCubit>()..loadHome()),
        BlocProvider(
          create: (context) => getIt<FavoritesCubit>()..getFavoriteProducts(),
        ),
      ],
      child: const MyHomePage(),
    ),

    BlocProvider(
      create: (context) => getIt<FavoritesCubit>()..getFavoriteProducts(),
      child: Favorites(),
    ),
    BlocProvider(
      create: (context) => getIt<CartCubit>()..getCartItems(),
      child: const CartScreen(),
    ),
    BlocProvider(
      create: (context) => getIt<OrdersCubit>()..getOrders(),
      child: const OrdersPage(),
    ),
  ];
  int _currentBottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentBottomNavIndex,
        onTap: (index) {
          setState(() {
            _currentBottomNavIndex = index;
          });
        },
      ),
      body: myList[_currentBottomNavIndex],
    );
  }
}
