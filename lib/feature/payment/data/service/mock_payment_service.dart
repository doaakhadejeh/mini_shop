import 'package:mimi_shope/feature/payment/data/model/payment_result.dart';
import 'package:mimi_shope/feature/payment/data/service/payment_service.dart';

class MockPaymentService implements PaymentService {
  @override
  Future<PaymentResult> pay({required double amount}) async {
    await Future.delayed(const Duration(seconds: 2));

    return PaymentResult(
      success: true,
      transactionId: 'TEST-${DateTime.now().millisecondsSinceEpoch}',
    );
  }
}
