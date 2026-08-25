import 'package:equatable/equatable.dart';

import 'package:mimi_shope/core/error/api_error_model.dart';
import 'package:mimi_shope/feature/cart/data/model/cart_model.dart';
import 'package:mimi_shope/feature/location/data/model/location_model.dart';
import 'package:mimi_shope/feature/order/data/model/order_model.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];
}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {
  final List<CartItemModel> items;
  final double subtotal;
  final double deliveryFee;
  final double totalPrice;
  final LocationModel? selectedLocation;
  final String selectedPaymentMethod;
  final String? locationError;

  const CheckoutLoaded({
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.totalPrice,
    required this.selectedLocation,
    required this.selectedPaymentMethod,
    this.locationError,
  });

  @override
  List<Object?> get props => [
    items,
    subtotal,
    deliveryFee,
    totalPrice,
    selectedLocation,
    selectedPaymentMethod,
    locationError,
  ];
}

class CheckoutPlacingOrder extends CheckoutState {}

class CheckoutPaymentRequired extends CheckoutState {}

class CheckoutSuccess extends CheckoutState {
  final OrderModel order;

  const CheckoutSuccess({required this.order});

  @override
  List<Object?> get props => [order];
}

class CheckoutError extends CheckoutState {
  final String message;

  const CheckoutError(this.message);

  @override
  List<Object?> get props => [message];
}

class CheckoutValidationError extends CheckoutState {
  final String message;

  const CheckoutValidationError({required this.message});

  @override
  List<Object?> get props => [message];
}

class CheckoutCartClearError extends CheckoutState {
  final Failure failure;

  const CheckoutCartClearError({required this.failure});

  @override
  List<Object?> get props => [failure];
}
