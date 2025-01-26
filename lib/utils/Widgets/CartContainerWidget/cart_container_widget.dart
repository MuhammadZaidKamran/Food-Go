import 'package:flutter/material.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';

class CartContainerWidget extends StatefulWidget {
  const CartContainerWidget(
      {super.key,
      required this.image,
      required this.itemName,
      required this.itemQuantity,
      required this.itemPrice,
      required this.onTapMinus,
      required this.onTapPlus,
      required this.onTapDelete});
  final String image;
  final String itemName;
  final String itemQuantity;
  final String itemPrice;
  final VoidCallback onTapMinus;
  final VoidCallback onTapPlus;
  final VoidCallback onTapDelete;

  @override
  State<CartContainerWidget> createState() => _CartContainerWidgetState();
}

class _CartContainerWidgetState extends State<CartContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Container(
        // padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12),
        ),
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(
              width: getWidth(context, 0.2),
              child: Image.asset(
                "assets/images/${widget.image}.png",
                scale: 5.5,
              ),
            ),
            width(getWidth(context, 0.015)),
            SizedBox(
              width: getWidth(context, 0.63),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: getWidth(context, 0.7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.itemName,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: widget.onTapDelete,
                          child: Icon(
                            Icons.delete,
                            color: AppColors.darkMainTheme,
                          ),
                        ),
                      ],
                    ),
                  ),
                  height(getHeight(context, 0.01)),
                  SizedBox(
                    width: getWidth(context, 0.7),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: widget.onTapMinus,
                          child: Image.asset(
                            "assets/images/minus_container.png",
                            scale: 5.5,
                          ),
                        ),
                        width(getWidth(context, 0.01)),
                        Text(
                          widget.itemQuantity,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        width(getWidth(context, 0.01)),
                        InkWell(
                          onTap: widget.onTapPlus,
                          child: Image.asset(
                            "assets/images/plus_container.png",
                            scale: 5.5,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "Rs.${widget.itemPrice}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
