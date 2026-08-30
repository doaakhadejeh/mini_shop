import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mimi_shope/core/error/api_error_model.dart';
import 'package:mimi_shope/core/error/api_error_state.dart';
import 'package:mimi_shope/feature/home/data/model/category_model.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';
import 'package:mimi_shope/feature/home/data/service/home_local_service.dart';
import 'package:mimi_shope/feature/home/data/service/home_service.dart';

class HomeRepository {
  final HomeService _homeService;
  final HomeLocalService _localService;
  final InternetConnectionChecker _connectionChecker;

  HomeRepository(
    this._homeService,
    this._localService,
    this._connectionChecker,
  );

  Future<Either<Failure, List<CategoryModel>>> getHomeData() async {
    final hasInternet = await _connectionChecker.hasConnection;

    if (hasInternet) {
      return _getRemoteHomeData();
    }

    return _getLocalHomeData();
  }

  Future<Either<Failure, List<CategoryModel>>> _getRemoteHomeData() async {
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
            product: products,
          ),
        );
      }

      await _localService.saveHomeData(categories);

      return Right(categories);
    } catch (e) {
      return Left(handleException(e));
    }
  }

  Future<Either<Failure, List<CategoryModel>>> _getLocalHomeData() async {
    try {
      final localData = await _localService.getHomeData();

      if (localData.isNotEmpty) {
        return Right(localData);
      }

      return Left(Failure('No local data available.'));
    } catch (e) {
      return Left(handleException(e));
    }
  }
}
