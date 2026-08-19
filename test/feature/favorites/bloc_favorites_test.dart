import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mimi_shope/core/error/api_error_state.dart';
import 'package:mimi_shope/feature/favorites/logic/favorites_state.dart';
import 'package:mimi_shope/feature/favorites/logic/favotites_cubit.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock.dart';

void main() {
  late FavoritesCubit favoritesCubit;
  late MockFavoriteRepository mockFavoriteRepository;

  setUp(() {
    mockFavoriteRepository = MockFavoriteRepository();
    favoritesCubit = FavoritesCubit(
      mockFavoriteRepository,
      getUserId: () async => '234',
    );
  });

  tearDown(() async {
    favoritesCubit.close();
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

  // final espresso = CoffeeItemModel(
  //   id: 3,
  //   name: 'Espresso',
  //   subtitle: 'Strong classic coffee',
  //   price: 3.0,
  //   rating: 4.9,
  //   image: 'image3',
  // );

  group('Fvorites Cubit', () {
    test('initial state is FvoritesInitial', () {
      expect(favoritesCubit.state, equals(FavoritesInitial()));
    });

    blocTest<FavoritesCubit, FavoritesState>(
      'loads favorites data successfully',
      build: () {
        when(
          () => mockFavoriteRepository.getFavoriteProducts(userId: '234'),
        ).thenAnswer((_) async => Right([milkLatte, caramelLatte]));
        return favoritesCubit;
      },
      act: (favCubit) => favCubit.getFavoriteProducts(),
      verify: (_) {
        verify(
          () => mockFavoriteRepository.getFavoriteProducts(userId: '234'),
        ).called(1);
      },
      expect: () => [
        FavoritesLoading(),

        FavoritesSuccess(products: [milkLatte, caramelLatte]),
      ],
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'loads favorites data failes',
      build: () {
        when(
          () => mockFavoriteRepository.getFavoriteProducts(userId: '234'),
        ).thenAnswer((_) async => Left(handleException("error")));
        return favoritesCubit;
      },
      act: (favCubit) => favCubit.getFavoriteProducts(),
      verify: (_) {
        verify(
          () => mockFavoriteRepository.getFavoriteProducts(userId: '234'),
        ).called(1);
      },
      expect: () => [
        FavoritesLoading(),

        FavoritesError("An unexpected error happened: error"),
      ],
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'adds product to favorites when it is not already a favorite',
      build: () {
        when(
          () => mockFavoriteRepository.addToFavorites(
            userId: '234',
            productId: milkLatte.id,
          ),
        ).thenAnswer((_) async => const Right(null));

        return favoritesCubit;
      },
      seed: () => FavoritesSuccess(products: [caramelLatte]),
      act: (cubit) => cubit.toggleFavorite(product: milkLatte),
      expect: () => [
        FavoritesSuccess(products: [caramelLatte, milkLatte]),
      ],
      verify: (_) {
        verify(
          () => mockFavoriteRepository.addToFavorites(
            userId: '234',
            productId: milkLatte.id,
          ),
        ).called(1);
      },
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'removes product from favorites when it is already a favorite',
      build: () {
        when(
          () => mockFavoriteRepository.removeFromFavorites(
            userId: '234',
            productId: milkLatte.id,
          ),
        ).thenAnswer((_) async => const Right(null));
        return favoritesCubit;
      },
      seed: () => FavoritesSuccess(products: [milkLatte, caramelLatte]),
      act: (cubit) => cubit.toggleFavorite(product: milkLatte),
      expect: () => [
        FavoritesSuccess(products: [caramelLatte]),
      ],
      verify: (_) {
        verify(
          () => mockFavoriteRepository.removeFromFavorites(
            userId: '234',
            productId: milkLatte.id,
          ),
        ).called(1);
      },
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'does nothings when toggle favorites is called befor favorites loaded',
      build: () {
        when(
          () => mockFavoriteRepository.addToFavorites(
            userId: '234',
            productId: milkLatte.id,
          ),
        ).thenAnswer((_) async => const Right(null));

        return favoritesCubit;
      },
      seed: () => FavoritesLoading(),
      act: (cubit) => cubit.toggleFavorite(product: milkLatte),
      expect: () => [],
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'adds first product when favorites list is empty',
      build: () {
        when(
          () => mockFavoriteRepository.addToFavorites(
            userId: '234',
            productId: milkLatte.id,
          ),
        ).thenAnswer((_) async => const Right(null));

        return favoritesCubit;
      },
      seed: () => FavoritesSuccess(products: []),
      act: (cubit) => cubit.toggleFavorite(product: milkLatte),
      expect: () => [
        FavoritesSuccess(products: [milkLatte]),
      ],
      verify: (_) {
        verify(
          () => mockFavoriteRepository.addToFavorites(
            userId: '234',
            productId: milkLatte.id,
          ),
        ).called(1);
      },
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'removes last favorite when favorites list contains one product',
      build: () {
        when(
          () => mockFavoriteRepository.removeFromFavorites(
            userId: '234',
            productId: milkLatte.id,
          ),
        ).thenAnswer((_) async => const Right(null));

        return favoritesCubit;
      },
      seed: () => FavoritesSuccess(products: [milkLatte]),
      act: (cubit) => cubit.toggleFavorite(product: milkLatte),
      expect: () => [FavoritesSuccess(products: [])],
      verify: (_) {
        verify(
          () => mockFavoriteRepository.removeFromFavorites(
            userId: '234',
            productId: milkLatte.id,
          ),
        ).called(1);
      },
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'returns empty list when there are no favorite products',
      build: () {
        when(
          () => mockFavoriteRepository.getFavoriteProducts(userId: '234'),
        ).thenAnswer((_) async => const Right([]));

        return favoritesCubit;
      },
      act: (cubit) => cubit.getFavoriteProducts(),
      expect: () => [FavoritesLoading(), FavoritesSuccess(products: [])],
      verify: (_) {
        verify(
          () => mockFavoriteRepository.getFavoriteProducts(userId: '234'),
        ).called(1);
      },
    );
  });
}
