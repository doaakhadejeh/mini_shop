import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';

class FavoritesService {
  final FirebaseFirestore firebaseFirestore;

  const FavoritesService(this.firebaseFirestore);

  CollectionReference<Map<String, dynamic>> _favoritesRef(String userId) {
    return firebaseFirestore
        .collection('favorites')
        .doc(userId)
        .collection('items');
  }

  Future<List<CoffeeItemModel>> getFavoriteProducts({
    required String userId,
  }) async {
    final favoritesSnapshot = await _favoritesRef(userId).get();

    final favoriteIds = favoritesSnapshot.docs
        .map((doc) => int.parse(doc.id))
        .toList();

    if (favoriteIds.isEmpty) {
      return [];
    }

    try {
      final productsSnapshot = await firebaseFirestore
          .collectionGroup('product')
          .where('id', whereIn: favoriteIds)
          .get();
      return productsSnapshot.docs
          .map((doc) => CoffeeItemModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addToFavorites({
    required String userId,
    required int productId,
  }) async {
    await _favoritesRef(userId).doc(productId.toString()).set({});
  }

  Future<void> removeFromFavorites({
    required String userId,
    required int productId,
  }) async {
    await _favoritesRef(userId).doc(productId.toString()).delete();
  }

  Future<bool> isFavorite({
    required String userId,
    required int productId,
  }) async {
    final doc = await _favoritesRef(userId).doc(productId.toString()).get();

    return doc.exists;
  }
}
