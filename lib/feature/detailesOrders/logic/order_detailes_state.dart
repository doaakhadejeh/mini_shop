import 'package:equatable/equatable.dart';
import 'package:mimi_shope/feature/order/data/model/order_model.dart';

abstract class OrderDetailsState extends Equatable {
  const OrderDetailsState();

  @override
  List<Object?> get props => [];
}

class OrderDetailsInitial extends OrderDetailsState {}

class OrderDetailsLoading extends OrderDetailsState {}

class OrderDetailsSuccess extends OrderDetailsState {
  final OrderModel order;

  const OrderDetailsSuccess({required this.order});

  @override
  List<Object?> get props => [order];
}

class OrderDetailsError extends OrderDetailsState {
  final String message;

  const OrderDetailsError({required this.message});

  @override
  List<Object?> get props => [message];
}
