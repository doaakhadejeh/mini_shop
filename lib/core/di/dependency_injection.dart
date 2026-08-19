import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:mimi_shope/core/theme/cubit/cubit_theme.dart';
import 'package:mimi_shope/core/theme/themeService/theme_service.dart';
import 'package:mimi_shope/feature/auth/data/repository/auth_repository.dart';
import 'package:mimi_shope/feature/auth/data/service/auth_service.dart';
import 'package:mimi_shope/feature/auth/logic/auth_cubit.dart';
import 'package:mimi_shope/feature/detailesProduct/ui/logic/detailes_product_cubit.dart';
import 'package:mimi_shope/feature/favorites/data/repository/favorites_repository.dart';
import 'package:mimi_shope/feature/favorites/data/service/favorites_service.dart';
import 'package:mimi_shope/feature/favorites/logic/favotites_cubit.dart';
import 'package:mimi_shope/feature/home/data/repository/home_repository.dart';
import 'package:mimi_shope/feature/home/data/service/home_service.dart';
import 'package:mimi_shope/feature/home/logic/home_cubit.dart';

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

  // firebase store
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  getIt.registerLazySingleton<HomeService>(
    () => HomeService(getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepository(getIt<HomeService>()),
  );
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepository>()));

  getIt.registerFactory<DetailesProductCubit>(() => DetailesProductCubit());

  getIt.registerLazySingleton<FavoritesService>(
    () => FavoritesService(getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepository(getIt<FavoritesService>()),
  );
  getIt.registerFactory<FavoritesCubit>(
    () => FavoritesCubit(getIt<FavoritesRepository>()),
  );
}
