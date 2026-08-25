import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimi_shope/core/helper/shared_pref.dart';
import 'package:mimi_shope/feature/order/data/repository/order_repository.dart';
import 'package:mimi_shope/feature/order/logic/order_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrderRepository _orderRepository;
  final Future<String?> Function()? getUserId;
  OrdersCubit(this._orderRepository, {this.getUserId}) : super(OrdersInitial());

  Future<String?> _getUserId() {
    if (getUserId != null) {
      return getUserId!();
    }

    return SharedPrefHelper.getSecuredString("userId");
  }

  Future<void> getOrders() async {
    emit(OrdersLoading());
    final userId = await _getUserId();
    final result = await _orderRepository.getOrders(userId: userId!);

    result.fold(
      (failure) {
        emit(OrdersError(message: failure.message));
      },
      (orders) {
        emit(OrdersSuccess(orders: orders));
      },
    );
  }
}
