import 'package:flutter/material.dart';
import 'package:food_go/Admin/FoodCombos/food_combo.dart';
import 'package:food_go/Admin/FoodItems/food_items.dart';
import 'package:food_go/Admin/home_screen_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeScreenViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Admin"),
            centerTitle: true,
          ),
          body: Padding(
            padding: myPadding(),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FoodItems(),
                        ));
                  },
                  child: Container(
                    padding: myPadding(),
                    width: getWidth(context, 1),
                    decoration: BoxDecoration(
                      color: AppColors.mainTheme,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "All Items",
                        style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                height(getHeight(context, 0.02)),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FoodCombo(),
                        ));
                  },
                  child: Container(
                    padding: myPadding(),
                    width: getWidth(context, 1),
                    decoration: BoxDecoration(
                      color: AppColors.mainTheme,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Combo Items",
                        style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
