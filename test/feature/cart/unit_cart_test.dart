import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mimi_shope/feature/cart/data/model/cart_model.dart';
import 'package:mimi_shope/feature/cart/data/repository/cart_repository.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock.dart';

void main() {
  late MockCartService mockCartService;
  late CartRepository cartRepository;

  setUp(() {
    mockCartService = MockCartService();
    cartRepository = CartRepository(mockCartService);
  });

  final caramelLatte = CoffeeItemModel(
    id: 2,
    name: 'Caramel Latte',
    subtitle: 'Sweet caramel coffee',
    price: 5.0,
    rating: 4.7,
    image: 'image2',
  );
  final cartItem1 = CartItemModel(product: caramelLatte, quantity: 3);

  group('cart unit', () {
    test('addToCart returns Right when service succeeds', () async {
      when(
        () => mockCartService.addToCart(userId: '234', product: caramelLatte),
      ).thenAnswer((_) async {});

      final result = await cartRepository.addToCart(
        userId: '234',
        product: caramelLatte,
      );

      expect(result, const Right(null));

      verify(
        () => mockCartService.addToCart(userId: '234', product: caramelLatte),
      ).called(1);
    });

    test('addToCart returns Left when service failed', () async {
      when(
        () => mockCartService.addToCart(userId: '234', product: caramelLatte),
      ).thenThrow(Exception('Firebase error'));

      final result = await cartRepository.addToCart(
        userId: '234',
        product: caramelLatte,
      );

      expect(result.isLeft(), true);

      verify(
        () => mockCartService.addToCart(userId: '234', product: caramelLatte),
      ).called(1);
    });
    ////////////////////////////////////
    test('removeToCart returns Right when service succeeds', () async {
      when(
        () => mockCartService.removeFromCart(
          userId: '234',
          productId: caramelLatte.id,
        ),
      ).thenAnswer((_) async {});

      final result = await cartRepository.removeFromCart(
        userId: '234',
        productId: caramelLatte.id,
      );

      expect(result, const Right(null));

      verify(
        () => mockCartService.removeFromCart(
          userId: '234',
          productId: caramelLatte.id,
        ),
      ).called(1);
    });

    test('removeToCart returns Left when service failed', () async {
      when(
        () => mockCartService.removeFromCart(
          userId: '234',
          productId: caramelLatte.id,
        ),
      ).thenThrow(Exception('Firebase error'));

      final result = await cartRepository.removeFromCart(
        userId: '234',
        productId: caramelLatte.id,
      );

      expect(result.isLeft(), true);

      verify(
        () => mockCartService.removeFromCart(
          userId: '234',
          productId: caramelLatte.id,
        ),
      ).called(1);
    });

    /////////////////
    test('getCart returns Right when service succeeds', () async {
      when(() => mockCartService.getCartItems(userId: '234')).thenAnswer((
        _,
      ) async {
        return [cartItem1];
      });

      final result = await cartRepository.getCartItems(userId: '234');

      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Should not return failure'),
        (items) => expect(items, [cartItem1]),
      );

      verify(() => mockCartService.getCartItems(userId: '234')).called(1);
    });

    test('getCart returns Left when service failed', () async {
      when(
        () => mockCartService.getCartItems(userId: '234'),
      ).thenThrow(Exception('Firebase error'));

      final result = await cartRepository.getCartItems(userId: '234');

      expect(result.isLeft(), true);

      verify(() => mockCartService.getCartItems(userId: '234')).called(1);
    });

    /////////////////////////
    test('update quantity returns Right when service succeeds', () async {
      when(
        () => mockCartService.updateQuantity(
          userId: '234',
          quantity: 5,
          productId: caramelLatte.id,
        ),
      ).thenAnswer((_) async {});

      final result = await cartRepository.updateQuantity(
        userId: '234',
        quantity: 5,
        productId: caramelLatte.id,
      );

      expect(result, const Right(null));

      verify(
        () => mockCartService.updateQuantity(
          userId: '234',
          quantity: 5,
          productId: caramelLatte.id,
        ),
      ).called(1);
    });

    test('update quantity returns Left when service failed', () async {
      when(
        () => mockCartService.updateQuantity(
          userId: '234',
          quantity: 5,
          productId: caramelLatte.id,
        ),
      ).thenThrow(Exception('Firebase error'));

      final result = await cartRepository.updateQuantity(
        quantity: 5,
        userId: '234',
        productId: caramelLatte.id,
      );

      expect(result.isLeft(), true);

      verify(
        () => mockCartService.updateQuantity(
          userId: '234',
          quantity: 5,
          productId: caramelLatte.id,
        ),
      ).called(1);
    });
  });
}
