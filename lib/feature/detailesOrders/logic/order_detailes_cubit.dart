import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimi_shope/feature/detailesOrders/logic/order_detailes_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit() : super(OrderDetailsInitial());
}
