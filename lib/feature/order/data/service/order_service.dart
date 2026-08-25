import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mimi_shope/feature/order/data/model/order_item_model.dart';
import 'package:mimi_shope/feature/order/data/model/order_model.dart';

class OrderService {
  final FirebaseFirestore firebaseFirestore;

  const OrderService(this.firebaseFirestore);

  CollectionReference<Map<String, dynamic>> get _ordersRef {
    return firebaseFirestore.collection('orders');
  }

  Future<void> createOrder({required OrderModel order}) async {
    final orderRef = _ordersRef.doc(order.id);

    await orderRef.set({
      'userId': order.userId,
      'items': order.items.map((item) {
        return {
          'productId': item.productId,
          'productName': item.productName,
          'price': item.price,
          'quantity': item.quantity,
        };
      }).toList(),
      'totalPrice': order.totalPrice,
      'deliveryAddress': order.deliveryAddress,
      'paymentMethod': order.paymentMethod,
      'paymentStatus': order.paymentStatus,
      'orderStatus': order.orderStatus,
      'createdAt': Timestamp.fromDate(order.createdAt),
    });
  }

  Future<List<OrderModel>> getOrders({required String userId}) async {
    final snapshot = await _ordersRef
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();

      final items = (data['items'] as List).map((item) {
        final itemData = item as Map<String, dynamic>;

        return OrderItemModel(
          productId: itemData['productId'] as int,
          productName: itemData['productName'] as String,
          price: (itemData['price'] as num).toDouble(),
          quantity: itemData['quantity'] as int,
        );
      }).toList();

      return OrderModel(
        id: doc.id,
        userId: data['userId'] as String,
        items: items,
        totalPrice: (data['totalPrice'] as num).toDouble(),
        deliveryAddress: data['deliveryAddress'] as String,
        paymentMethod: data['paymentMethod'] as String,
        paymentStatus: data['paymentStatus'] as String,
        orderStatus: data['orderStatus'] as String,
        createdAt: (data['createdAt'] as Timestamp).toDate(),
      );
    }).toList();
  }

  Future<OrderModel> getOrderById({required String orderId}) async {
    final doc = await _ordersRef.doc(orderId).get();

    if (!doc.exists) {
      throw Exception('Order not found');
    }

    final data = doc.data()!;

    final items = (data['items'] as List).map((item) {
      final itemData = item as Map<String, dynamic>;

      return OrderItemModel(
        productId: itemData['productId'] as int,
        productName: itemData['productName'] as String,
        price: (itemData['price'] as num).toDouble(),
        quantity: itemData['quantity'] as int,
      );
    }).toList();

    return OrderModel(
      id: doc.id,
      userId: data['userId'] as String,
      items: items,
      totalPrice: (data['totalPrice'] as num).toDouble(),
      deliveryAddress: data['deliveryAddress'] as String,
      paymentMethod: data['paymentMethod'] as String,
      paymentStatus: data['paymentStatus'] as String,
      orderStatus: data['orderStatus'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
