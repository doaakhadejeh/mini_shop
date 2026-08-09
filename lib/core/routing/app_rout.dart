import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mimi_shope/core/di/dependency_injection.dart';
import 'package:mimi_shope/core/routing/const_rout.dart';
import 'package:mimi_shope/feature/auth/logic/auth_cubit.dart';
import 'package:mimi_shope/feature/auth/ui/login_email_page.dart';
import 'package:mimi_shope/feature/auth/ui/login_page.dart';
import 'package:mimi_shope/feature/auth/ui/otp_page.dart';
import 'package:mimi_shope/feature/auth/ui/register_page.dart';
import 'package:mimi_shope/feature/detailesProduct/ui/coffee_detailes_page.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';
import 'package:mimi_shope/feature/home/ui/home_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: ConstRouter.init,
  routes: <RouteBase>[
    GoRoute(
      path: ConstRouter.init,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (context) => getIt<AuthCubit>(),
          child: LoginPage(),
        );
      },
    ),
    GoRoute(
      path: ConstRouter.otp,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (context) => getIt<AuthCubit>(),
          child: const OtpPage(),
        );
      },
    ),
    GoRoute(
      path: ConstRouter.loginEmail,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (context) => getIt<AuthCubit>(),
          child: const LoginEmailPage(),
        );
      },
    ),
    GoRoute(
      path: ConstRouter.register,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (context) => getIt<AuthCubit>(),
          child: const RegisterPage(),
        );
      },
    ),
    GoRoute(
      path: ConstRouter.home,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: ConstRouter.detaileCoffee,
      builder: (BuildContext context, GoRouterState state) {
        final item = state.extra as CoffeeItemModel;
        return BlocProvider(
          create: (context) => getIt<AuthCubit>(),
          child: CoffeeDetailsScreen(item: item),
        );
      },
    ),
  ],
);
