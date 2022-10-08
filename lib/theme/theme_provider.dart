import 'package:flutter/material.dart';
import 'package:rebix_test_project/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

const colorPrimary = Colors.deepOrangeAccent;
const colorAccent = Colors.orange;

class ThemeProvider extends ChangeNotifier{
  ThemeData? _selectedTheme;

  ThemeData lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light().copyWith(primary: Colors.teal), // instead of primarySwatch
    primaryColor: colorPrimary,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: colorAccent
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(horizontal: 40.0,vertical: 20.0)
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))
            ),
            backgroundColor: MaterialStateProperty.all<Color>(colorAccent)
        )
    ),
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),borderSide: BorderSide.none
        ),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1)
    ),
  );


  ThemeData darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    accentColor: Colors.white,
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all<Color>(Colors.grey),
      thumbColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),borderSide: BorderSide.none
        ),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1)
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(horizontal: 40.0,vertical: 20.0)
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)
                )
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            overlayColor: MaterialStateProperty.all<Color>(Colors.black26)
        )
    ),
  );


  ThemeProvider({required bool isDarkMode}){
    _selectedTheme = isDarkMode ? darkTheme : lightTheme;
  }


  void swapTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(value){
      _selectedTheme =  darkTheme;
      prefs.setBool("isDarkTheme", true);
      setTheme = true;
    } else {
      _selectedTheme = lightTheme;
      prefs.setBool("isDarkTheme", false);
      setTheme = false;
    }
    notifyListeners();
  }


  ThemeData? get getTheme => _selectedTheme;


  // ThemeMode _themeMode = ThemeMode.light;
  // get themeMode => _themeMode;
  //
  // toggleTheme(bool isDark){
  //   _themeMode = isDark?ThemeMode.dark:ThemeMode.light;
  //   notifyListeners();
  // }
}