import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mimi_shope/feature/detailesProduct/ui/coffee_detailes_page.dart';

import 'package:mimi_shope/feature/detailesProduct/ui/logic/detailes_product_cubit.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';

void main() {
  late DetailesProductCubit detailesProductCubit;

  final coffee = CoffeeItemModel(
    id: 1,
    name: 'Latte',
    subtitle: 'Milk Coffee',
    price: 4.0,
    rating: 4.5,
    image: "invalid-image-url",
  );

  Widget createWidgetUnderTest() {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider.value(
            value: detailesProductCubit,
            child: CoffeeDetailsScreen(item: coffee),
          ),
        );
      },
    );
  }

  // setUpAll(() {
  //   HttpOverrides.global = null;
  // });

  setUp(() {
    detailesProductCubit = DetailesProductCubit();
  });

  tearDown(() {
    detailesProductCubit.close();
  });

  group('CoffeeDetailsScreen', () {
    testWidgets('displays product details', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Latte'), findsOneWidget);
      expect(find.text('Milk Coffee'), findsOneWidget);
      expect(find.text('4.5'), findsOneWidget);
      expect(find.text('Total Price'), findsOneWidget);
      expect(find.text('\$4.00'), findsOneWidget);
      expect(find.text('Add to Cart'), findsOneWidget);
    });

    testWidgets('displays initial quantity as 1', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('increases quantity and updates total price', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      final addButton = find.byKey(const Key('add'));

      expect(addButton, findsOneWidget);
      await tester.tap(addButton);

      detailesProductCubit.incrementQuantity();
      await tester.pumpAndSettle();

      expect(find.text('2'), findsOneWidget);
      expect(find.text('\$8.00'), findsOneWidget);
    });

    testWidgets('decreases quantity when quantity is greater than 1', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.byKey(Key("add")));
      await tester.pump();

      await tester.tap(find.byKey(Key("remove")));
      await tester.pump();

      expect(find.text('1'), findsOneWidget);
      expect(find.text('\$4.00'), findsOneWidget);
    });

    testWidgets('does not decrease quantity below 1', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      expect(find.text('1'), findsOneWidget);
      expect(find.text('\$4.00'), findsOneWidget);
    });

    testWidgets('displays add to cart button', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Add to Cart'), findsOneWidget);
    });
  });
}
