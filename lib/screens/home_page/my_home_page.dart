import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:rebix_test_project/components/components.dart';
import 'package:rebix_test_project/main.dart';
import 'package:rebix_test_project/models/product.dart';
import 'package:rebix_test_project/screens/home_page/product_detail.dart';
import 'package:rebix_test_project/screens/home_page/widgets/product_card.dart';
import 'package:rebix_test_project/services/product_services.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _getProducts();
  }


  _getProducts() async {
    _products.clear();
    List<Product>? response = await ProductService.getProducts() ?? [];

    setState(() {
      _products.addAll(response);
    });
  }

  backAction(){
    setState(() {
      _getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("title".tr,
          style: CustomTextStyle.headline6(context).copyWith(color: Colors.white),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, "/setting");
            },
            icon: Icon(Icons.settings, size: 25.sp),
          ),
        ],
      ),


      body: _products.isEmpty
          ? Center(child: Text("nothing_to_show".tr, style: CustomTextStyle.bodyText1(context)),)
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 16.sp, horizontal: 8.sp),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 0),
                itemCount: _products.length,
                itemBuilder: (BuildContext context , int index) {
                  return Column(
                    children: [
                      Slidable(
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),

                          children: [
                            SlidableAction(
                              onPressed: (val) async {
                                await ProductService.remove(_products[index].id!);
                                setState(() {
                                  _getProducts();
                                });
                              },
                              backgroundColor: const Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'delete'.tr,
                              autoClose: true,
                            ),

                            SlidableAction(
                              onPressed: (val){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetail(product: _products[index]))).then((value) {backAction();});
                              },
                              backgroundColor: const Color(0xFF21B7CA),
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              label: 'edit'.tr,
                              autoClose: true,
                            ),
                          ],
                        ),
                        child: ProductCard(product : _products[index])
                      ),
                      SizedBox(height: 16.sp,)
                    ],
                  );
                }
              ),
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, "/create_new_product").then((value) {backAction();});
        },
        child: Icon(Icons.add, size: 35.sp, color: setTheme ? Colors.black : Colors.white),
      ),

    );
  }
}
