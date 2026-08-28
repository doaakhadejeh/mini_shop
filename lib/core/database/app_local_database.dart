import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'mini_shop.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Home - Categories
        await db.execute('''
          CREATE TABLE categories (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL
          )
        ''');

        // Home - Products
        await db.execute('''
          CREATE TABLE products (
            id INTEGER PRIMARY KEY,
            category_id TEXT NOT NULL,
            name TEXT NOT NULL,
            subtitle TEXT NOT NULL,
            price REAL NOT NULL,
            rating REAL NOT NULL,
            image TEXT,
            FOREIGN KEY (category_id)
              REFERENCES categories(id)
              ON DELETE CASCADE
          )
        ''');

        // Favorites
        await db.execute('''
          CREATE TABLE favorite_products (
            user_id TEXT NOT NULL,
            id INTEGER NOT NULL,
            name TEXT NOT NULL,
            subtitle TEXT NOT NULL,
            price REAL NOT NULL,
            rating REAL NOT NULL,
            image TEXT,
            PRIMARY KEY (user_id, id)
          )
        ''');
      },
    );
  }
}
