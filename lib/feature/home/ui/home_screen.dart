import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimi_shope/core/di/dependency_injection.dart';
import 'package:mimi_shope/feature/home/logic/home_cubit.dart';
import 'package:mimi_shope/feature/home/ui/my_home_page.dart';
import 'package:mimi_shope/feature/home/ui/widget/custom_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final myList = [
    BlocProvider(
      create: (context) => getIt<HomeCubit>()..loadHome(),
      child: const MyHomePage(),
    ),
    Container(),
    Container(),
    Container(),
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
