import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rebix_test_project/components/components.dart';


class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => SettingState();
}

class SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("setting".tr,
          style: CustomTextStyle.headline6(context).copyWith(color: Colors.white),
        ), // تنظیمات
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Container(
            // height: 30.sp, width: 30.sp,
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

      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          children: [
            TextButton(
                onPressed: (){
                  Navigator.pushNamed(context, "/setting_language");
                },
              child: optionsWidget("assets/images/general_management.png", "general_management".tr, "language".tr)
            ), // مدیریت عمومی // زبان
            Divider(height: 20.sp, thickness: 1.sp, indent: 50.sp),

            TextButton(
              onPressed: (){
                Navigator.pushNamed(context, "/setting_display");
              },
              child: optionsWidget("assets/images/display.png", "display".tr, "theme".tr, )
            ), // صفحه نمایش // تغییر تم
            Divider(height: 20.sp, thickness: 1.sp, indent: 50.sp),

            TextButton(
              onPressed: (){
                Navigator.pushNamed(context, "/setting_country");
              },
              child: optionsWidget("assets/images/country.png", "country".tr, "country_choose".tr)
            ), // کشور محل سکونت // انتخاب کشور
            Divider(height: 20.sp, thickness: 1.sp, indent: 50.sp),
          ],
        ),
      ),
    );
  }

  Widget optionsWidget(String imageIcon, String text, String subText){
    return Row(
      children: [
        Image.asset(imageIcon, width: 45.sp, height: 45.sp,),
        SizedBox(width: 16.sp),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text,
              style: CustomTextStyle.bodyText1(context).copyWith(
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 4.sp),
            Text(subText,
              style: CustomTextStyle.bodyText1(context).copyWith(
                fontSize: 11
              ),
            ),
          ],
        ),
      ],
    );
  }

}
