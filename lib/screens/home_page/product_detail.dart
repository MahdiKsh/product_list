import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rebix_test_project/components/components.dart';
import 'package:rebix_test_project/components/text_feild2.dart';
import 'package:rebix_test_project/main.dart';
import 'package:rebix_test_project/models/product.dart';
import 'package:rebix_test_project/services/product_services.dart';


// ignore: must_be_immutable
class ProductDetail extends StatefulWidget {
  Product product;
  ProductDetail({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetail> createState() => ProductDetailState();
}

class ProductDetailState extends State<ProductDetail> {
  final TextEditingController _productNameCtrl = TextEditingController();
  final TextEditingController _shopNameCtrl = TextEditingController();
  final TextEditingController _priceCtrl = TextEditingController();
  final FocusNode _productNameFocusNode = FocusNode();
  final FocusNode _shopNameFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool backLeading = false;


  @override
  void initState() {
    super.initState();
    _productNameCtrl.text = widget.product.productName!;
    _shopNameCtrl.text = widget.product.shopName!;
    _priceCtrl.text = widget.product.price!;
  }

  @override
  void dispose() {
    _productNameCtrl.dispose();
    _shopNameCtrl.dispose();
    _priceCtrl.dispose();
    _productNameFocusNode.dispose();
    _shopNameFocusNode.dispose();
    _priceFocusNode.dispose();
    super.dispose();
  }


  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('warning'.tr),
        content: Text('wont_save'.tr),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
              backLeading = false;
            },
            child: Text('cancel'.tr),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              if(backLeading){
                Navigator.of(context).pop(true);
              }
            },
            child: Text('ok'.tr),
          ),
        ],
      ),
    )) ?? false;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("edit_page".tr,
            style: CustomTextStyle.headline6(context).copyWith(color: Colors.white),
          ),
          elevation: 0,
          leading: GestureDetector(
            onTap: (){
              backLeading = true;
              _onWillPop();
            },
            child: Container(
              margin: EdgeInsets.all(8.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.sp),
                border: Border.all(width: 1, color: Colors.white),
              ),
              child: Center(
                child: Icon(Icons.arrow_back, size: 30.sp),
              ),
            ),
          ),
        ),


        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
            child: Column(
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 30.sp),
                        TextFeild2(
                          labelText: "product_name".tr,
                          hintText: "product_name2".tr,
                          // prefixIcon: const Icon(null),
                          controller: _productNameCtrl,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          validator: (String? value){
                            if(value == ""){
                              return "should_not_be_empty".tr;
                            } else {
                              return null;
                            }
                          },
                          focusNode: _productNameFocusNode,
                          textDirection: TextDirection.rtl,
                          onFieldSubmitted: _shopNameFocusNode
                        ),
                        SizedBox(height: 40.sp),

                        TextFeild2(
                          labelText: "shop_name".tr,
                          hintText: "shop_name2".tr,
                          // prefixIcon: const Icon(null),
                          controller: _shopNameCtrl,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          validator: (String? value){
                            if(value == ""){
                              return "should_not_be_empty".tr;
                            } else {
                              return null;
                            }
                          },
                          focusNode: _shopNameFocusNode,
                          textDirection: TextDirection.rtl,
                          onFieldSubmitted: _priceFocusNode
                        ),
                        SizedBox(height: 40.sp),

                        TextFeild2(
                          labelText: "price".tr,
                          hintText: "price2".tr,
                          // prefixIcon: const Icon(null),
                          controller: _priceCtrl,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          validator: (String? value){
                            if(value == ""){
                              return "should_not_be_empty".tr;
                            } else {
                              return null;
                            }
                          },
                          focusNode: _priceFocusNode,
                          textDirection: TextDirection.ltr,
                          onFieldSubmitted: null
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
        ),

        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: (){
                if(_formKey.currentState!.validate()){
                  update(widget.product, _productNameCtrl.text, _shopNameCtrl.text, _priceCtrl.text);
                  Navigator.of(context).pop();
                }

              },
              child: Container(
                height: 70.sp,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: setTheme ? Colors.tealAccent : Colors.orange,
                    borderRadius: BorderRadius.all(Radius.circular(25.sp))
                ),
                child: Center(
                  child: Text("save_changes".tr,
                    style: CustomTextStyle.bodyText1(context).copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: setTheme ? Colors.black : Colors.white
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  update(Product product, String productName, String shopName, String price) async {
    product = Product.fromJson({
      'id' : widget.product.id,
      'product_name'  : productName,
      'shop_name' : shopName,
      'image' : widget.product.image,
      'price' : price,
    });
    await ProductService.update(product);
  }
}
