import 'package:flutter/material.dart';
import 'package:food_go/utils/Colors/colors.dart';

class OrderSuccessfulWidget extends StatelessWidget {
  const OrderSuccessfulWidget(
      {super.key, required this.title, required this.amount});
  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor,
          ),
        ),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
      ],
    );
  }
}
