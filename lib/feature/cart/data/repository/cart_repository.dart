import 'package:dartz/dartz.dart';
import 'package:mimi_shope/core/error/api_error_model.dart';
import 'package:mimi_shope/core/error/api_error_state.dart';
import 'package:mimi_shope/feature/cart/data/model/cart_model.dart';
import 'package:mimi_shope/feature/cart/data/service/cart_service.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';

class CartRepository {
  final CartService _cartService;

  CartRepository(this._cartService);

  Future<Either<Failure, void>> addToCart({
    required String userId,
    required CoffeeItemModel product,
    int quantity = 1,
  }) async {
    try {
      await _cartService.addToCart(
        userId: userId,
        product: product,
        quantity: quantity,
      );

      return const Right(null);
    } catch (e) {
      return Left(handleException(e));
    }
  }

  Future<Either<Failure, void>> updateQuantity({
    required String userId,
    required int productId,
    required int quantity,
  }) async {
    try {
      await _cartService.updateQuantity(
        userId: userId,
        productId: productId,
        quantity: quantity,
      );

      return const Right(null);
    } catch (e) {
      return Left(handleException(e));
    }
  }

  Future<Either<Failure, void>> removeFromCart({
    required String userId,
    required int productId,
  }) async {
    try {
      await _cartService.removeFromCart(userId: userId, productId: productId);

      return const Right(null);
    } catch (e) {
      return Left(handleException(e));
    }
  }

  Future<Either<Failure, List<CartItemModel>>> getCartItems({
    required String userId,
  }) async {
    try {
      final items = await _cartService.getCartItems(userId: userId);

      return Right(items);
    } catch (e) {
      return Left(handleException(e));
    }
  }
}
