import 'package:flutter/material.dart';


class CustomTextStyle {
  static TextStyle headline6(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
        fontFamily: "IranSans"
    );
  }

  static TextStyle bodyText1(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
        fontFamily: "IranSans"
    );
  }
}



String moneyMask(String str) {
  String newStr = '';
  int step = 3;
  for (int i = str.length; i >= 0; i -= step) {
    String subString ='';
    if (i > 3) {
      subString += "،";
    }
    subString += str.substring( i < step ? 0 : i - step, i);
    newStr = subString + newStr;
  }
  return newStr;
}

