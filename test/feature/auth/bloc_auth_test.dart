import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mimi_shope/feature/auth/data/model/auth_model.dart';
import 'package:mimi_shope/feature/auth/logic/auth_cubit.dart';
import 'package:mimi_shope/feature/auth/logic/auth_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mimi_shope/core/error/api_error_model.dart';

import '../../mock.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late AuthCubit authCubit;

  final tUserModel = UserModel(uid: '12345', phoneNumber: '+963912345678');

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authCubit = AuthCubit(mockAuthRepository);
  });

  group('AuthCubit Tests', () {
    test(' inistial state AuthInitial', () {
      expect(authCubit.state, equals(AuthInitial()));
    });

    blocTest<AuthCubit, AuthState>(
      'send otp when enter request',
      build: () {
        when(
          () => mockAuthRepository.sendOtp(
            phoneNumber: any(named: 'phoneNumber'),
            onCodeSent: any(named: 'onCodeSent'),
          ),
        ).thenAnswer((invocation) async {
          final onCodeSent =
              invocation.namedArguments[#onCodeSent] as Function(String);
          onCodeSent('verification_id_123');
          return const Right(null);
        });
        return authCubit;
      },
      act: (cubit) => cubit.sendOtp('+963912345678'),
      expect: () => [
        AuthLoading(),
        const PhoneNumberVerificationSent('verification_id_123'),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits AuthError when OTP verification fails',
      build: () {
        when(
          () => mockAuthRepository.verifyOtp(
            verificationId: any(named: 'verificationId'),
            smsCode: any(named: 'smsCode'),
          ),
        ).thenAnswer((_) async => Left(Failure('verify code uncorrect')));
        return authCubit;
      },
      act: (cubit) => cubit.verifyOtp(
        verificationId: 'verification_id_123',
        userOtpCode: '0000',
      ),
      expect: () => [AuthLoading(), const AuthError('verify code uncorrect')],
    );

    blocTest<AuthCubit, AuthState>(
      'should emit Authenticated when verifyOtp returns user',
      build: () {
        when(
          () => mockAuthRepository.verifyOtp(
            verificationId: any(named: 'verificationId'),
            smsCode: any(named: 'smsCode'),
          ),
        ).thenAnswer((_) async => Right(tUserModel));
        return authCubit;
      },
      act: (cubit) => cubit.verifyOtp(
        verificationId: 'verification_id_123',
        userOtpCode: '1234',
      ),
      expect: () => [AuthLoading(), Authenticated(tUserModel)],
    );
  });
}
