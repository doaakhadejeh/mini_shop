import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:mimi_shope/core/theme/cubit/cubit_theme.dart';
import 'package:mimi_shope/core/theme/themeService/theme_service.dart';
import 'package:mimi_shope/feature/auth/data/repository/auth_repository.dart';
import 'package:mimi_shope/feature/auth/data/service/auth_service.dart';
import 'package:mimi_shope/feature/auth/logic/auth_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerFactory<ThemeCubit>(() => ThemeCubit(getIt<ThemeService>()));
  getIt.registerLazySingleton<ThemeService>(() => ThemeService());
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // firebase auth
  getIt.registerLazySingleton<AuthService>(
    () => AuthService(getIt<FirebaseAuth>()),
  );
  getIt.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepository(getIt<AuthService>()),
  );
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(getIt<AuthenticationRepository>()),
  );
}
