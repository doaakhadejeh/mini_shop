import 'package:dartz/dartz.dart';
import 'package:mimi_shope/core/error/api_error_model.dart';
import 'package:mimi_shope/core/error/api_error_state.dart';
import 'package:mimi_shope/feature/payment/data/model/payment_result.dart';
import 'package:mimi_shope/feature/payment/data/service/payment_service.dart';

class PaymentRepository {
  final PaymentService _paymentService;

  PaymentRepository(this._paymentService);

  Future<Either<Failure, PaymentResult>> pay({required double amount}) async {
    try {
      final result = await _paymentService.pay(amount: amount);

      return Right(result);
    } catch (e) {
      return Left(handleException(e));
    }
  }
}
