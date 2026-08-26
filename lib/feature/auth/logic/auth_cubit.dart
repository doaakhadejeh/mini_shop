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

  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  final phoneFormKey = GlobalKey<FormState>();
  final changePasswordFormKey = GlobalKey<FormState>();
  final changePasswordController = TextEditingController();
  final confirmChangePasswordController = TextEditingController();

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

  Future<void> loginWithEmail() async {
    emit(AuthLoading());

    final result = await _authRepository.loginWithEmail(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated(user)),
    );
  }

  Future<void> registerWithEmail() async {
    emit(AuthLoading());

    final result = await _authRepository.registerWithEmail(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated(user)),
    );
  }

  Future<void> resetPassword() async {
    emit(AuthLoading());

    final result = await _authRepository.resetPassword(
      email: emailController.text.trim(),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(Unauthenticated()),
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

  Future<void> changePassword({required String newPassword}) async {
    emit(AuthLoading());

    final result = await _authRepository.changePassword(
      newPassword: newPassword,
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthInitial()),
    );
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    changePasswordController.dispose();
    confirmChangePasswordController.dispose();
    return super.close();
  }
}
