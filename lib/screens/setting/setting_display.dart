import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rebix_test_project/components/components.dart';
import 'package:rebix_test_project/main.dart';
import 'package:rebix_test_project/theme/theme_provider.dart';


class SettingDisplay extends StatefulWidget {
  const SettingDisplay({super.key});

  @override
  State<SettingDisplay> createState() => SettingDisplayState();
}

class SettingDisplayState extends State<SettingDisplay> {
  bool _groupValue = setTheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("display".tr,
          style: CustomTextStyle.headline6(context).copyWith(color: Colors.white),
        ), // صفحه نمایش
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
              border: Border.all(color: Colors.white, width: 1),
            ),
            child: Center(
              child: Icon(Icons.arrow_back, size: 30.sp),
            ),
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/light.png"),
                  Text("light".tr,
                    style: CustomTextStyle.bodyText1(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: setTheme ? Colors.white : Colors.blue,
                    ),
                  ),
                  Radio(
                    value: false,
                    groupValue: _groupValue,
                    onChanged: (value){
                      setState(() {
                        _groupValue = value!;
                        ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);
                        themeProvider.swapTheme(value);
                      });
                    },
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/dark.png"),
                  Text("dark".tr,
                    style: CustomTextStyle.bodyText1(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: setTheme ? Colors.tealAccent : Colors.black54,
                    ),
                  ),
                  Radio(
                    value: true,
                    groupValue: _groupValue,
                    onChanged: (value){
                      setState(() {
                        _groupValue = value!;
                        ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);
                        themeProvider.swapTheme(value);
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
