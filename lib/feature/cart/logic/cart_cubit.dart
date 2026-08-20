import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimi_shope/core/helper/shared_pref.dart';
import 'package:mimi_shope/feature/cart/data/model/cart_model.dart';
import 'package:mimi_shope/feature/cart/data/repository/cart_repository.dart';
import 'package:mimi_shope/feature/cart/logic/cart_state.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository _cartRepository;
  final Future<String?> Function()? getUserId;

  CartCubit(this._cartRepository, {this.getUserId}) : super(CartInitial());

  Future<String?> _getUserId() {
    if (getUserId != null) {
      return getUserId!();
    }

    return SharedPrefHelper.getSecuredString("userId");
  }

  Future<void> getCartItems() async {
    emit(CartLoading());

    final userId = await _getUserId();

    if (userId == null) {
      emit(CartError('User not found'));
      return;
    }

    final result = await _cartRepository.getCartItems(userId: userId);

    result.fold(
      (failure) {
        emit(CartError(failure.message));
      },
      (items) {
        emit(CartSuccess(items: items));
      },
    );
  }

  Future<void> addToCart({
    required CoffeeItemModel product,
    int quantity = 1,
  }) async {
    final userId = await _getUserId();

    if (userId == null) {
      emit(CartError('User not found'));
      return;
    }

    final result = await _cartRepository.addToCart(
      userId: userId,
      product: product,
      quantity: quantity,
    );

    result.fold(
      (failure) {
        emit(CartError(failure.message));
      },
      (_) {
        _addOrUpdateLocalCart(product, quantity);
      },
    );
  }

  Future<void> increaseQuantity({required int productId}) async {
    final currentState = state;

    if (currentState is! CartSuccess) {
      return;
    }

    final item = currentState.items.firstWhere(
      (item) => item.product.id == productId,
    );

    await _updateQuantity(
      productId: productId,
      quantity: item.quantity + 1,
      currentItems: currentState.items,
    );
  }

  Future<void> decreaseQuantity({required int productId}) async {
    final currentState = state;

    if (currentState is! CartSuccess) {
      return;
    }

    final item = currentState.items.firstWhere(
      (item) => item.product.id == productId,
    );

    await _updateQuantity(
      productId: productId,
      quantity: item.quantity - 1,
      currentItems: currentState.items,
    );
  }

  Future<void> _updateQuantity({
    required int productId,
    required int quantity,
    required List<CartItemModel> currentItems,
  }) async {
    final userId = await _getUserId();

    if (userId == null) {
      emit(CartError('User not found'));
      return;
    }

    final result = await _cartRepository.updateQuantity(
      userId: userId,
      productId: productId,
      quantity: quantity,
    );

    result.fold(
      (failure) {
        emit(CartError(failure.message));
      },
      (_) {
        if (quantity <= 0) {
          emit(
            CartSuccess(
              items: currentItems
                  .where((item) => item.product.id != productId)
                  .toList(),
            ),
          );
        } else {
          emit(
            CartSuccess(
              items: currentItems.map((item) {
                if (item.product.id == productId) {
                  return item.copyWith(quantity: quantity);
                }

                return item;
              }).toList(),
            ),
          );
        }
      },
    );
  }

  Future<void> removeFromCart({required int productId}) async {
    final currentState = state;

    if (currentState is! CartSuccess) {
      return;
    }

    final userId = await _getUserId();

    if (userId == null) {
      emit(CartError('User not found'));
      return;
    }

    final result = await _cartRepository.removeFromCart(
      userId: userId,
      productId: productId,
    );

    result.fold(
      (failure) {
        emit(CartError(failure.message));
      },
      (_) {
        emit(
          CartSuccess(
            items: currentState.items
                .where((item) => item.product.id != productId)
                .toList(),
          ),
        );
      },
    );
  }

  void _addOrUpdateLocalCart(CoffeeItemModel product, int amountToAdd) {
    if (state is! CartSuccess) return;

    final currentState = state as CartSuccess;

    final existingIndex = currentState.items.indexWhere(
      (item) => item.product.id == product.id,
    );

    final List<CartItemModel> updatedItems = List.from(currentState.items);

    if (existingIndex != -1) {
      final existingItem = updatedItems[existingIndex];
      updatedItems[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + amountToAdd,
      );
    } else {
      updatedItems.add(CartItemModel(product: product, quantity: amountToAdd));
    }

    emit(CartSuccess(items: updatedItems));
  }
}
