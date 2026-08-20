import 'package:equatable/equatable.dart';
import 'package:mimi_shope/feature/cart/data/model/cart_model.dart';

sealed class CartState extends Equatable {}

final class CartInitial extends CartState {
  @override
  List<Object?> get props => [];
}

final class CartLoading extends CartState {
  @override
  List<Object?> get props => [];
}

final class CartSuccess extends CartState {
  final List<CartItemModel> items;

  CartSuccess({required this.items});

  @override
  List<Object?> get props => [items];
}

final class CartError extends CartState {
  final String message;

  CartError(this.message);

  @override
  List<Object?> get props => [message];
}
