import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mimi_shope/core/database/app_local_database.dart';
import 'package:mimi_shope/core/theme/cubit/cubit_theme.dart';
import 'package:mimi_shope/core/theme/themeService/theme_service.dart';
import 'package:mimi_shope/feature/auth/data/repository/auth_repository.dart';
import 'package:mimi_shope/feature/auth/data/service/auth_service.dart';
import 'package:mimi_shope/feature/auth/logic/auth_cubit.dart';
import 'package:mimi_shope/feature/cart/data/repository/cart_repository.dart';
import 'package:mimi_shope/feature/cart/data/service/cart_service.dart';
import 'package:mimi_shope/feature/cart/logic/cart_cubit.dart';
import 'package:mimi_shope/feature/chekout/logic/checkout_cubit.dart';
import 'package:mimi_shope/feature/detailesOrders/logic/order_detailes_cubit.dart';
import 'package:mimi_shope/feature/detailesProduct/logic/detailes_product_cubit.dart';
import 'package:mimi_shope/feature/favorites/data/repository/favorites_repository.dart';
import 'package:mimi_shope/feature/favorites/data/service/favorites_local_service.dart';
import 'package:mimi_shope/feature/favorites/data/service/favorites_service.dart';
import 'package:mimi_shope/feature/favorites/logic/favorites_cubit.dart';
import 'package:mimi_shope/feature/home/data/repository/home_repository.dart';
import 'package:mimi_shope/feature/home/data/service/home_local_service.dart';
import 'package:mimi_shope/feature/home/data/service/home_service.dart';
import 'package:mimi_shope/feature/home/logic/home_cubit.dart';
import 'package:mimi_shope/feature/location/data/repository/location_repository.dart';
import 'package:mimi_shope/feature/location/data/service/location_service.dart';
import 'package:mimi_shope/feature/order/data/repository/order_repository.dart';
import 'package:mimi_shope/feature/order/data/service/order_service.dart';
import 'package:mimi_shope/feature/order/logic/order_cubit.dart';
import 'package:mimi_shope/feature/payment/data/repository/payment_repository.dart';
import 'package:mimi_shope/feature/payment/data/service/mock_payment_service.dart';
import 'package:mimi_shope/feature/payment/data/service/payment_service.dart';
import 'package:mimi_shope/feature/payment/logic/payment_cubit.dart';
import 'package:sqflite/sqflite.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerFactory<ThemeCubit>(() => ThemeCubit(getIt<ThemeService>()));
  getIt.registerLazySingleton<ThemeService>(() => ThemeService());

  // firebase auth
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<AuthService>(
    () => AuthService(getIt<FirebaseAuth>()),
  );
  getIt.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepository(getIt<AuthService>()),
  );
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(getIt<AuthenticationRepository>()),
  );

  //local data
  final database = await AppDatabase.database;

  getIt.registerSingleton<Database>(database);
  getIt.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.createInstance(),
  );

  // firebase store
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  getIt.registerLazySingleton<HomeLocalService>(
    () => HomeLocalService(getIt<Database>()),
  );

  getIt.registerLazySingleton<FavoritesLocalService>(
    () => FavoritesLocalService(getIt<Database>()),
  );

  getIt.registerLazySingleton<HomeService>(
    () => HomeService(getIt<FirebaseFirestore>()),
  );

  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepository(
      getIt<HomeService>(),
      getIt<HomeLocalService>(),
      getIt<InternetConnectionChecker>(),
    ),
  );
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepository>()));

  getIt.registerFactory<DetailesProductCubit>(() => DetailesProductCubit());

  getIt.registerLazySingleton<FavoritesService>(
    () => FavoritesService(getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepository(
      getIt<FavoritesService>(),
      getIt<FavoritesLocalService>(),
      getIt<InternetConnectionChecker>(),
    ),
  );
  getIt.registerFactory<FavoritesCubit>(
    () => FavoritesCubit(getIt<FavoritesRepository>()),
  );

  getIt.registerLazySingleton<CartService>(
    () => CartService(getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<CartRepository>(
    () => CartRepository(getIt<CartService>()),
  );
  getIt.registerFactory<CartCubit>(() => CartCubit(getIt<CartRepository>()));

  getIt.registerLazySingleton<OrderService>(
    () => OrderService(getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<OrderRepository>(
    () => OrderRepository(getIt<OrderService>()),
  );
  getIt.registerFactory<CheckoutCubit>(
    () => CheckoutCubit(
      getIt<CartRepository>(),
      getIt<OrderRepository>(),
      getIt<LocationRepository>(),
    ),
  );

  getIt.registerFactory<OrdersCubit>(
    () => OrdersCubit(getIt<OrderRepository>()),
  );
  getIt.registerFactory<OrderDetailsCubit>(() => OrderDetailsCubit());

  getIt.registerLazySingleton<LocationService>(() => LocationService());
  getIt.registerLazySingleton<LocationRepository>(
    () => LocationRepository(getIt<LocationService>()),
  );

  getIt.registerLazySingleton<PaymentService>(() => MockPaymentService());

  getIt.registerLazySingleton<PaymentRepository>(
    () => PaymentRepository(getIt<PaymentService>()),
  );

  getIt.registerFactory<PaymentCubit>(
    () => PaymentCubit(getIt<PaymentRepository>()),
  );
}
