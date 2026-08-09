import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimi_shope/feature/home/data/model/category_model.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';
import 'package:mimi_shope/feature/home/data/repository/home_repository.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _repository;

  HomeCubit(this._repository) : super(HomeInitial());

  List<CategoryModel> _categories = [];
  List<CoffeeItemModel> _allProducts = [];
  int selectedCategoryIndex = 0;

  void selectCategory(String? categoryId) {
    if (categoryId == null) {
      selectedCategoryIndex = 0;
      emit(HomeSuccess(categories: _categories, products: _allProducts));
      return;
    }
    final index = _categories.indexWhere(
      (category) => category.id == categoryId,
    );
    if (index == -1) {
      return;
    }
    selectedCategoryIndex = index;
    final category = _categories[index];
    emit(HomeSuccess(categories: _categories, products: category.products));
  }

  Future<void> loadHome() async {
    emit(HomeLoading());

    final result = await _repository.getHomeData();

    result.fold(
      (failure) {
        emit(HomeError(failure.message));
      },
      (categories) {
        _categories = categories;

        _allProducts = categories
            .expand((category) => category.products)
            .toList();

        emit(HomeSuccess(categories: _categories, products: _allProducts));
      },
    );
  }
}
