import 'package:flutter/material.dart';
import 'package:food_go/utils/Colors/colors.dart';

Widget textField_3(
    String hint, IconData prefix, TextEditingController textfield_controller) {
  return TextFormField(
    cursorColor: AppColors.darkRed,
    controller: textfield_controller,
    decoration: InputDecoration(
        prefixIcon: Icon(
          prefix,
          color: AppColors.darkRed,
        ),
        filled: true,
        fillColor: const Color.fromARGB(36, 0, 0, 0),
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.darkRed),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20))),
  );
}
