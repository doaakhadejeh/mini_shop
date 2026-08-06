import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimi_shope/feature/auth/data/repository/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthenticationRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial());

  String selectedCountryCode = '+963';
  String otpCode = '';
  String verificationId = '';
  TextEditingController phone = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> sendOtp(String phoneNumber) async {
    emit(AuthLoading());

    final result = await _authRepository.sendOtp(
      phoneNumber: phoneNumber,
      onCodeSent: (id) {
        verificationId = id;
        emit(PhoneNumberVerificationSent(id));
      },
    );

    result.fold((failure) => emit(AuthError(failure.message)), (_) {});
  }

  Future<void> verifyOtp({
    required String verificationId,
    required String userOtpCode,
  }) async {
    emit(AuthLoading());

    final result = await _authRepository.verifyOtp(
      verificationId: verificationId,
      smsCode: userOtpCode,
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated(user)),
    );
  }

  void checkAuthStatus() {
    if (_authRepository.isLoggedIn()) {
      final result = _authRepository.getCurrentUser();
      result.fold((failure) => emit(Unauthenticated()), (user) {
        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(Unauthenticated());
        }
      });
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    final result = await _authRepository.logout();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(Unauthenticated()),
    );
  }

  @override
  Future<void> close() {
    phone.dispose();
    return super.close();
  }
}
