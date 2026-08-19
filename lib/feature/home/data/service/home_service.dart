import 'package:cloud_firestore/cloud_firestore.dart';

class HomeService {
  final FirebaseFirestore _store;
  HomeService(this._store);

  Future<QuerySnapshot<Map<String, dynamic>>> getProductsByCategory(
    String categoryId,
  ) async {
    return await _store
        .collection('categories')
        .doc(categoryId)
        .collection('product')
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCategories() async {
    return await _store.collection('categories').get();
  }
}
