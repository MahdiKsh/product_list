import 'package:rebix_test_project/models/product.dart';
import 'package:rebix_test_project/sqliteProvider/provider.dart';
import 'package:sqflite/sqflite.dart';

class ProductProvider extends Provider {
  final String _tableName = 'products';

  Future<Product> insert(Product product , { conflictAlgorithm = ConflictAlgorithm.ignore }) async {
    product.id = await db!.insert(_tableName, product.toMap() , conflictAlgorithm: conflictAlgorithm);
    return product;
  }


  Future<bool> insertAll(List<Product> products) async {
    await Future.wait(products.map((product) async {
      await insert(product);
    }));
    return true;
  }


  Future<List<Product>?> paginate() async {
     List<Map<String, dynamic>> maps = await db!.query(_tableName ,
        columns: ['id' , 'product_name' , 'shop_name' , 'image', 'price'],
     );

     if(maps.isNotEmpty) {
       List<Product> products = [];
       for (var product in maps) {
         products.add(Product.fromJson(product));
       }
       return products;
     }

     return null;
  }


  Future<int> delete(int id) async {
    return await db!.delete(_tableName , where: 'id = ?' , whereArgs: [id]);
  }


  Future<int> update(Product product) async {
    return await db!.update(_tableName, product.toMap() , where: 'id = ?' , whereArgs: [product.id]);
  }

}