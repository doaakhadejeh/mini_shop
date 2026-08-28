import 'package:sqflite/sqflite.dart';
import 'package:mimi_shope/feature/home/data/model/category_model.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';

class HomeLocalService {
  final Database _database;

  HomeLocalService(this._database);

  Future<void> saveHomeData(List<CategoryModel> categories) async {
    await _database.transaction((txn) async {
      await txn.delete('products');
      await txn.delete('categories');

      for (final category in categories) {
        await txn.insert('categories', {
          'id': category.id,
          'name': category.name,
        });

        for (final product in category.product) {
          await txn.insert('products', {
            'id': product.id,
            'category_id': category.id,
            'name': product.name,
            'subtitle': product.subtitle,
            'price': product.price,
            'rating': product.rating,
            'image': product.image,
          });
        }
      }
    });
  }

  Future<List<CategoryModel>> getHomeData() async {
    final categoryRows = await _database.query('categories');

    final List<CategoryModel> categories = [];

    for (final categoryRow in categoryRows) {
      final productRows = await _database.query(
        'products',
        where: 'category_id = ?',
        whereArgs: [categoryRow['id']],
      );

      final products = productRows.map((product) {
        return CoffeeItemModel(
          id: product['id'] as int,
          name: product['name'] as String,
          subtitle: product['subtitle'] as String,
          price: (product['price'] as num).toDouble(),
          rating: (product['rating'] as num).toDouble(),
          image: product['image'] as String?,
        );
      }).toList();

      categories.add(
        CategoryModel(
          id: categoryRow['id'] as String,
          name: categoryRow['name'] as String,
          product: products,
        ),
      );
    }

    return categories;
  }
}
