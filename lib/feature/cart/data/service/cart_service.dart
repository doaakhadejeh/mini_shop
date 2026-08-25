import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mimi_shope/feature/cart/data/model/cart_model.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';

class CartService {
  final FirebaseFirestore firebaseFirestore;

  const CartService(this.firebaseFirestore);

  CollectionReference<Map<String, dynamic>> _cartRef(String userId) {
    return firebaseFirestore.collection('cart').doc(userId).collection('items');
  }

  Future<List<CartItemModel>> getCartItems({required String userId}) async {
    final cartSnapshot = await _cartRef(userId).get();

    return cartSnapshot.docs.map((doc) {
      final data = doc.data();

      final product = CoffeeItemModel(
        id: data['productId'] as int,
        name: data['name'] as String,
        subtitle: data['subtitle'] as String,
        price: (data['price'] as num).toDouble(),
        rating: (data['rating'] as num).toDouble(),
        image: data['image'] as String?,
      );

      return CartItemModel(product: product, quantity: data['quantity'] as int);
    }).toList();
  }

  Future<void> addToCart({
    required String userId,
    required CoffeeItemModel product,
    int quantity = 1,
  }) async {
    final cartItemRef = _cartRef(userId).doc(product.id.toString());

    final cartItem = await cartItemRef.get();

    if (cartItem.exists) {
      await cartItemRef.update({'quantity': FieldValue.increment(quantity)});
    } else {
      await cartItemRef.set({
        'productId': product.id,
        'name': product.name,
        'subtitle': product.subtitle,
        'price': product.price,
        'rating': product.rating,
        'image': product.image,
        'quantity': quantity,
      });
    }
  }

  Future<void> updateQuantity({
    required String userId,
    required int productId,
    required int quantity,
  }) async {
    final cartItemRef = _cartRef(userId).doc(productId.toString());

    if (quantity <= 0) {
      await cartItemRef.delete();
      return;
    }

    await cartItemRef.update({'quantity': quantity});
  }

  Future<void> removeFromCart({
    required String userId,
    required int productId,
  }) async {
    await _cartRef(userId).doc(productId.toString()).delete();
  }

  Future<void> clearCart({required String userId}) async {
    final cartItems = await _cartRef(userId).get();

    for (final doc in cartItems.docs) {
      await doc.reference.delete();
    }
  }
}
