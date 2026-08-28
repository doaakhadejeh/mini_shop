import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mimi_shope/core/theme/theme.dart';
import 'package:mimi_shope/feature/favorites/logic/favorites_cubit.dart';
import 'package:mimi_shope/feature/home/data/model/category_model.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';
import 'package:mimi_shope/feature/home/logic/home_cubit.dart';
import 'package:mimi_shope/feature/home/logic/home_state.dart';
import 'package:mimi_shope/feature/home/ui/my_home_page.dart';

import '../../mock.dart';

void main() {
  late HomeCubit homeCubit;
  late FavoritesCubit favoritesCubit;
  late MockHomeRepository mockHomeRepository;
  late MockFavoriteRepository mockFavoriteRepository;

  final coffee1 = CoffeeItemModel(
    id: 1,
    name: 'Latte',
    subtitle: 'Milk Coffee',
    price: 4.0,
    rating: 4.5,
    image: 'image1',
  );
  final coffee2 = CoffeeItemModel(
    id: 2,
    name: 'Cappuccino',
    subtitle: 'Creamy Coffee',
    price: 5.0,
    rating: 4.8,
    image: 'image2',
  );
  final categories = [
    CategoryModel(id: '1', name: 'Hot Coffee', product: [coffee1]),
    CategoryModel(id: '2', name: 'Cold Coffee', product: [coffee2]),
  ];
  Widget createWidgetUnderTest() {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: AppTheme.lightTheme,
          home: MultiBlocProvider(
            providers: [
              BlocProvider.value(value: homeCubit),
              BlocProvider.value(value: favoritesCubit),
            ],
            child: const MyHomePage(),
          ),
        );
      },
    );
  }

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    mockFavoriteRepository = MockFavoriteRepository();
    homeCubit = HomeCubit(mockHomeRepository);
    favoritesCubit = FavoritesCubit(mockFavoriteRepository);
  });

  tearDown(() {
    homeCubit.close();
    favoritesCubit.close();
  });

  group('MyHomePage', () {
    testWidgets('displays loading indicator when home data is loading', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());
      homeCubit.emit(HomeLoading());
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
    testWidgets('displays home content when home data loads successfully', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());
      homeCubit.emit(
        HomeSuccess(categories: categories, products: [coffee1, coffee2]),
      );
      await tester.pump();
      expect(find.text('Hot Coffee'), findsOneWidget);
      expect(find.text('Cold Coffee'), findsOneWidget);
      expect(find.text('Latte'), findsOneWidget);
      expect(find.text('Cappuccino'), findsOneWidget);
    });
    testWidgets('displays error message when loading home data fails', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());
      homeCubit.emit(HomeError('Failed to load coffee'));
      await tester.pump();
      expect(find.text('Failed to load coffee'), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
    });
  });
}
