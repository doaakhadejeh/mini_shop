import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimi_shope/feature/favorites/logic/favorites_state.dart';
import 'package:mimi_shope/feature/favorites/logic/favotites_cubit.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';
import 'package:mimi_shope/feature/home/ui/widget/coffee_card.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Favorites")),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              if (state is FavoritesLoading) {
                return Center(
                  child: CircularProgressIndicator(color: Colors.amber),
                );
              } else if (state is FavoritesSuccess) {
                final List<CoffeeItemModel> coffeeList = state.products;
                return GridView.builder(
                  itemCount: coffeeList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return CoffeeCard(item: coffeeList[index]);
                  },
                );
              } else if (state is FavoritesError) {
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
