import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mimi_shope/feature/order/data/model/order_item_model.dart';
import 'package:mimi_shope/feature/order/data/model/order_model.dart';
import 'package:mimi_shope/feature/order/data/repository/order_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock.dart';

void main() {
  late OrderRepository orderRepository;
  late MockOrderService mockOrderService;

  setUp(() {
    mockOrderService = MockOrderService();
    orderRepository = OrderRepository(mockOrderService);
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

  group('OrderRepository', () {
    test('createOrder returns Right when service succeeds', () async {
      when(
        () => mockOrderService.createOrder(order: order),
      ).thenAnswer((_) async {});

      final result = await orderRepository.createOrder(order: order);

      expect(result, const Right(null));

      verify(() => mockOrderService.createOrder(order: order)).called(1);
    });

    test('createOrder returns Left when service throws', () async {
      when(
        () => mockOrderService.createOrder(order: order),
      ).thenThrow(Exception('Firebase error'));

      final result = await orderRepository.createOrder(order: order);

      expect(result.isLeft(), true);

      verify(() => mockOrderService.createOrder(order: order)).called(1);
    });

    test('getOrders returns Right when service succeeds', () async {
      when(() => mockOrderService.getOrders(userId: '234')).thenAnswer((
        _,
      ) async {
        return [order];
      });

      final result = await orderRepository.getOrders(userId: '234');

      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Should not return failure'),
        (items) => expect(items, [order]),
      );

      verify(() => mockOrderService.getOrders(userId: '234')).called(1);
    });

    test('getOrders returns Left when service throws', () async {
      when(
        () => mockOrderService.getOrders(userId: '234'),
      ).thenThrow(Exception('Firebase error'));

      final result = await orderRepository.getOrders(userId: '234');

      expect(result.isLeft(), true);

      verify(() => mockOrderService.getOrders(userId: '234')).called(1);
    });

    test('getOrders by id returns product when service succeeds', () async {
      when(
        () => mockOrderService.getOrderById(orderId: order.id),
      ).thenAnswer((_) async => order);

      final result = await orderRepository.getOrderById(orderId: order.id);

      expect(result, Right(order));
    });

    test('getOrders by id  returns Left when service throws', () async {
      when(
        () => mockOrderService.getOrderById(orderId: order.id),
      ).thenThrow(Exception('Firebase error'));

      final result = await orderRepository.getOrderById(orderId: order.id);

      expect(result.isLeft(), true);
    });
  });
}
