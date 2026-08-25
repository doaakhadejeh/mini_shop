import 'package:equatable/equatable.dart';
import 'package:mimi_shope/feature/order/data/model/order_item_model.dart';

class OrderModel extends Equatable {
  final String id;
  final String userId;
  final List<OrderItemModel> items;
  final double totalPrice;
  final String deliveryAddress;
  final String paymentMethod;
  final String paymentStatus;
  final String orderStatus;
  final DateTime createdAt;

  const OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalPrice,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.orderStatus,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    items,
    totalPrice,
    deliveryAddress,
    paymentMethod,
    paymentStatus,
    orderStatus,
    createdAt,
  ];
}
