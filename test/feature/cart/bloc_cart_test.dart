import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mimi_shope/core/error/api_error_state.dart';
import 'package:mimi_shope/feature/cart/data/model/cart_model.dart';
import 'package:mimi_shope/feature/cart/logic/cart_cubit.dart';
import 'package:mimi_shope/feature/cart/logic/cart_state.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock.dart';

void main() {
  late CartCubit cartCubit;
  late MockCartRepository mockCartRepository;

  setUp(() {
    mockCartRepository = MockCartRepository();
    cartCubit = CartCubit(mockCartRepository, getUserId: () async => '234');
  });

  tearDown(() async {
    cartCubit.close();
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

  group('cart Cubit', () {
    test('initial state is CartInitial', () {
      expect(cartCubit.state, equals(CartInitial()));
    });

    blocTest<CartCubit, CartState>(
      'loads cart data successfully',
      build: () {
        when(
          () => mockCartRepository.getCartItems(userId: '234'),
        ).thenAnswer((_) async => Right([cartItem1]));
        return cartCubit;
      },
      act: (favCubit) => favCubit.getCartItems(),
      verify: (_) {
        verify(() => mockCartRepository.getCartItems(userId: '234')).called(1);
      },
      expect: () => [
        CartLoading(),

        CartSuccess(items: [cartItem1]),
      ],
    );

    blocTest<CartCubit, CartState>(
      'loads cart empty successfully',
      build: () {
        when(
          () => mockCartRepository.getCartItems(userId: '234'),
        ).thenAnswer((_) async => Right([]));
        return cartCubit;
      },
      act: (favCubit) => favCubit.getCartItems(),
      verify: (_) {
        verify(() => mockCartRepository.getCartItems(userId: '234')).called(1);
      },
      expect: () => [CartLoading(), CartSuccess(items: [])],
    );

    blocTest<CartCubit, CartState>(
      'loads cart data failed',
      build: () {
        when(
          () => mockCartRepository.getCartItems(userId: '234'),
        ).thenAnswer((_) async => Left(handleException("error")));
        return cartCubit;
      },
      act: (favCubit) => favCubit.getCartItems(),
      verify: (_) {
        verify(() => mockCartRepository.getCartItems(userId: '234')).called(1);
      },
      expect: () => [
        CartLoading(),

        CartError("An unexpected error happened: error"),
      ],
    );

    ///////////////////////////////
    blocTest<CartCubit, CartState>(
      'add cart success (to empty cart)',
      build: () {
        when(
          () => mockCartRepository.addToCart(userId: '234', product: milkLatte),
        ).thenAnswer((_) async => const Right(null));
        return cartCubit;
      },
      seed: () => CartSuccess(items: []),
      act: (favCubit) => favCubit.addToCart(product: milkLatte),
      verify: (_) {
        verify(
          () => mockCartRepository.addToCart(userId: '234', product: milkLatte),
        ).called(1);
      },
      expect: () => [
        CartSuccess(items: [cartItem2]),
      ],
    );
    blocTest<CartCubit, CartState>(
      'add cart success (to non-empty cart)',
      build: () {
        when(
          () => mockCartRepository.addToCart(userId: '234', product: milkLatte),
        ).thenAnswer((_) async => const Right(null));
        return cartCubit;
      },
      seed: () => CartSuccess(items: [cartItem1]),
      act: (favCubit) => favCubit.addToCart(product: milkLatte),
      verify: (_) {
        verify(
          () => mockCartRepository.addToCart(userId: '234', product: milkLatte),
        ).called(1);
      },
      expect: () => [
        CartSuccess(items: [cartItem1, cartItem2]),
      ],
    );

    blocTest<CartCubit, CartState>(
      'add cart  failed',
      build: () {
        when(
          () => mockCartRepository.addToCart(
            userId: '234',
            product: caramelLatte,
          ),
        ).thenAnswer((_) async => Left(handleException("error")));
        return cartCubit;
      },
      seed: () => CartSuccess(items: []),
      act: (favCubit) => favCubit.addToCart(product: caramelLatte),
      verify: (_) {
        verify(
          () => mockCartRepository.addToCart(
            userId: '234',
            product: caramelLatte,
          ),
        ).called(1);
      },
      expect: () => [CartError("An unexpected error happened: error")],
    );

    /////////////
    blocTest<CartCubit, CartState>(
      'remove cart  success',
      build: () {
        when(
          () => mockCartRepository.removeFromCart(
            userId: '234',
            productId: caramelLatte.id,
          ),
        ).thenAnswer((_) async => Right(null));
        return cartCubit;
      },
      seed: () => CartSuccess(items: [cartItem1]),
      act: (favCubit) => favCubit.removeFromCart(productId: caramelLatte.id),
      verify: (_) {
        verify(
          () => mockCartRepository.removeFromCart(
            userId: '234',
            productId: caramelLatte.id,
          ),
        ).called(1);
      },
      expect: () => [CartSuccess(items: [])],
    );

    blocTest<CartCubit, CartState>(
      'increase quantity  success',
      build: () {
        when(
          () => mockCartRepository.updateQuantity(
            userId: '234',
            quantity: 3,
            productId: caramelLatte.id,
          ),
        ).thenAnswer((_) async => const Right(null));

        return cartCubit;
      },
      seed: () => CartSuccess(items: [cartItem1]),
      act: (favCubit) => favCubit.increaseQuantity(productId: caramelLatte.id),
      verify: (_) {
        verify(
          () => mockCartRepository.updateQuantity(
            userId: '234',
            quantity: 3,
            productId: caramelLatte.id,
          ),
        ).called(1);
      },
      expect: () => [
        CartSuccess(items: [cartItem1.copyWith(quantity: 3)]),
      ],
    );

    blocTest<CartCubit, CartState>(
      'decrease quantity  success',
      build: () {
        when(
          () => mockCartRepository.updateQuantity(
            userId: '234',
            quantity: 1,
            productId: caramelLatte.id,
          ),
        ).thenAnswer((_) async => Right(null));
        return cartCubit;
      },
      seed: () => CartSuccess(items: [cartItem1]),
      act: (favCubit) => favCubit.decreaseQuantity(productId: caramelLatte.id),
      verify: (_) {
        verify(
          () => mockCartRepository.updateQuantity(
            userId: '234',
            quantity: 1,
            productId: caramelLatte.id,
          ),
        ).called(1);
      },
      expect: () => [
        CartSuccess(items: [cartItem1.copyWith(quantity: 1)]),
      ],
    );

    blocTest<CartCubit, CartState>(
      'decrease less then 1 quantity  success',
      build: () {
        when(
          () => mockCartRepository.updateQuantity(
            userId: '234',
            quantity: 0,
            productId: caramelLatte.id,
          ),
        ).thenAnswer((_) async => Right(null));
        return cartCubit;
      },
      seed: () => CartSuccess(items: [cartItem1.copyWith(quantity: 1)]),
      act: (favCubit) => favCubit.decreaseQuantity(productId: caramelLatte.id),
      verify: (_) {
        verify(
          () => mockCartRepository.updateQuantity(
            userId: '234',
            quantity: 0,
            productId: caramelLatte.id,
          ),
        ).called(1);
      },
      expect: () => [CartSuccess(items: [])],
    );

    blocTest<CartCubit, CartState>(
      'no user',
      build: () {
        return CartCubit(mockCartRepository, getUserId: () async => null);
      },
      act: (cubit) => cubit.getCartItems(),
      verify: (_) {
        verifyNever(
          () => mockCartRepository.getCartItems(userId: any(named: 'userId')),
        );
      },
      expect: () => [CartLoading(), CartError('User not found')],
    );
  });
}
