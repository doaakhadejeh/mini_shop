import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mimi_shope/feature/order/data/model/order_item_model.dart';
import 'package:mimi_shope/feature/order/data/model/order_model.dart'
    show OrderModel;
import 'package:mimi_shope/feature/order/logic/order_cubit.dart';
import 'package:mimi_shope/feature/order/logic/order_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock.dart';

void main() {
  late OrdersCubit ordersCubit;
  late MockOrderRepository mockOrderRepository;

  setUp(() {
    mockOrderRepository = MockOrderRepository();
    ordersCubit = OrdersCubit(
      mockOrderRepository,
      getUserId: () async => '234',
    );
  });

  tearDown(() async {
    ordersCubit.close();
  });

  final order = OrderModel(
    id: 'order_1',
    userId: '234',
    items: [
      OrderItemModel(
        productId: 1,
        productName: 'Caramel Latte',
        price: 5.0,
        quantity: 2,
      ),
      OrderItemModel(
        productId: 2,
        productName: 'Cappuccino',
        price: 4.0,
        quantity: 1,
      ),
    ],
    totalPrice: 14.0,
    deliveryAddress: 'Latakia, Syria',
    paymentMethod: 'Cash',
    paymentStatus: 'Pending',
    orderStatus: 'Pending',
    createdAt: DateTime(2026, 8, 21, 14, 30),
  );

  group('order Cubit', () {
    test('initial state is orderInitial', () {
      expect(ordersCubit.state, equals(OrdersInitial()));
    });

    blocTest<OrdersCubit, OrdersState>(
      'loads order empty data successfully',
      build: () {
        when(
          () => mockOrderRepository.getOrders(userId: '234'),
        ).thenAnswer((_) async => Right([]));
        return ordersCubit;
      },
      act: (orderCubit) => orderCubit.getOrders(),
      verify: (_) {
        verify(() => mockOrderRepository.getOrders(userId: '234')).called(1);
      },
      expect: () => [OrdersLoading(), OrdersSuccess(orders: [])],
    );

    blocTest<OrdersCubit, OrdersState>(
      'loads order  data successfully',
      build: () {
        when(
          () => mockOrderRepository.getOrders(userId: '234'),
        ).thenAnswer((_) async => Right([order]));
        return ordersCubit;
      },
      act: (orderCubit) => orderCubit.getOrders(),
      verify: (_) {
        verify(() => mockOrderRepository.getOrders(userId: '234')).called(1);
      },
      expect: () => [
        OrdersLoading(),
        OrdersSuccess(orders: [order]),
      ],
    );
  });
}
