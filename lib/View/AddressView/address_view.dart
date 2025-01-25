import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:food_go/View/GoogleMapView/google_map_view.dart';
import 'package:food_go/ViewModel/AddressScreenViewModel/address_screen_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/MyButton/my_button.dart';
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
              child: Column(
                children: [
                  Expanded(
                    child: FirebaseAnimatedList(
                      query: viewModel.ref,
                      itemBuilder: (context, snapshot, animation, index) {
                        if (snapshot.exists) {
                          return Container(
                            margin: const EdgeInsets.only(top: 15),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            width: double.infinity,
                            height: getHeight(context, 0.12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: AppColors.mainTheme, width: 1.5)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      snapshot
                                          .child("destination")
                                          .value
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        viewModel.ref
                                            .child(snapshot.key.toString())
                                            .remove();
                                        viewModel.rebuildUi();
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: AppColors.darkMainTheme,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: AppColors.blackColor,
                                    ),
                                    width(getWidth(context, 0.02)),
                                    Expanded(
                                      child: Text(
                                        snapshot
                                            .child("address")
                                            .value
                                            .toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Center(
                            child: Text(
                              "No Address Found",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.blackColor,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  MyButton(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const GoogleMapView()));
                      },
                      label: "Add Delivery Address")
                ],
              ),
            ),
          );
        });
  }
}
