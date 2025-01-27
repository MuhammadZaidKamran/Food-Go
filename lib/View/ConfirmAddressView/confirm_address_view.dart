import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:food_go/View/CartView/cart_view.dart';
import 'package:food_go/View/GoogleMapView/google_map_view.dart';
import 'package:food_go/ViewModel/ConfirmAddressViewModel/confirm_address_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/MyButton/my_button.dart';
import 'package:stacked/stacked.dart';

class ConfirmAddressView extends StatelessWidget {
  const ConfirmAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => ConfirmAddressViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Address",
                style: TextStyle(color: Colors.black),
              ),
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
                        // if (index == 0) {
                        //   final firstItemId =
                        //       snapshot.child("id").value.toString();
                        //   viewModel.selectedKey = firstItemId;
                        // }

                        // viewModel.selectedKey = snapshot.key!.indexOf();

                        if (snapshot.exists) {
                          if (index == 0) {
                            final firstItemId =
                                snapshot.child("address").value.toString();
                            viewModel.selectedAddress =
                                firstItemId; // viewModel.rebuildUi();
                          }
                          // print(viewModel.selectedKey.toString());
                          // viewModel.selectedKey = snapshot.key.toString();
                          return GestureDetector(
                            onTap: () {
                              viewModel.selectedAddress = null;
                              viewModel.myIndex = index;
                              viewModel.rebuildUi();
                              viewModel.selectedAddress =
                                  snapshot.child("address").value.toString();
                              viewModel.selectedSecondAddress =
                                  viewModel.selectedAddress;
                              print(viewModel.selectedSecondAddress.toString());
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 15),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              width: double.infinity,
                              height: getHeight(context, 0.12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: viewModel.myIndex == index
                                    ? Border.all(
                                        color: AppColors.mainTheme, width: 1.5)
                                    : null,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                        // final selectedId = viewModel.selectedKey;
                        // if (viewModel.myIndex == 0) {
                        //   viewModel
                        // }
                        // final data = viewModel.ref.child(viewModel.selectedKey);
                        // print(selectedId.toString());
                        if (viewModel.myIndex == 0) {
                          print(viewModel.selectedAddress.toString());
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartView(
                                        data: viewModel.selectedAddress,
                                        confirmAddress: true,
                                      )));
                        } else {
                          print(viewModel.selectedSecondAddress.toString());
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartView(
                                        data: viewModel.selectedSecondAddress,
                                        confirmAddress: true,
                                      )));
                        }
                      },
                      label: "Go to Checkout"),
                  height(getHeight(context, 0.02)),
                  MyButton(
                      onTap: () {
                        fromAddress = true;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GoogleMapView(
                                      isReceive: fromAddress,
                                    )));
                      },
                      label: "Add Delivery Address")
                ],
              ),
            ),
          );
        });
  }
}
