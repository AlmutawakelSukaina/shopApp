 import 'package:sqflite/sqflite.dart';

import '../../../libs.dart';

class ProductDatabase {
  static final ProductDatabase instance = ProductDatabase._internal();
  static Database? _database;

  ProductDatabase._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = "$databasePath/product_database.db";
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, _) async {
    await db.execute('''
        CREATE TABLE ${ProductTable.tableName} (
          ${ProductTable.id} INTEGER PRIMARY KEY,
          ${ProductTable.title} TEXT,
          ${ProductTable.price} REAL,
          ${ProductTable.description} TEXT,
          ${ProductTable.category} TEXT,
          ${ProductTable.image} TEXT,
          ${ProductTable.ratingRate} REAL,
          ${ProductTable.ratingCount} INTEGER
        )
      ''');
  }

  Future<void> insertProducts(List<Product> products) async {
    final db = await instance.database;
    final batch = db.batch();
    for (final product in products) {
      batch.insert(
        ProductTable.tableName,
        product.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
  }

  Future<List<Product>> getAllProducts() async {
    final db = await instance.database;
    globalPrint("inside get product from db");
    final result = await db.query(ProductTable.tableName);
    try
        {
          return result.map((json) => Product.fromJson({
            'id': json[ProductTable.id],
            'title': json[ProductTable.title],
            'price': json[ProductTable.price],
            'description': json[ProductTable.description],
            'category': json[ProductTable.category],


            'rating': {
              'rate': json[ProductTable.ratingRate],
              'count': json[ProductTable.ratingCount],
            },
          })).toList();
        }catch(e,s){
      globalPrint("error $e $s");
      return [];
    }
  }

  Future<void> updateProduct(Product product) async {
    final db = await instance.database;
    await db.update(
      ProductTable.tableName,
      {
        ProductTable.title: product.title,
        ProductTable.price: product.price,
        ProductTable.description: product.description,
        ProductTable.category: product.category,
        ProductTable.image: product.image,
        ProductTable.ratingRate: product.rating.rate,
        ProductTable.ratingCount: product.rating.count,
      },
      where: '${ProductTable.id} = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> deleteProduct(int id) async {
    final db = await instance.database;
    return await db.delete(
      ProductTable.tableName,
      where: '${ProductTable.id} = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
