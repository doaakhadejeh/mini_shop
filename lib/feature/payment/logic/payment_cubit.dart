import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mimi_shope/feature/payment/data/repository/payment_repository.dart';

import 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepository paymentRepository;

  PaymentCubit(this.paymentRepository) : super(PaymentInitial());

  Future<void> pay({required double amount}) async {
    emit(PaymentLoading());

    final result = await paymentRepository.pay(amount: amount);

    result.fold(
      (failure) {
        emit(PaymentFailure(message: failure.message));
      },
      (paymentResult) {
        if (paymentResult.success) {
          emit(PaymentSuccess(result: paymentResult));
        } else {
          emit(PaymentFailure(message: 'Payment failed'));
        }
      },
    );
  }
}
