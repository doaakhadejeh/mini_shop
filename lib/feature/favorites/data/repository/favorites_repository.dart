import 'package:dartz/dartz.dart';
import 'package:mimi_shope/core/error/api_error_model.dart';
import 'package:mimi_shope/core/error/api_error_state.dart';
import 'package:mimi_shope/feature/favorites/data/service/favorites_service.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';

class FavoritesRepository {
  final FavoritesService _favoritesService;

  FavoritesRepository(this._favoritesService);

  Future<Either<Failure, void>> addToFavorites({
    required String userId,
    required int productId,
  }) async {
    try {
      await _favoritesService.addToFavorites(
        userId: userId,
        productId: productId,
      );

      return const Right(null);
    } catch (e) {
      return Left(handleException(e));
    }
  }

  Future<Either<Failure, void>> removeFromFavorites({
    required String userId,
    required int productId,
  }) async {
    try {
      await _favoritesService.removeFromFavorites(
        userId: userId,
        productId: productId,
      );

      return const Right(null);
    } catch (e) {
      return Left(handleException(e));
    }
  }

  Future<Either<Failure, bool>> isFavorite({
    required String userId,
    required int productId,
  }) async {
    try {
      final result = await _favoritesService.isFavorite(
        userId: userId,
        productId: productId,
      );

      return Right(result);
    } catch (e) {
      return Left(handleException(e));
    }
  }

  Future<Either<Failure, List<CoffeeItemModel>>> getFavoriteProducts({
    required String userId,
  }) async {
    try {
      final products = await _favoritesService.getFavoriteProducts(
        userId: userId,
      );

      return Right(products);
    } catch (e) {
      return Left(handleException(e));
    }
  }
}
