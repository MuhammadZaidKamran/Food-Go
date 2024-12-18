import 'package:flutter/material.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      this.height,
      this.width,
      required this.onTap,
      required this.label});
  final double? height;
  final double? width;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 45,
        width: width ?? getWidth(context, 1),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.mainTheme),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
