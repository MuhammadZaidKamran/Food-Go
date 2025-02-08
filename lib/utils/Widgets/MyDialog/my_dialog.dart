import 'package:flutter/material.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/MyButton/my_button.dart';

class MyDialog extends StatelessWidget {
  const MyDialog(
      {super.key,
      required this.image,
      required this.title,
      required this.onTapYes,
      required this.onTapNo,required this.isLoading});
  final String image;
  final String title;
  final VoidCallback onTapYes;
  final VoidCallback onTapNo;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: AppColors.whiteColor,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              image,
              scale: 3.5,
            ),
            height(getHeight(context, 0.02)),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            height(getHeight(context, 0.02)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyButton(
                  onTap: onTapNo,
                  label: "No",
                  buttonColor: AppColors.whiteColor,
                  borderColor: AppColors.darkMainTheme,
                  textColor: AppColors.blackColor,
                  width: getWidth(context, 0.34),
                ),
                MyButton(
                  isLoading: isLoading,
                  onTap: onTapYes,
                  label: "Yes",
                  width: getWidth(context, 0.34),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
