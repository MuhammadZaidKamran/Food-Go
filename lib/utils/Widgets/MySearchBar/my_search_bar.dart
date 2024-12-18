import 'package:flutter/material.dart';
import 'package:food_go/utils/Colors/colors.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({super.key, required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      trailing: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.11,
          height: MediaQuery.of(context).size.height * 0.05,
          child: InkWell(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.mainTheme),
              child: Icon(
                Icons.search,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ),
      ],
      elevation: const WidgetStatePropertyAll(5),
      backgroundColor: const WidgetStatePropertyAll(Color(0xffffffff)),
      shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 12, vertical: 8.5)),
      leading: Image.asset(
        "assets/images/search.png",
        scale: 1.2,
      ),
      hintText: label,
      hintStyle: const WidgetStatePropertyAll(
          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
    );
  }
}
