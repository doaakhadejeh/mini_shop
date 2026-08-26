import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mimi_shope/core/di/dependency_injection.dart';
import 'package:mimi_shope/core/helper/shared_pref.dart';
import 'package:mimi_shope/core/routing/const_rout.dart';
import 'package:mimi_shope/feature/auth/logic/auth_cubit.dart';
import 'package:mimi_shope/feature/auth/ui/login_email_page.dart';
import 'package:mimi_shope/feature/auth/ui/login_page.dart';
import 'package:mimi_shope/feature/auth/ui/otp_page.dart';
import 'package:mimi_shope/feature/auth/ui/register_page.dart';
import 'package:mimi_shope/feature/cart/logic/cart_cubit.dart';
import 'package:mimi_shope/feature/chekout/logic/checkout_cubit.dart';
import 'package:mimi_shope/feature/chekout/ui/checkout.dart';
import 'package:mimi_shope/feature/detailesOrders/logic/order_detailes_cubit.dart';
import 'package:mimi_shope/feature/detailesOrders/ui/order_detailes_page.dart';
import 'package:mimi_shope/feature/detailesProduct/ui/coffee_detailes_page.dart';
import 'package:mimi_shope/feature/detailesProduct/ui/logic/detailes_product_cubit.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';
import 'package:mimi_shope/feature/home/ui/home_screen.dart';
import 'package:mimi_shope/feature/location/data/model/location_model.dart';
import 'package:mimi_shope/feature/location/ui/location_map.dart';
import 'package:mimi_shope/feature/order/data/model/order_model.dart';
import 'package:mimi_shope/feature/order/logic/order_cubit.dart';
import 'package:mimi_shope/feature/order/ui/order_page.dart';
import 'package:mimi_shope/feature/payment/logic/payment_cubit.dart';
import 'package:mimi_shope/feature/payment/ui/payment_page.dart';
import 'package:mimi_shope/feature/setting/aboutus/about_us.dart';
import 'package:mimi_shope/feature/setting/changePassword/change_password.dart';
import 'package:mimi_shope/feature/setting/ui/setting.dart';

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
      path: ConstRouter.changePassword,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (context) => getIt<AuthCubit>(),
          child: const ChangePasswordPage(),
        );
      },
    ),

    GoRoute(
      path: ConstRouter.setting,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (context) => getIt<AuthCubit>(),
          child: const SettingsPage(),
        );
      },
    ),
    GoRoute(
      path: ConstRouter.checkout,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (_) => getIt<CheckoutCubit>()..initializeCheckout(),
          child: CheckoutPage(),
        );
      },
    ),
    GoRoute(
      path: ConstRouter.locationMap,
      builder: (BuildContext context, GoRouterState state) {
        final location = state.extra as LocationModel;
        return LocationMap(location: location);
      },
    ),
    GoRoute(
      path: ConstRouter.detaileOrder,
      builder: (BuildContext context, GoRouterState state) {
        final order = state.extra as OrderModel;
        return BlocProvider(
          create: (_) => getIt<OrderDetailsCubit>(),
          child: OrderDetailsPage(order: order),
        );
      },
    ),

    GoRoute(
      path: ConstRouter.order,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (_) => getIt<OrdersCubit>(),
          child: OrdersPage(),
        );
      },
    ),

    GoRoute(
      path: ConstRouter.payment,
      builder: (context, state) {
        final amount = state.extra as double;

        return BlocProvider(
          create: (_) => getIt<PaymentCubit>(),
          child: PaymentPage(amount: amount),
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
      path: ConstRouter.aboutUs,
      builder: (BuildContext context, GoRouterState state) {
        return const AboutUsPage();
      },
    ),
    GoRoute(
      path: ConstRouter.detaileCoffee,
      builder: (BuildContext context, GoRouterState state) {
        final item = state.extra as CoffeeItemModel;
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<DetailesProductCubit>()),
            BlocProvider(create: (context) => getIt<CartCubit>()),
          ],
          child: CoffeeDetailsScreen(item: item),
        );
      },
    ),
  ],
  redirect: (context, state) async {
    final userId = await SharedPrefHelper.getSecuredString("userId");

    final isLoggedIn = userId != null && userId.isNotEmpty;

    final isAuthRoute =
        state.matchedLocation == ConstRouter.init ||
        state.matchedLocation == ConstRouter.loginEmail ||
        state.matchedLocation == ConstRouter.register ||
        state.matchedLocation == ConstRouter.otp;

    if (!isLoggedIn && !isAuthRoute) {
      return ConstRouter.init;
    }

    if (isLoggedIn && isAuthRoute) {
      return ConstRouter.home;
    }

    return null;
  },
);
