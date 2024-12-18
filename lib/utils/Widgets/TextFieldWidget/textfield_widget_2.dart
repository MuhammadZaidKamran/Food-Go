import 'package:flutter/material.dart';
import 'package:food_go/utils/Colors/colors.dart';

Widget textField_2(
    String hint, IconData prefix, TextEditingController textfieldController) {
  return TextFormField(
    cursorColor: AppColors.darkMainTheme,
    controller: textfieldController,
    decoration: InputDecoration(
        prefixIcon: Icon(
          prefix,
          color: AppColors.darkMainTheme,
        ),
        filled: true,
        fillColor: const Color.fromARGB(36, 0, 0, 0),
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.darkMainTheme),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20))),
  );
}
