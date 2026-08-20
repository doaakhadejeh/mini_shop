import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mimi_shope/feature/auth/data/repository/auth_repository.dart';
import 'package:mimi_shope/feature/cart/data/repository/cart_repository.dart';
import 'package:mimi_shope/feature/cart/data/service/cart_service.dart';
import 'package:mimi_shope/feature/favorites/data/repository/favorites_repository.dart';
import 'package:mimi_shope/feature/favorites/data/service/favorites_service.dart';
import 'package:mimi_shope/feature/home/data/repository/home_repository.dart';
import 'package:mimi_shope/feature/home/data/service/home_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mimi_shope/feature/auth/data/service/auth_service.dart';

// Mocking External & Services
// class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

class MockAuthService extends Mock implements AuthService {}

class MockAuthRepository extends Mock implements AuthenticationRepository {}

//mocking for home
class MockFirebaseFireStor extends Mock implements FirebaseFirestore {}

class MockHomeService extends Mock implements HomeService {}

class MockHomeRepository extends Mock implements HomeRepository {}

//mocking for favorites

class MockFavoritesService extends Mock implements FavoritesService {}

class MockFavoriteRepository extends Mock implements FavoritesRepository {}

//mocking for cart
class MockCartService extends Mock implements CartService {}

class MockCartRepository extends Mock implements CartRepository {}
