import 'package:firebase_auth/firebase_auth.dart';
import 'package:mimi_shope/feature/auth/data/repository/auth_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mimi_shope/feature/auth/data/service/auth_service.dart';

// Mocking External & Services
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

class MockAuthService extends Mock implements AuthService {}

// Mocking Repositories
class MockAuthRepository extends Mock implements AuthenticationRepository {}
