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
      this.isLoading = false});
  final double? height;
  final double? width;
  final String label;
  final VoidCallback onTap;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 50,
        width: width ?? getWidth(context, 1),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.darkMainTheme),
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
                      color: AppColors.whiteColor,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }
}
