import 'package:flutter/material.dart';
import 'package:food_go/utils/Colors/colors.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Icon(
          icon,
          size: 25,
          color: AppColors.whiteColor,
        ),
        title: Text(
          title,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: AppColors.whiteColor),
        ),
      ),
    );
  }
}
