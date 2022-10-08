import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rebix_test_project/screens/home_page/create_new_product.dart';
import 'package:rebix_test_project/screens/home_page/my_home_page.dart';
import 'package:get/get.dart';
import 'package:rebix_test_project/screens/setting/setting.dart';
import 'package:rebix_test_project/screens/setting/setting_country.dart';
import 'package:rebix_test_project/screens/setting/setting_display.dart';
import 'package:rebix_test_project/screens/setting/setting_language.dart';
import 'package:rebix_test_project/services/localization_service.dart';
import 'package:rebix_test_project/test_page.dart';
import 'package:rebix_test_project/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool setTheme = false; // یه متغیر که تعریف شده برای  رادیو باتون صفحه سوئیچ  تم

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    bool isDarkTheme = prefs.getBool("isDarkTheme") ?? false;
    setTheme = isDarkTheme;
    return runApp(ChangeNotifierProvider(
      child: const MyApp(),
      create: (BuildContext context) {
        return ThemeProvider(isDarkMode: isDarkTheme);
      }
    ));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926), // iphone 13 pro max (926 * 428)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child){
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, child){
            return GetMaterialApp(
              title: 'title'.tr,
              debugShowCheckedModeBanner: false,
              theme: themeProvider.getTheme,

              translations: LocalizationService(),
              locale: const Locale('fa', 'FA'),
              fallbackLocale: const Locale('fa', 'FA'),

              // initialRoute: "/test_page",

              routes: {
                "/" : (context) => const MyHomePage(),
                "/setting" : (context) => const Setting(),
                "/setting_display" : (context) => const SettingDisplay(),
                "/setting_country" : (context) => const SettingCountry(),
                "/setting_language" : (context) => const SettingLanguage(),
                "/create_new_product" : (context) => const CreateNewProduct(),

                "/test_page" : (context) => const TestPage(),
              },
            );
          },
        );
      }
    );
  }
}
