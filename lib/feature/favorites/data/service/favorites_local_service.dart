import 'package:sqflite/sqflite.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';

class FavoritesLocalService {
  final Database _database;

  FavoritesLocalService(this._database);

  Future<void> addToFavorites({
    required String userId,
    required CoffeeItemModel product,
  }) async {
    await _database.insert('favorite_products', {
      'user_id': userId,
      'id': product.id,
      'name': product.name,
      'subtitle': product.subtitle,
      'price': product.price,
      'rating': product.rating,
      'image': product.image,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeFromFavorites({
    required String userId,
    required int productId,
  }) async {
    await _database.delete(
      'favorite_products',
      where: 'user_id = ? AND id = ?',
      whereArgs: [userId, productId],
    );
  }

  Future<bool> isFavorite({
    required String userId,
    required int productId,
  }) async {
    final result = await _database.query(
      'favorite_products',
      where: 'user_id = ? AND id = ?',
      whereArgs: [userId, productId],
      limit: 1,
    );

    return result.isNotEmpty;
  }

  Future<List<CoffeeItemModel>> getFavoriteProducts({
    required String userId,
  }) async {
    final rows = await _database.query(
      'favorite_products',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    return rows.map((row) {
      return CoffeeItemModel(
        id: row['id'] as int,
        name: row['name'] as String,
        subtitle: row['subtitle'] as String,
        price: (row['price'] as num).toDouble(),
        rating: (row['rating'] as num).toDouble(),
        image: row['image'] as String?,
      );
    }).toList();
  }

  Future<void> saveFavoriteProducts({
    required String userId,
    required List<CoffeeItemModel> products,
  }) async {
    await _database.transaction((txn) async {
      await txn.delete(
        'favorite_products',
        where: 'user_id = ?',
        whereArgs: [userId],
      );

      for (final product in products) {
        await txn.insert('favorite_products', {
          'user_id': userId,
          'id': product.id,
          'name': product.name,
          'subtitle': product.subtitle,
          'price': product.price,
          'rating': product.rating,
          'image': product.image,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }
}
