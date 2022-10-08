import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rebix_test_project/components/components.dart';
import 'package:rebix_test_project/services/localization_service.dart';


class SettingLanguage extends StatefulWidget {
  const SettingLanguage({Key? key}) : super(key: key);

  @override
  State<SettingLanguage> createState() => SettingLanguageState();
}

class SettingLanguageState extends State<SettingLanguage> {
  Locale currentLanguage = LocalizationService().getLocale();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("language".tr,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: (){
                setState(() {
                  currentLanguage = LocalizationService().changeLocale('English');
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("English (United States)",
                    style: CustomTextStyle.bodyText1(context),
                  ),
                  currentLanguage.languageCode == 'en' ? const Icon(Icons.check, size: 28) : Container()
                ],
              )
            ),
            Divider(height: 20.sp),
            TextButton(
                onPressed: (){
                  setState(() {
                    currentLanguage = LocalizationService().changeLocale('Persian');
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("فارسی (ایران)",
                      style: CustomTextStyle.bodyText1(context),
                    ),
                    currentLanguage.languageCode == 'fa' ? const Icon(Icons.check, size: 28) : Container()
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
