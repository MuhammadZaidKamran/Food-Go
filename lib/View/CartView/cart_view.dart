import 'package:flutter/material.dart';
import 'package:food_go/ViewModel/CartViewModel/cart_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/CartContainerWidget/cart_container_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onViewModelReady: (viewModel) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          for (int i = 0; i < quantity.length; i++) {
            quantity[i] = prefs.getInt("quantity_$i") ?? 0;
          }
          for (var i = 0; i < isAdded.length; i++) {
            isAdded[i] = prefs.getBool("isAdded_$i") ?? false;
          }
        },
        viewModelBuilder: () => CartViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Cart"),
              centerTitle: true,
            ),
            body: FutureBuilder(
                future: viewModel.userCart.doc(userDetails!.uid).get(),
                builder: (context, snapshot) {
                  return ListView.separated(
                      itemCount: snapshot.data?.get("cartItems").length ?? 0,
                      separatorBuilder: (context, index) => height(10),
                      itemBuilder: (context, index) {
                        final item =
                            snapshot.data?.get("cartItems")[index] ?? {};
                        if (snapshot.hasData) {
                          return CartContainerWidget(
                            image: item["image"],
                            itemName: item["itemName"],
                            itemQuantity: "${item["itemQuantity"]}",
                            itemPrice: item["itemPrice"],
                            onTapMinus: () async {
                              if (quantity[item["index"]] > 0) {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                quantity[item["index"]]--;
                                if (quantity[item["index"]] == 0) {
                                  cartItems.removeWhere(
                                      (e) => e["itemID"] == item["itemID"]);
                                  prefs.setBool(
                                      "isAdded_${item["index"]}", false);
                                  prefs.getBool("isAdded_${item["index"]}");
                                }
                                prefs.setInt("quantity_${item["index"]}",
                                    quantity[item["index"]]);
                                prefs.getInt("quantity_${item["index"]}");
                                cartItems
                                    .where((e) => e["itemID"] == item["itemID"])
                                    .forEach((element) {
                                  element["itemQuantity"] =
                                      quantity[item["index"]];
                                });
                                await viewModel.updateUser();
                                viewModel.rebuildUi();
                              }
                            },
                            onTapPlus: () async {
                              quantity[item["index"]]++;
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setInt("quantity_${item["index"]}",
                                  quantity[item["index"]]);
                              prefs.getInt("quantity_${item["index"]}");
                              cartItems
                                  .where((e) => e["itemID"] == item["itemID"])
                                  .forEach((element) {
                                element["itemQuantity"] =
                                    quantity[item["index"]];
                              });
                              await viewModel.updateUser();
                              viewModel.rebuildUi();
                            },
                            onTapDelete: () async {
                              cartItems.removeWhere(
                                  (e) => e["itemID"] == item["itemID"]);
                              quantity[item["index"]] = 0;
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool("isAdded_${item["index"]}", false);
                              prefs.getBool("isAdded_${item["index"]}");
                              prefs.setInt("quantity_${item["index"]}",
                                  quantity[item["index"]]);
                              prefs.getInt("quantity_${item["index"]}");
                              cartItems
                                  .where((e) => e["itemID"] == item["itemID"])
                                  .forEach((element) {
                                element["itemQuantity"] =
                                    quantity[item["index"]];
                              });
                              await viewModel.updateUser();
                              viewModel.rebuildUi();
                            },
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.mainTheme,
                            ),
                          );
                        }
                      });
                }),
          );
        });
  }
}
