import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mimi_shope/core/error/api_error_state.dart';
import 'package:mimi_shope/feature/home/data/model/category_model.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';
import 'package:mimi_shope/feature/home/logic/home_cubit.dart';
import 'package:mimi_shope/feature/home/logic/home_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock.dart';

void main() {
  late HomeCubit homeCubit;
  late MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    homeCubit = HomeCubit(mockHomeRepository);
  });

  tearDown(() {
    homeCubit.close();
  });

  group('HomeCubit', () {
    test('initial state is HomeInitial', () {
      expect(homeCubit.state, equals(HomeInitial()));
    });

    blocTest<HomeCubit, HomeState>(
      'loads home data successfully',
      build: () {
        when(() => mockHomeRepository.getHomeData()).thenAnswer(
          (_) async => Right([
            CategoryModel(
              id: "1",
              name: "categories",
              products: [
                CoffeeItemModel(
                  id: 1,
                  name: 'latte',
                  subtitle: 'subtitle',
                  price: 4.0,
                  rating: 5.7,
                  image: 'image',
                ),
              ],
            ),
          ]),
        );
        return homeCubit;
      },
      act: (homeCubit) => homeCubit.loadHome(),
      verify: (_) {
        verify(() => mockHomeRepository.getHomeData()).called(1);
      },
      expect: () => [
        HomeLoading(),

        isA<HomeSuccess>()
            .having((s) => s.categories.length, 'categories length', 1)
            .having((s) => s.products.length, 'products length', 1),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits HomeError when fetching home data fails',
      build: () {
        when(
          () => mockHomeRepository.getHomeData(),
        ).thenAnswer((_) async => Left(handleException('error')));
        return homeCubit;
      },
      act: (homeCubit) => homeCubit.loadHome(),
      expect: () => [
        HomeLoading(),
        HomeError("An unexpected error happened: error"),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits selected category products when a category is selected',
      build: () {
        when(() => mockHomeRepository.getHomeData()).thenAnswer(
          (_) async => Right([
            CategoryModel(
              id: '1',
              name: 'Hot Coffee',
              products: [
                CoffeeItemModel(
                  id: 1,
                  name: 'Latte',
                  subtitle: 'Milk Coffee',
                  price: 4.0,
                  rating: 4.5,
                  image: 'image1',
                ),
              ],
            ),
            CategoryModel(
              id: '2',
              name: 'Cold Coffee',
              products: [
                CoffeeItemModel(
                  id: 2,
                  name: 'Cappuccino',
                  subtitle: 'Creamy Coffee',
                  price: 5.0,
                  rating: 4.8,
                  image: 'image2',
                ),
              ],
            ),
          ]),
        );

        return homeCubit;
      },
      act: (cubit) async {
        await cubit.loadHome();
        cubit.selectCategory('2');
      },
      expect: () => [
        HomeLoading(),
        isA<HomeSuccess>()
            .having((s) => s.categories.length, 'categories length', 2)
            .having((s) => s.products.length, 'products length', 2),
        isA<HomeSuccess>()
            .having((s) => s.categories.length, 'categories length', 2)
            .having((s) => s.products.length, 'products length', 1)
            .having((s) => s.products.first.id, 'selected product id', 2)
            .having(
              (s) => s.products.first.name,
              'selected product name',
              'Cappuccino',
            ),
      ],
    );
  });
}
