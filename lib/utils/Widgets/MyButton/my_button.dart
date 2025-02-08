import 'package:flutter/material.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  MyButton(
      {super.key,
      this.height,
      this.width,
      required this.onTap,
      required this.label,
      this.isLoading = false,
      this.borderRadius,
      this.buttonColor,
      this.borderColor, this.textColor});
  final double? height;
  final double? width;
  final String label;
  final VoidCallback onTap;
  final BorderRadius? borderRadius;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 50,
        width: width ?? getWidth(context, 1),
        decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            border: Border.all(color: borderColor ?? Colors.transparent),
            color: buttonColor ?? AppColors.darkMainTheme),
        child: Center(
          child: isLoading
              ? Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: AppColors.mainTheme,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.whiteColor),
                  ),
                )
              : Text(
                  label,
                  style: TextStyle(
                      color: textColor ?? AppColors.whiteColor,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }
}
