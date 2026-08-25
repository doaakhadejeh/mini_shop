import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimi_shope/core/helper/shared_pref.dart';
import 'package:mimi_shope/feature/favorites/data/repository/favorites_repository.dart';
import 'package:mimi_shope/feature/favorites/logic/favorites_state.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository _favoritesRepository;
  final Future<String?> Function()? getUserId;

  FavoritesCubit(this._favoritesRepository, {this.getUserId})
    : super(FavoritesInitial());

  Future<String?> _getUserId() {
    if (getUserId != null) {
      return getUserId!();
    }

    return SharedPrefHelper.getSecuredString("userId");
  }

  bool isFavorite({required CoffeeItemModel product}) {
    final currentState = state;

    if (currentState is FavoritesSuccess) {
      return currentState.products.any((item) => item.id == product.id);
    }

    return false;
  }

  Future<void> toggleFavorite({required CoffeeItemModel product}) async {
    final currentState = state;
    final userId = await _getUserId();

    if (userId == null) {
      emit(FavoritesError('Please log in to continue.'));
      return;
    }

    if (currentState is FavoritesSuccess) {
      final isFavorite = currentState.products.any(
        (item) => item.id == product.id,
      );

      if (isFavorite) {
        await _removeFavorite(
          userId: userId,
          productId: product.id,
          currentProducts: currentState.products,
        );
      } else {
        await _addFavorite(
          userId: userId,
          product: product,
          currentProducts: currentState.products,
        );
      }
    }
  }

  Future<void> _addFavorite({
    required String userId,
    required CoffeeItemModel product,
    required List<CoffeeItemModel> currentProducts,
  }) async {
    final result = await _favoritesRepository.addToFavorites(
      userId: userId,
      productId: product.id,
    );

    result.fold((failure) => emit(FavoritesError(failure.message)), (_) {
      emit(FavoritesSuccess(products: [...currentProducts, product]));
    });
  }

  Future<void> _removeFavorite({
    required String userId,
    required int productId,
    required List<CoffeeItemModel> currentProducts,
  }) async {
    final result = await _favoritesRepository.removeFromFavorites(
      userId: userId,
      productId: productId,
    );

    result.fold((failure) => emit(FavoritesError(failure.message)), (_) {
      emit(
        FavoritesSuccess(
          products: currentProducts
              .where((item) => item.id != productId)
              .toList(),
        ),
      );
    });
  }

  Future<void> getFavoriteProducts() async {
    emit(FavoritesLoading());
    final userId = await _getUserId();

    if (userId == null) {
      emit(FavoritesError('Please log in to continue.'));
      return;
    }

    final result = await _favoritesRepository.getFavoriteProducts(
      userId: userId,
    );

    result.fold(
      (failure) {
        emit(FavoritesError(failure.message));
      },
      (succsee) {
        emit(FavoritesSuccess(products: succsee));
      },
    );
  }
}
