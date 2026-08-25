import 'package:dartz/dartz.dart';

import 'package:mimi_shope/core/error/api_error_model.dart';
import 'package:mimi_shope/core/error/api_error_state.dart';
import 'package:mimi_shope/feature/order/data/model/order_model.dart';
import 'package:mimi_shope/feature/order/data/service/order_service.dart';

class OrderRepository {
  final OrderService _orderService;

  OrderRepository(this._orderService);

  Future<Either<Failure, void>> createOrder({required OrderModel order}) async {
    try {
      await _orderService.createOrder(order: order);

      return const Right(null);
    } catch (e) {
      return Left(handleException(e));
    }
  }

  Future<Either<Failure, List<OrderModel>>> getOrders({
    required String userId,
  }) async {
    try {
      final orders = await _orderService.getOrders(userId: userId);

      return Right(orders);
    } catch (e) {
      return Left(handleException(e));
    }
  }

  Future<Either<Failure, OrderModel>> getOrderById({
    required String orderId,
  }) async {
    try {
      final order = await _orderService.getOrderById(orderId: orderId);

      return Right(order);
    } catch (e) {
      return Left(handleException(e));
    }
  }
}
