import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mimi_shope/core/di/dependency_injection.dart';
import 'package:mimi_shope/core/routing/const_rout.dart';
import 'package:mimi_shope/feature/auth/logic/auth_cubit.dart';
import 'package:mimi_shope/feature/auth/ui/otp_page.dart';
import 'package:mimi_shope/feature/home/ui/home_screen.dart';
import 'package:mimi_shope/feature/auth/ui/login_page.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: ConstRouter.init,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (context) => getIt<AuthCubit>(),
          child: LoginPage(),
        );
      },
      routes: <RouteBase>[
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
          path: ConstRouter.home,
          builder: (BuildContext context, GoRouterState state) {
            return const HomeScreen();
          },
        ),
      ],
    ),
  ],
);
