import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mimi_shope/core/error/api_error_model.dart';
import 'package:mimi_shope/feature/cart/data/model/cart_model.dart';
import 'package:mimi_shope/feature/chekout/logic/checkout_cubit.dart';
import 'package:mimi_shope/feature/chekout/logic/checkout_state.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';
import 'package:mimi_shope/feature/location/data/model/location_model.dart';
import 'package:mimi_shope/feature/order/data/model/order_model.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock.dart';

void main() {
  late CheckoutCubit checkoutCubit;
  late MockOrderRepository mockOrderRepository;
  late MockCartRepository mockCartRepository;
  late MocklocationRepository mocklocationRepository;

  setUp(() {
    mockOrderRepository = MockOrderRepository();
    mockCartRepository = MockCartRepository();
    mocklocationRepository = MocklocationRepository();

    checkoutCubit = CheckoutCubit(
      mockCartRepository,
      mockOrderRepository,
      mocklocationRepository,
      getUserId: () async => '234',
    );
  });

  tearDown(() async {
    await checkoutCubit.close();
  });

  final caramelLatte = CoffeeItemModel(
    id: 2,
    name: 'Caramel Latte',
    subtitle: 'Sweet caramel coffee',
    price: 5.0,
    rating: 4.7,
    image: 'image2',
  );

  final milkLatte = CoffeeItemModel(
    id: 1,
    name: 'Milk Latte',
    subtitle: 'Creamy milk coffee',
    price: 4.5,
    rating: 4.8,
    image: 'image1',
  );

  final cartItem1 = CartItemModel(product: caramelLatte, quantity: 2);

  final cartItem2 = CartItemModel(product: milkLatte, quantity: 1);

  final cartItems = [cartItem1, cartItem2];

  final location = LocationModel(
    latitude: 35.5,
    longitude: 35.8,
    address: 'Latakia, Syria',
  );
  final position = Position(
    latitude: 35.5,
    longitude: 35.8,
    timestamp: DateTime(2026, 8, 21),
    accuracy: 10,
    altitude: 0,
    altitudeAccuracy: 0,
    heading: 0,
    headingAccuracy: 0,
    speed: 0,
    speedAccuracy: 0,
  );

  setUpAll(() {
    registerFallbackValue(
      OrderModel(
        id: 'fallback',
        userId: 'fallback',
        items: [],
        totalPrice: 0,
        deliveryAddress: 'fallback',
        paymentMethod: 'cash',
        paymentStatus: 'unpaid',
        orderStatus: 'pending',
        createdAt: DateTime(2026, 1, 1),
      ),
    );
  });

  group('Checkout Cubit', () {
    blocTest<CheckoutCubit, CheckoutState>(
      'loadCheckout emits loading then loaded when cart succeeds',
      build: () {
        when(
          () => mockCartRepository.getCartItems(userId: '234'),
        ).thenAnswer((_) async => Right(cartItems));

        return checkoutCubit;
      },
      act: (cubit) => cubit.loadCheckout(),
      verify: (_) {
        verify(() => mockCartRepository.getCartItems(userId: '234')).called(1);
      },
      expect: () => [
        CheckoutLoading(),
        CheckoutLoaded(
          items: cartItems,
          subtotal: 14.5,
          deliveryFee: 0,
          totalPrice: 14.5,
          selectedLocation: null,
          selectedPaymentMethod: 'cash',
          locationError: null,
        ),
      ],
    );
    blocTest<CheckoutCubit, CheckoutState>(
      'loadCheckout emits error when cart fails',
      build: () {
        when(
          () => mockCartRepository.getCartItems(userId: '234'),
        ).thenAnswer((_) async => Left(Failure('Failed to load cart')));

        return checkoutCubit;
      },
      act: (cubit) => cubit.loadCheckout(),
      expect: () => [CheckoutLoading(), CheckoutError('Failed to load cart')],
    );
    blocTest<CheckoutCubit, CheckoutState>(
      'initAddress gets current position and address successfully',
      build: () {
        when(
          () => mockCartRepository.getCartItems(userId: '234'),
        ).thenAnswer((_) async => Right(cartItems));

        when(
          () => mocklocationRepository.getCurrentPosition(),
        ).thenAnswer((_) async => Right(position));

        when(
          () => mocklocationRepository.getLocationName(
            latitude: 35.5,
            longitude: 35.8,
          ),
        ).thenAnswer((_) async => Right('Latakia, Syria'));

        return checkoutCubit;
      },
      act: (cubit) async {
        await cubit.loadCheckout();
        await cubit.initAddress();
      },
      expect: () => [
        CheckoutLoading(),

        CheckoutLoaded(
          items: cartItems,
          subtotal: 14.5,
          deliveryFee: 0,
          totalPrice: 14.5,
          selectedLocation: null,
          selectedPaymentMethod: 'cash',
          locationError: null,
        ),

        CheckoutLoaded(
          items: cartItems,
          subtotal: 14.5,
          deliveryFee: 0,
          totalPrice: 14.5,
          selectedLocation: location,
          selectedPaymentMethod: 'cash',
          locationError: null,
        ),
      ],
    );
    blocTest<CheckoutCubit, CheckoutState>(
      'initAddress keeps checkout loaded when getting position fails',
      build: () {
        when(
          () => mockCartRepository.getCartItems(userId: '234'),
        ).thenAnswer((_) async => Right(cartItems));

        when(
          () => mocklocationRepository.getCurrentPosition(),
        ).thenAnswer((_) async => Left(Failure('Location permission denied')));

        return checkoutCubit;
      },
      act: (cubit) async {
        await cubit.loadCheckout();
        await cubit.initAddress();
      },
      expect: () => [
        CheckoutLoading(),

        CheckoutLoaded(
          items: cartItems,
          subtotal: 14.5,
          deliveryFee: 0,
          totalPrice: 14.5,
          selectedLocation: null,
          selectedPaymentMethod: 'cash',
          locationError: null,
        ),

        CheckoutLoaded(
          items: cartItems,
          subtotal: 14.5,
          deliveryFee: 0,
          totalPrice: 14.5,
          selectedLocation: null,
          selectedPaymentMethod: 'cash',
          locationError: 'Location permission denied',
        ),
      ],
    );
    blocTest<CheckoutCubit, CheckoutState>(
      'selectLocation updates selected location successfully',
      build: () {
        when(
          () => mockCartRepository.getCartItems(userId: '234'),
        ).thenAnswer((_) async => Right(cartItems));

        when(
          () => mocklocationRepository.getLocationName(
            latitude: 35.5,
            longitude: 35.8,
          ),
        ).thenAnswer((_) async => Right('Latakia, Syria'));

        return checkoutCubit;
      },
      act: (cubit) async {
        await cubit.loadCheckout();

        await cubit.selectLocation(latitude: 35.5, longitude: 35.8);
      },
      expect: () => [
        CheckoutLoading(),

        CheckoutLoaded(
          items: cartItems,
          subtotal: 14.5,
          deliveryFee: 0,
          totalPrice: 14.5,
          selectedLocation: null,
          selectedPaymentMethod: 'cash',
          locationError: null,
        ),

        CheckoutLoaded(
          items: cartItems,
          subtotal: 14.5,
          deliveryFee: 0,
          totalPrice: 14.5,
          selectedLocation: location,
          selectedPaymentMethod: 'cash',
          locationError: null,
        ),
      ],
    );
    blocTest<CheckoutCubit, CheckoutState>(
      'selectLocation keeps checkout loaded and shows location error when geocoding fails',
      build: () {
        when(
          () => mockCartRepository.getCartItems(userId: '234'),
        ).thenAnswer((_) async => Right(cartItems));

        when(
          () => mocklocationRepository.getLocationName(
            latitude: 35.5,
            longitude: 35.8,
          ),
        ).thenAnswer((_) async => Left(Failure('Could not find address')));

        return checkoutCubit;
      },
      act: (cubit) async {
        await cubit.loadCheckout();

        await cubit.selectLocation(latitude: 35.5, longitude: 35.8);
      },
      expect: () => [
        CheckoutLoading(),

        CheckoutLoaded(
          items: cartItems,
          subtotal: 14.5,
          deliveryFee: 0,
          totalPrice: 14.5,
          selectedLocation: null,
          selectedPaymentMethod: 'cash',
          locationError: null,
        ),

        CheckoutLoaded(
          items: cartItems,
          subtotal: 14.5,
          deliveryFee: 0,
          totalPrice: 14.5,
          selectedLocation: null,
          selectedPaymentMethod: 'cash',
          locationError: 'Could not find address',
        ),
      ],
    );
    blocTest<CheckoutCubit, CheckoutState>(
      'placeOrder emits validation error when address is not selected',
      build: () {
        return checkoutCubit;
      },
      act: (cubit) async {
        when(
          () => mockCartRepository.getCartItems(userId: '234'),
        ).thenAnswer((_) async => Right(cartItems));

        await cubit.loadCheckout();
        await cubit.placeOrder();
      },
      expect: () => [
        CheckoutLoading(),

        CheckoutLoaded(
          items: cartItems,
          subtotal: 14.5,
          deliveryFee: 0,
          totalPrice: 14.5,
          selectedLocation: null,
          selectedPaymentMethod: 'cash',
          locationError: null,
        ),

        const CheckoutValidationError(
          message: 'Please select a delivery address',
        ),
      ],
    );
    blocTest<CheckoutCubit, CheckoutState>(
      'placeOrder creates order and clears cart successfully',
      build: () {
        when(
          () => mockCartRepository.getCartItems(userId: '234'),
        ).thenAnswer((_) async => Right(cartItems));

        when(
          () => mocklocationRepository.getLocationName(
            latitude: 35.5,
            longitude: 35.8,
          ),
        ).thenAnswer((_) async => Right('Latakia, Syria'));

        when(
          () => mockOrderRepository.createOrder(order: any(named: 'order')),
        ).thenAnswer((_) async => const Right(null));

        when(
          () => mockCartRepository.clearCart(userId: '234'),
        ).thenAnswer((_) async => const Right(null));

        return checkoutCubit;
      },
      act: (cubit) async {
        await cubit.loadCheckout();

        await cubit.selectLocation(latitude: 35.5, longitude: 35.8);

        await cubit.placeOrder();
      },
      expect: () => [
        CheckoutLoading(),

        CheckoutLoaded(
          items: cartItems,
          subtotal: 14.5,
          deliveryFee: 0,
          totalPrice: 14.5,
          selectedLocation: null,
          selectedPaymentMethod: 'cash',
          locationError: null,
        ),

        CheckoutLoaded(
          items: cartItems,
          subtotal: 14.5,
          deliveryFee: 0,
          totalPrice: 14.5,
          selectedLocation: location,
          selectedPaymentMethod: 'cash',
          locationError: null,
        ),

        CheckoutPlacingOrder(),

        isA<CheckoutSuccess>(),
      ],
      verify: (_) {
        verify(
          () => mockOrderRepository.createOrder(order: any(named: 'order')),
        ).called(1);

        verify(() => mockCartRepository.clearCart(userId: '234')).called(1);
      },
    );
  });
}
