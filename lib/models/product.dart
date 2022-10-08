class Product {
  int? id;
  String? productName;
  String? shopName;
  String? image;
  String? price;

  Product.fromJson(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    productName = parsedJson['product_name'];
    shopName = parsedJson['shop_name'];
    image = parsedJson['image'];
    price = parsedJson['price'];
  }

  Map<String, dynamic> toMap() {
    return <String , dynamic>{
        'id' : id,
        'product_name'  : productName,
        'shop_name' : shopName,
        'image' : image,
        'price' : price,
    };

  }
}