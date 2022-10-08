import 'package:rebix_test_project/models/product.dart';
import 'package:rebix_test_project/sqliteProvider/product_provider.dart';


class ProductService {

  static Future<List<Product>?> getProducts() async {
    return await _getAllProductsFromSqlite();
  }



  static Future sendDataToSqlite(String imageSrc, String productName, String shopName, String price) async {
    Map<String, dynamic> response = {
      "product_name": productName,
      "shop_name": shopName,
      "image": imageSrc,
      // "image": "https://news-cdn.varzesh3.com/pictures/2022/10/04/B/i0btqxza.jpg?w=315",
      "price": price,
    };

    Product item = Product.fromJson(response);
    await _saveAllProductsIntoSqlite(item);
  }




  static Future<List<Product>?> _getAllProductsFromSqlite() async {
    var db = ProductProvider();
    await db.open();
    List<Product>? products = await db.paginate();

    await db.close();

    return products;
  }


  static Future<bool?> _saveAllProductsIntoSqlite(products) async {
      var db = ProductProvider();
      await db.open();
      await db.insert(products);
      await db.close();
      return null;
  }


  static Future update(Product product) async {
    var dbProduct = ProductProvider();

    await dbProduct.open();
    await dbProduct.update(product);
    await dbProduct.close();
    return true;
  }


  static Future remove(int id) async {
    var dbProduct = ProductProvider();

    await dbProduct.open();
    await dbProduct.delete(id);
    await dbProduct.close();
    return true;
  }

}