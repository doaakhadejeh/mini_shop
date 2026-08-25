import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimi_shope/core/helper/shared_pref.dart';
import 'package:mimi_shope/feature/cart/data/model/cart_model.dart';
import 'package:mimi_shope/feature/cart/data/repository/cart_repository.dart';
import 'package:mimi_shope/feature/location/data/model/location_model.dart';
import 'package:mimi_shope/feature/location/data/repository/location_repository.dart';
import 'package:mimi_shope/feature/order/data/model/order_item_model.dart';
import 'package:mimi_shope/feature/order/data/model/order_model.dart';
import 'package:mimi_shope/feature/order/data/repository/order_repository.dart';

import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final CartRepository cartRepository;
  final LocationRepository locationRepository;
  final OrderRepository orderRepository;
  final Future<String?> Function()? getUserId;

  CheckoutCubit(
    this.cartRepository,
    this.orderRepository,
    this.locationRepository, {
    this.getUserId,
  }) : super(CheckoutInitial());

  List<CartItemModel> _cartItems = [];

  String _selectedPaymentMethod = 'cash';

  Future<String?> _getUserId() {
    if (getUserId != null) {
      return getUserId!();
    }
    return SharedPrefHelper.getSecuredString("userId");
  }

  double get subtotal {
    return _cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  }

  double get deliveryFee => 0;

  double get totalPrice => subtotal + deliveryFee;

  List<CartItemModel> get cartItems => _cartItems;

  LocationModel? _selectedLocation;
  LocationModel? get selectedLocation => _selectedLocation;

  String get selectedPaymentMethod => _selectedPaymentMethod;

  Future<void> initializeCheckout() async {
    await loadCheckout();
    if (state is CheckoutLoaded) {
      await initAddress();
    }
  }

  Future<void> loadCheckout() async {
    emit(CheckoutLoading());

    final userId = await _getUserId();
    if (userId == null) {
      emit(const CheckoutError('Please log in to continue.'));
      return;
    }

    final result = await cartRepository.getCartItems(userId: userId);

    result.fold(
      (failure) {
        emit(CheckoutError(failure.message));
      },
      (items) {
        _cartItems = items;
        _emitLoaded();
      },
    );
  }

  Future<void> initAddress() async {
    final positionResult = await locationRepository.getCurrentPosition();

    await positionResult.fold(
      (failure) async {
        _emitLoaded(locationError: failure.message);
      },
      (position) async {
        final addressResult = await locationRepository.getLocationName(
          latitude: position.latitude,
          longitude: position.longitude,
        );
        addressResult.fold(
          (failure) {
            _emitLoaded(locationError: failure.message);
          },
          (address) {
            _selectedLocation = LocationModel(
              latitude: position.latitude,
              longitude: position.longitude,
              address: address,
            );
            _emitLoaded();
          },
        );
      },
    );
  }

  Future<void> selectLocation({
    required double latitude,
    required double longitude,
  }) async {
    final result = await locationRepository.getLocationName(
      latitude: latitude,
      longitude: longitude,
    );

    result.fold(
      (failure) {
        _emitLoaded(locationError: failure.message);
      },
      (address) {
        _selectedLocation = LocationModel(
          latitude: latitude,
          longitude: longitude,
          address: address,
        );
        _emitLoaded();
      },
    );
  }

  void selectPaymentMethod(String paymentMethod) {
    _selectedPaymentMethod = paymentMethod;
    _emitLoaded();
  }

  void _emitLoaded({String? locationError}) {
    emit(
      CheckoutLoaded(
        items: _cartItems,
        subtotal: subtotal,
        deliveryFee: deliveryFee,
        totalPrice: totalPrice,
        selectedLocation: _selectedLocation,
        selectedPaymentMethod: _selectedPaymentMethod,
        locationError: locationError,
      ),
    );
  }

  Future<void> placeOrder() async {
    if (_cartItems.isEmpty) {
      return;
    }
    if (_selectedLocation == null ||
        _selectedLocation!.address == null ||
        _selectedLocation!.address!.isEmpty) {
      emit(
        CheckoutValidationError(message: 'Please select a delivery address'),
      );
      return;
    }

    if (_selectedPaymentMethod == 'card') {
      emit(CheckoutPaymentRequired());
      return;
    }
    await _createOrder();
  }

  Future<void> _createOrder() async {
    final userId = await _getUserId();
    if (userId == null) {
      emit(const CheckoutError('Please log in to continue.'));
      return;
    }
    emit(CheckoutPlacingOrder());
    final order = OrderModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      items: _cartItems.map((item) {
        return OrderItemModel(
          productId: item.product.id,
          productName: item.product.name,
          price: item.product.price,
          quantity: item.quantity,
        );
      }).toList(),
      totalPrice: totalPrice,
      deliveryAddress: _selectedLocation!.address!,
      paymentMethod: _selectedPaymentMethod,
      paymentStatus: _selectedPaymentMethod == 'cash' ? 'unpaid' : 'paid',
      orderStatus: 'pending',
      createdAt: DateTime.now(),
    );
    final orderResult = await orderRepository.createOrder(order: order);
    await orderResult.fold(
      (failure) async {
        emit(CheckoutError(failure.message));
      },
      (_) async {
        await _clearCart(userId: userId, order: order);
      },
    );
  }

  Future<void> _clearCart({
    required String userId,
    required OrderModel order,
  }) async {
    final result = await cartRepository.clearCart(userId: userId);

    result.fold(
      (failure) {
        emit(CheckoutCartClearError(failure: failure));
      },
      (_) {
        _cartItems = [];

        emit(CheckoutSuccess(order: order));
      },
    );
  }

  Future<void> completePaidOrder() async {
    await _createOrder();
  }
}
