import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mimi_shope/feature/favorites/data/repository/favorites_repository.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock.dart';

void main() {
  late FavoritesRepository favoritesRepository;
  late MockFavoritesService mockFavoritesService;

  setUp(() {
    mockFavoritesService = MockFavoritesService();
    favoritesRepository = FavoritesRepository(mockFavoritesService);
  });

  final milkLatte = CoffeeItemModel(
    id: 1,
    name: 'Milk Latte',
    subtitle: 'Creamy milk coffee',
    price: 4.5,
    rating: 4.8,
    image: 'image1',
  );

  final caramelLatte = CoffeeItemModel(
    id: 2,
    name: 'Caramel Latte',
    subtitle: 'Sweet caramel coffee',
    price: 5.0,
    rating: 4.7,
    image: 'image2',
  );

  group('FavoritesRepository', () {
    test('addToFavorites returns Right when service succeeds', () async {
      when(
        () => mockFavoritesService.addToFavorites(userId: '234', productId: 1),
      ).thenAnswer((_) async {});

      final result = await favoritesRepository.addToFavorites(
        userId: '234',
        productId: 1,
      );

      expect(result, const Right(null));

      verify(
        () => mockFavoritesService.addToFavorites(userId: '234', productId: 1),
      ).called(1);
    });

    test('addToFavorites returns Left when service throws', () async {
      when(
        () => mockFavoritesService.addToFavorites(userId: '234', productId: 1),
      ).thenThrow(Exception('Firebase error'));

      final result = await favoritesRepository.addToFavorites(
        userId: '234',
        productId: 1,
      );

      expect(result.isLeft(), true);

      verify(
        () => mockFavoritesService.addToFavorites(userId: '234', productId: 1),
      ).called(1);
    });

    test('removeFromFavorites returns Right when service succeeds', () async {
      when(
        () => mockFavoritesService.removeFromFavorites(
          userId: '234',
          productId: 1,
        ),
      ).thenAnswer((_) async {});

      final result = await favoritesRepository.removeFromFavorites(
        userId: '234',
        productId: 1,
      );

      expect(result, const Right(null));

      verify(
        () => mockFavoritesService.removeFromFavorites(
          userId: '234',
          productId: 1,
        ),
      ).called(1);
    });

    test('removeFromFavorites returns Left when service throws', () async {
      when(
        () => mockFavoritesService.removeFromFavorites(
          userId: '234',
          productId: 1,
        ),
      ).thenThrow(Exception('Firebase error'));

      final result = await favoritesRepository.removeFromFavorites(
        userId: '234',
        productId: 1,
      );

      expect(result.isLeft(), true);

      verify(
        () => mockFavoritesService.removeFromFavorites(
          userId: '234',
          productId: 1,
        ),
      ).called(1);
    });

    test(
      'isFavorite returns Right(false) when product is not favorite',
      () async {
        when(
          () => mockFavoritesService.isFavorite(userId: '234', productId: 1),
        ).thenAnswer((_) async => false);

        final result = await favoritesRepository.isFavorite(
          userId: '234',
          productId: 1,
        );

        expect(result, const Right(false));
      },
    );

    test(
      'getFavoriteProducts returns products when service succeeds',
      () async {
        final products = [milkLatte, caramelLatte];

        when(
          () => mockFavoritesService.getFavoriteProducts(userId: '234'),
        ).thenAnswer((_) async => products);

        final result = await favoritesRepository.getFavoriteProducts(
          userId: '234',
        );

        expect(result, Right(products));
      },
    );

    test('getFavoriteProducts returns Left when service throws', () async {
      when(
        () => mockFavoritesService.getFavoriteProducts(userId: '234'),
      ).thenThrow(Exception('Firebase error'));

      final result = await favoritesRepository.getFavoriteProducts(
        userId: '234',
      );

      expect(result.isLeft(), true);
    });
  });
}
