import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rebix_test_project/components/components.dart';

class TextFeild2 extends StatelessWidget {
  const TextFeild2({
    Key? key,
    required this.labelText,
    required this.hintText,
    // required this.prefixIcon,
    required this.controller,
    required this.obscureText,
    required this.keyboardType,
    required this.validator,
    required this.focusNode,
    required this.textDirection,
    required this.onFieldSubmitted,
  }) : super(key: key);

  final String labelText;
  final String hintText;
  // final Icon prefixIcon;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final FormFieldValidator<String> validator;
  final FocusNode focusNode;
  final TextDirection textDirection;
  final FocusNode? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      textDirection: textDirection,
      style: CustomTextStyle.bodyText1(context),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0.sp),
        ),
        labelText: " $labelText ",
        labelStyle: CustomTextStyle.bodyText1(context).copyWith(fontSize: 22.sp, fontWeight: FontWeight.bold),
        hintText: hintText,
        hintStyle: CustomTextStyle.bodyText1(context).copyWith(
          fontSize: 13.sp,
          color: Colors.grey
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0.sp),
          borderSide: const BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0.sp),
          borderSide: BorderSide(color: Colors.black12, width: 1.5.sp),
        ),
        // prefixIcon: prefixIcon
      ),
      focusNode: focusNode,
      onFieldSubmitted: (String value) {
        FocusScope.of(context).requestFocus(onFieldSubmitted!);
      },
    );
  }
}