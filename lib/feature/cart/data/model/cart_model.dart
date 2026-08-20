import 'package:equatable/equatable.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';

class CartItemModel extends Equatable {
  final CoffeeItemModel product;
  final int quantity;

  const CartItemModel({required this.product, required this.quantity});

  double get totalPrice => product.price * quantity;

  CartItemModel copyWith({CoffeeItemModel? product, int? quantity}) {
    return CartItemModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [product, quantity];
}
