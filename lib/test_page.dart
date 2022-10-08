import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rebix_test_project/main.dart';
import 'package:rebix_test_project/models/product.dart';
import 'package:rebix_test_project/screens/home_page/widgets/product_card.dart';
import 'package:rebix_test_project/services/product_services.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => TestPageState();
}

// with AutomaticKeepAliveClientMixin<TestPage>
class TestPageState extends State<TestPage> {
  final List<Product> _products = [];
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _getProducts();
  }

  _getProducts() async {
    var response = await ProductService.getProducts();

    // setState(() {
    //   _products.addAll(response!['products']);
    //   _currentPage = response["current_page"];
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),

      body: _products.isEmpty
          ? const Center(child: Text("محصولی برای نمایش وجود ندارد"),)
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 0),
                itemCount: _products.length,
                itemBuilder: (BuildContext context , int index) {
                  return ProductCard(product : _products[index]);
                }
              ),
           ),
    );
  }
}

