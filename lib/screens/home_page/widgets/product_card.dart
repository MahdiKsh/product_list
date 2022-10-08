import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rebix_test_project/components/components.dart';
import 'package:rebix_test_project/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product? product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.sp,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(2.0.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(16.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // نام کالا
                    Text(product!.productName!,
                      style: CustomTextStyle.bodyText1(context).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),

                    // قیمت
                    Text("قیمت : ${moneyMask(product!.price!.toString())}",
                      style: CustomTextStyle.bodyText1(context),
                    ),

                    // نام فروشنده
                    Text(product!.shopName!,
                      style: CustomTextStyle.bodyText1(context).copyWith(
                        fontSize: 12.sp
                      ),
                    ),
                  ],
                ),
              ),

              // تصویر کالا
              Container(
                width: 140.sp, height: 140.sp,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(product!.image!)),
                    fit: BoxFit.cover
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

}