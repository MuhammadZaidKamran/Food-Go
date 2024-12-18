import 'package:flutter/material.dart';
import 'package:food_go/utils/Colors/colors.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  MyTextField({
    super.key,
    required this.controller,
    required this.label,
    this.prefixIcon,
    this.onTap,
    this.readOnly = false,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.prefixIconColor,
  });
  final TextEditingController controller;
  final String label;
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Color? prefixIconColor;
  bool? readOnly = false;
  bool? obscureText = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      keyboardType: keyboardType ?? TextInputType.text,
      obscureText: obscureText!,
      onTap: onTap,
      cursorColor: AppColors.darkMainTheme,
      controller: controller,
      readOnly: readOnly!,
      decoration: InputDecoration(
          hintMaxLines: 1,
          prefixIcon: prefixIcon,
          prefixIconColor: prefixIconColor,
          filled: true,
          fillColor: const Color.fromARGB(36, 0, 0, 0),
          hintText: label,
          hintStyle: TextStyle(color: AppColors.darkMainTheme),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20))),
    );
  }
}
