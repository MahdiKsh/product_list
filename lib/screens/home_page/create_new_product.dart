import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rebix_test_project/components/components.dart';
import 'package:rebix_test_project/components/text_feild2.dart';
import 'package:rebix_test_project/main.dart';
import 'package:rebix_test_project/services/product_services.dart';


class CreateNewProduct extends StatefulWidget {
  const CreateNewProduct({super.key});

  @override
  State<CreateNewProduct> createState() => CreateNewProductState();
}

class CreateNewProductState extends State<CreateNewProduct> {
  final TextEditingController _productNameCtrl = TextEditingController();
  final TextEditingController _shopNameCtrl = TextEditingController();
  final TextEditingController _priceCtrl = TextEditingController();
  final FocusNode _productNameFocusNode = FocusNode();
  final FocusNode _shopNameFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  String imageSrc = "";
  File img = File("");
  bool backLeading = false;


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
          title: Text("create_new_product".tr,
            style: CustomTextStyle.headline6(context).copyWith(color: Colors.white, fontSize: 22.sp),
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
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
              child: Column(
                children: [
                  SizedBox(height: 10.sp),
                  Row(
                    children: [
                      // دکمه بارگزاری تصویر
                      GestureDetector(
                        onTap: (){
                          getImage();
                        },
                        child: Container(
                          height: 100.sp,
                          width: 100.sp,
                          margin: EdgeInsets.all(8.sp),
                          padding: EdgeInsets.symmetric(horizontal: 8.sp),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.sp),
                              color: Colors.grey.withOpacity(0.7),
                              border: Border.all(color: Colors.black54)
                          ),
                          child: Center(child: Icon(Icons.add_a_photo_outlined, size: 40.sp, color: setTheme ? Colors.black : Colors.white,)),
                        ),
                      ),

                      imageSrc == ""
                      ? const SizedBox()
                      :
                          Container(
                            height: 100.sp,
                            width: 110.sp,
                            margin: EdgeInsets.all(8.sp),
                            padding: EdgeInsets.symmetric(horizontal: 8.sp),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.sp),
                            ),
                            child: ClipRRect(borderRadius: BorderRadius.circular(25.sp),
                                child: Image.file(img, fit: BoxFit.cover)),
                          ),
                    ],
                  ),

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
        ),

        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: (){
                if(_formKey.currentState!.validate()){
                  if(imageSrc != ""){
                    sendDataToSqlite(imageSrc, _productNameCtrl.text, _shopNameCtrl.text, _priceCtrl.text);
                    Navigator.of(context).pop();
                  }
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
                  child: Text("add".tr,
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


  sendDataToSqlite(String imageSrc, String productName, String shopName, String price) async {
    await ProductService.sendDataToSqlite(imageSrc, productName, shopName, price);
  }


  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        imageSrc = pickedFile.path;
        img = File(imageSrc);
      } else {
        print('No image selected.');
      }
    });
  }
}
