import 'package:flutter/material.dart';
import 'package:food_go/utils/Colors/colors.dart';

class PlusMinusContainer extends StatefulWidget {
  const PlusMinusContainer(
      {super.key,
      required this.onTapPlus,
      required this.onTapMinus,
      required this.text});
  final VoidCallback onTapPlus;
  final VoidCallback onTapMinus;
  final String text;

  @override
  State<PlusMinusContainer> createState() => _PlusMinusContainerState();
}

class _PlusMinusContainerState extends State<PlusMinusContainer> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: widget.onTapMinus,
          child: Image.asset(
            "assets/images/minus_container.png",
            scale: 3,
          ),
        ),
        Expanded(
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.only(bottom: 7, top: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.whiteColor),
              child: Center(
                child: Text(
                  widget.text,
                  style: TextStyle(color: AppColors.blackColor, fontSize: 20),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: widget.onTapPlus,
          child: Image.asset(
            "assets/images/plus_container.png",
            scale: 3,
          ),
        ),
      ],
    );
  }
}
