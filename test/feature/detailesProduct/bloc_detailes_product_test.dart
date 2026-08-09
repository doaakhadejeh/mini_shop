import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mimi_shope/feature/detailesProduct/ui/logic/detailes_product_cubit.dart';
import 'package:mimi_shope/feature/detailesProduct/ui/logic/detailes_product_state.dart';

void main() {
  late DetailesProductCubit cubit;

  setUp(() {
    cubit = DetailesProductCubit();
  });

  tearDown(() {
    cubit.close();
  });

  group('DetailesProductCubit', () {
    test('initial quantity is 1', () {
      expect(cubit.quantity, 1);
    });

    blocTest<DetailesProductCubit, DetailesProductState>(
      'increments quantity',
      build: () => cubit,
      act: (cubit) => cubit.incrementQuantity(),
      expect: () => [DetailesProductUpdated()],
      verify: (cubit) {
        expect(cubit.quantity, 2);
      },
    );

    blocTest<DetailesProductCubit, DetailesProductState>(
      'decrements quantity when quantity is greater than 1',
      build: () {
        cubit.quantity = 2;
        return cubit;
      },
      act: (cubit) => cubit.decrementQuantity(),
      expect: () => [DetailesProductUpdated()],
      verify: (cubit) {
        expect(cubit.quantity, 1);
      },
    );

    blocTest<DetailesProductCubit, DetailesProductState>(
      'does not decrement quantity below 1',
      build: () => cubit,
      act: (cubit) => cubit.decrementQuantity(),
      expect: () => [],
      verify: (cubit) {
        expect(cubit.quantity, 1);
      },
    );

    test('calculates total price correctly', () {
      cubit.quantity = 3;

      expect(cubit.getTotalPrice(4.5), 13.5);
    });
  });
}
