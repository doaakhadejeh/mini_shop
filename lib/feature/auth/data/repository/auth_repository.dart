import 'package:dartz/dartz.dart';
import 'package:mimi_shope/core/error/api_error_model.dart';
import 'package:mimi_shope/core/error/api_error_state.dart';
import 'package:mimi_shope/feature/auth/data/model/auth_model.dart';
import 'package:mimi_shope/feature/auth/data/service/auth_service.dart';

class AuthenticationRepository {
  final AuthService _authService;

  AuthenticationRepository(this._authService);

  Future<Either<Failure, void>> sendOtp({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
  }) async {
    try {
      await _authService.sendOtp(
        phoneNumber: phoneNumber,
        onCodeSent: (verificationId, resendToken) {
          onCodeSent(verificationId);
        },
        onVerificationFailed: (e) {
          throw e;
        },
        onVerificationCompleted: (credential) async {
          //  print("verificationCompleted");
        },
        onCodeAutoRetrievalTimeout: (verificationId) {},
      );
      return const Right(null);
    } catch (e) {
      return Left(handleException(e));
    }
  }

  Future<Either<Failure, UserModel>> verifyOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final credential = await _authService.verifyOtp(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      return Right(UserModel.fromFirebaseUser(credential.user!));
    } catch (e) {
      return Left(handleException(e));
    }
  }

  Future<Either<Failure, void>> logout() async {
    try {
      await _authService.logout();
      return const Right(null);
    } catch (e) {
      return Left(handleException(e));
    }
  }

  Either<Failure, UserModel?> getCurrentUser() {
    try {
      final user = _authService.getCurrentUser();
      if (user != null) {
        return Right(UserModel.fromFirebaseUser(user));
      }
      return const Right(null);
    } catch (e) {
      return Left(handleException(e));
    }
  }

  bool isLoggedIn() {
    return _authService.isLoggedIn();
  }
}

// import 'dart:async';
// import 'package:dartz/dartz.dart';
// import 'package:mimi_shope/core/error/api_error_model.dart';
// import 'package:mimi_shope/core/error/api_error_state.dart';
// import 'package:mimi_shope/feature/auth/data/model/auth_model.dart';
// import 'package:mimi_shope/feature/auth/data/service/auth_service.dart';

// class AuthenticationRepository {
//   final AuthService _authService;

//   AuthenticationRepository(this._authService);

//   Future<Either<Failure, void>> sendOtp({
//     required String phoneNumber,
//     required Function(String verificationId) onCodeSent,
//   }) async {
//     final completer = Completer<Either<Failure, void>>();

//     try {
//       await _authService.sendOtp(
//         phoneNumber: phoneNumber,
//         onCodeSent: (verificationId, resendToken) {
//           onCodeSent(verificationId);
//           if (!completer.isCompleted) {
//             completer.complete(const Right(null));
//           }
//         },
//         onVerificationFailed: (e) {
//           if (!completer.isCompleted) {
//             completer.complete(Left(handleException(e)));
//           }
//         },
//         onVerificationCompleted: (credential) async {},
//         onCodeAutoRetrievalTimeout: (verificationId) {},
//       );

//       return completer.future;
//     } catch (e) {
//       return Left(handleException(e));
//     }
//   }

//   Future<Either<Failure, UserModel>> verifyOtp({
//     required String verificationId,
//     required String smsCode,
//   }) async {
//     try {
//       final credential = await _authService.verifyOtp(
//         verificationId: verificationId,
//         smsCode: smsCode,
//       );
//       return Right(UserModel.fromFirebaseUser(credential.user!));
//     } catch (e) {
//       return Left(handleException(e));
//     }
//   }

//   Future<Either<Failure, void>> logout() async {
//     try {
//       await _authService.logout();
//       return const Right(null);
//     } catch (e) {
//       return Left(handleException(e));
//     }
//   }

//   Either<Failure, UserModel?> getCurrentUser() {
//     try {
//       final user = _authService.getCurrentUser();
//       if (user != null) {
//         return Right(UserModel.fromFirebaseUser(user));
//       }
//       return const Right(null);
//     } catch (e) {
//       return Left(handleException(e));
//     }
//   }

//   bool isLoggedIn() {
//     return _authService.isLoggedIn();
//   }
// }
