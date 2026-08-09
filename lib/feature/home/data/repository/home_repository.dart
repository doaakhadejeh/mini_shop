import 'package:dartz/dartz.dart';
import 'package:mimi_shope/core/error/api_error_model.dart';
import 'package:mimi_shope/core/error/api_error_state.dart';
import 'package:mimi_shope/feature/home/data/model/category_model.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';
import 'package:mimi_shope/feature/home/data/service/home_service.dart';

class HomeRepository {
  final HomeService _homeService;
  HomeRepository(this._homeService);

  Future<Either<Failure, List<CategoryModel>>> getHomeData() async {
    try {
      final categoriesSnapshot = await _homeService.getCategories();
      final List<CategoryModel> categories = [];
      for (final categoryDoc in categoriesSnapshot.docs) {
        final productsSnapshot = await _homeService.getProductsByCategory(
          categoryDoc.id,
        );
        final products = productsSnapshot.docs
            .map((doc) => CoffeeItemModel.fromJson(doc.data()))
            .toList();
        categories.add(
          CategoryModel(
            id: categoryDoc.id,
            name: categoryDoc.data()['name'] as String,
            products: products,
          ),
        );
      }
      return Right(categories);
    } catch (e) {
      return Left(handleException(e));
    }
  }

  // Future<Either<Failure, List<CoffeeItemModel>>> getProductsByCategory(
  //   String categoryId,
  // ) async {
  //   try {
  //     final data = await _homeService.getProductsByCategory(categoryId);
  //     final products = data.docs
  //         .map((doc) => CoffeeItemModel.fromJson(doc.data()))
  //         .toList();
  //     return Right(products);
  //   } catch (e) {
  //     return Left(handleException(e));
  //   }
  // }
}
