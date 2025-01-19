import 'package:flutter/material.dart';
import 'package:food_go/ViewModel/AddressScreenViewModel/address_screen_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:stacked/stacked.dart';

class AddressView extends StatelessWidget {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => AddressScreenViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Address"),
              centerTitle: true,
            ),
            body: Padding(
              padding: myPadding(),
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    height(getHeight(context, 0.02)),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    width: double.infinity,
                    height: getHeight(context, 0.12),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.mainTheme, width: 2)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Home",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.delete,
                                color: AppColors.darkMainTheme,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          userCurrentAddress ?? "No Address Found",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}
