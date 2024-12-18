import 'package:flutter/material.dart';
import 'package:food_go/utils/Colors/colors.dart';

class MyTabBar extends StatelessWidget {
  const MyTabBar(
      {super.key,
      required this.tabOne,
      required this.tabTwo,
      this.tabThree,
      this.tabFour,
      this.isScroll});
  final String tabOne;
  final String tabTwo;
  final String? tabThree;
  final String? tabFour;
  final bool? isScroll;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: AppColors.whiteColor,
            border:
                Border.all(color: const Color(0xffd4d4d4).withOpacity(0.5))),
        child: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            dividerHeight: 0,
            indicator: BoxDecoration(
              color: AppColors.mainTheme,
              borderRadius: BorderRadius.circular(30),
            ),
            labelColor: AppColors.whiteColor,
            unselectedLabelColor: AppColors.mainTheme,
            padding: const EdgeInsets.all(5),
            tabAlignment: isScroll == true ? TabAlignment.center : null,
            labelStyle: const TextStyle(fontSize: 14),
            tabs: [
              Tab(text: tabOne),
              Tab(text: tabTwo),
              if (tabThree != null) Tab(text: tabThree),
              if (tabFour != null) Tab(text: tabFour),
            ]),
      ),
    );
  }
}
