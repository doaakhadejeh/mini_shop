import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimi_shope/feature/detailesProduct/logic/detailes_product_state.dart';

class DetailesProductCubit extends Cubit<DetailesProductState> {
  DetailesProductCubit() : super(DetailesProductInitial());

  int get quantity {
    if (state is DetailesProductUpdated) {
      return (state as DetailesProductUpdated).quantity;
    }

    return 1;
  }

  double getTotalPrice(double price) {
    return price * quantity;
  }

  void incrementQuantity() {
    emit(DetailesProductUpdated(quantity + 1));
  }

  void decrementQuantity() {
    if (quantity > 1) {
      emit(DetailesProductUpdated(quantity - 1));
    }
  }
}
