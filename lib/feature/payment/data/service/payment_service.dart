import 'package:mimi_shope/feature/payment/data/model/payment_result.dart';

abstract class PaymentService {
  Future<PaymentResult> pay({required double amount});
}
