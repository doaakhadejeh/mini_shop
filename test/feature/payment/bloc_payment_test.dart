import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mimi_shope/core/error/api_error_state.dart';
import 'package:mimi_shope/feature/payment/data/model/payment_result.dart';
import 'package:mimi_shope/feature/payment/logic/payment_cubit.dart';
import 'package:mimi_shope/feature/payment/logic/payment_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock.dart';

void main() {
  late PaymentCubit paymentCubit;
  late MockPaymentRepository mockPaymentRepository;

  setUp(() {
    mockPaymentRepository = MockPaymentRepository();
    paymentCubit = PaymentCubit(mockPaymentRepository);
  });

  tearDown(() async {
    paymentCubit.close();
  });

  PaymentResult result = PaymentResult(
    success: true,
    transactionId: "transactionId",
  );
  group('payment Cubit', () {
    test('initial state is paymentInitial', () {
      expect(paymentCubit.state, equals(PaymentInitial()));
    });

    blocTest<PaymentCubit, PaymentState>(
      'payment successfully',
      build: () {
        when(
          () => mockPaymentRepository.pay(amount: 3.0),
        ).thenAnswer((_) async => Right(result));
        return paymentCubit;
      },
      act: (paymentCubit) => paymentCubit.pay(amount: 3.0),
      verify: (_) {
        verify(() => mockPaymentRepository.pay(amount: 3.0)).called(1);
      },
      expect: () => [PaymentLoading(), PaymentSuccess(result: result)],
    );

    blocTest<PaymentCubit, PaymentState>(
      'payment failure',
      build: () {
        when(
          () => mockPaymentRepository.pay(amount: 3.0),
        ).thenAnswer((_) async => Left(handleException("error")));
        return paymentCubit;
      },
      act: (paymentCubit) => paymentCubit.pay(amount: 3.0),
      verify: (_) {
        verify(() => mockPaymentRepository.pay(amount: 3.0)).called(1);
      },
      expect: () => [
        PaymentLoading(),
        PaymentFailure(message: "An unexpected error happened: error"),
      ],
    );
  });
}
