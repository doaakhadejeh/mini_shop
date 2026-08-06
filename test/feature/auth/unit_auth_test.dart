import 'package:flutter_test/flutter_test.dart';
import 'package:mimi_shope/feature/auth/data/repository/auth_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock.dart';

void main() {
  late MockAuthService mockAuthService;
  late AuthenticationRepository repository;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;

  setUp(() {
    mockAuthService = MockAuthService();
    repository = AuthenticationRepository(mockAuthService);
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
  });

  group('AuthRepository Unit Tests', () {
    test('when verifyOtp success return UserModel', () async {
      when(() => mockUser.uid).thenReturn('12345');
      when(() => mockUser.phoneNumber).thenReturn('+963912345678');
      when(() => mockUserCredential.user).thenReturn(mockUser);

      when(
        () => mockAuthService.verifyOtp(
          verificationId: 'id_123',
          smsCode: '1234',
        ),
      ).thenAnswer((_) async => mockUserCredential);

      final result = await repository.verifyOtp(
        verificationId: 'id_123',
        smsCode: '1234',
      );
      expect(result.isRight(), true);

      result.fold((l) => fail('should not fail'), (userModel) {
        expect(userModel.uid, '12345');
        expect(userModel.phoneNumber, '+963912345678');
      });
    });

    test('if user is logged in ', () {
      when(() => mockAuthService.isLoggedIn()).thenReturn(true);
      final result = repository.isLoggedIn();
      expect(result, true);
      verify(() => mockAuthService.isLoggedIn()).called(1);
    });
  });
}
