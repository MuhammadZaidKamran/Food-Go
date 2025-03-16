import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_go/ViewModel/BottomNavBarViewModel/bottom_nav_bar_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:stacked/stacked.dart';

class BottomNavBarView extends StatelessWidget {
  const BottomNavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => BottomNavBarViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Center(
              child: viewModel.widgetList[viewModel.index],
            ),
            bottomNavigationBar: CurvedNavigationBar(
                height: 55,
                color: AppColors.mainTheme,
                backgroundColor: AppColors.whiteColor,
                index: viewModel.index,
                onTap: (value) {
                  viewModel.index = value;
                  viewModel.rebuildUi();
                },
                items: [
                  Icon(
                    Icons.home_outlined,
                    size: 30,
                    color: AppColors.whiteColor,
                  ),
                  Icon(
                    Icons.favorite_border_rounded,
                    size: 30,
                    color: AppColors.whiteColor,
                  ),
                  Icon(
                    Icons.account_circle_outlined,
                    size: 30,
                    color: AppColors.whiteColor,
                  ),
                ]),
          );
        });
  }
}
