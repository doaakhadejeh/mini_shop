import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:mimi_shope/core/error/api_error_model.dart';
import 'package:mimi_shope/core/error/api_error_state.dart';
import 'package:mimi_shope/feature/favorites/data/service/favorites_local_service.dart';
import 'package:mimi_shope/feature/favorites/data/service/favorites_service.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';

class FavoritesRepository {
  final FavoritesService _favoritesService;
  final FavoritesLocalService _localService;
  final InternetConnectionChecker _connectionChecker;

  FavoritesRepository(
    this._favoritesService,
    this._localService,
    this._connectionChecker,
  );

  Future<Either<Failure, void>> addToFavorites({
    required String userId,
    required CoffeeItemModel product,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(Failure('No internet connection'));
    }

    try {
      await _favoritesService.addToFavorites(
        userId: userId,
        productId: product.id,
      );

      await _localService.addToFavorites(userId: userId, product: product);

      return const Right(null);
    } catch (e) {
      return Left(handleException(e));
    }
  }

  Future<Either<Failure, void>> removeFromFavorites({
    required String userId,
    required int productId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(Failure('No internet connection'));
    }

    try {
      await _favoritesService.removeFromFavorites(
        userId: userId,
        productId: productId,
      );

      await _localService.removeFromFavorites(
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
    final hasInternet = await _connectionChecker.hasConnection;

    if (hasInternet) {
      return _isFavoriteRemote(userId: userId, productId: productId);
    }

    return _isFavoriteLocal(userId: userId, productId: productId);
  }

  Future<Either<Failure, bool>> _isFavoriteRemote({
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

  Future<Either<Failure, bool>> _isFavoriteLocal({
    required String userId,
    required int productId,
  }) async {
    try {
      final result = await _localService.isFavorite(
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
    final hasInternet = await _connectionChecker.hasConnection;

    if (hasInternet) {
      return _getRemoteFavoriteProducts(userId);
    }

    return _getLocalFavoriteProducts(userId);
  }

  Future<Either<Failure, List<CoffeeItemModel>>> _getRemoteFavoriteProducts(
    String userId,
  ) async {
    try {
      final remoteProducts = await _favoritesService.getFavoriteProducts(
        userId: userId,
      );

      await _localService.saveFavoriteProducts(
        userId: userId,
        products: remoteProducts,
      );

      return Right(remoteProducts);
    } catch (e) {
      return Left(handleException(e));
    }
  }

  Future<Either<Failure, List<CoffeeItemModel>>> _getLocalFavoriteProducts(
    String userId,
  ) async {
    try {
      final localProducts = await _localService.getFavoriteProducts(
        userId: userId,
      );

      return Right(localProducts);
    } catch (e) {
      return Left(handleException(e));
    }
  }
}
