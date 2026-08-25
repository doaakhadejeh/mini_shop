import 'package:equatable/equatable.dart';

class OrderItemModel extends Equatable {
  final int productId;
  final String productName;
  final double price;
  final int quantity;

  const OrderItemModel({
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
  });

  double get totalPrice => price * quantity;

  @override
  List<Object?> get props => [productId, productName, price, quantity];
}
