import 'package:equatable/equatable.dart';

import 'package:mimi_shope/feature/payment/data/model/payment_result.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final PaymentResult result;

  const PaymentSuccess({required this.result});

  @override
  List<Object?> get props => [result];
}

class PaymentFailure extends PaymentState {
  final String message;

  const PaymentFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
