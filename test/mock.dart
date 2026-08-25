import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mimi_shope/feature/auth/data/repository/auth_repository.dart';
import 'package:mimi_shope/feature/cart/data/repository/cart_repository.dart';
import 'package:mimi_shope/feature/cart/data/service/cart_service.dart';
import 'package:mimi_shope/feature/favorites/data/repository/favorites_repository.dart';
import 'package:mimi_shope/feature/favorites/data/service/favorites_service.dart';
import 'package:mimi_shope/feature/home/data/repository/home_repository.dart';
import 'package:mimi_shope/feature/home/data/service/home_service.dart';
import 'package:mimi_shope/feature/location/data/repository/location_repository.dart';
import 'package:mimi_shope/feature/order/data/repository/order_repository.dart';
import 'package:mimi_shope/feature/order/data/service/order_service.dart';
import 'package:mimi_shope/feature/payment/data/repository/payment_repository.dart';
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

//mocking for order
class MockOrderService extends Mock implements OrderService {}

class MockOrderRepository extends Mock implements OrderRepository {}

class MockPaymentRepository extends Mock implements PaymentRepository {}

class MocklocationRepository extends Mock implements LocationRepository {}
