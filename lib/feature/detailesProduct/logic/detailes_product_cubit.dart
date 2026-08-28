import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimi_shope/feature/detailesProduct/logic/detailes_product_state.dart';

class DetailesProductCubit extends Cubit<DetailesProductState> {
  DetailesProductCubit() : super(DetailesProductInitial());

  int quantity = 1;

  double getTotalPrice(double price) {
    return price * quantity;
  }

  void incrementQuantity() {
    quantity++;
    emit(DetailesProductUpdated());
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
      emit(DetailesProductUpdated());
    }
  }
}
