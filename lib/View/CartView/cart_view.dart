import 'package:flutter/material.dart';
import 'package:food_go/View/BottomNavBarView/bottom_nav_bar_view.dart';
import 'package:food_go/View/ConfirmAddressView/confirm_address_view.dart';
import 'package:food_go/ViewModel/CartViewModel/cart_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/CartContainerWidget/cart_container_widget.dart';
import 'package:food_go/utils/Widgets/CartRowWidget/cart_row_widget.dart';
import 'package:food_go/utils/Widgets/MyButton/my_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class CartView extends StatelessWidget {
  const CartView({super.key, this.goBack = false, this.data});
  final bool? goBack;
  final data;

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
              leading: goBack == true
                  ? InkWell(
                      onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BottomNavBarView())),
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.blackColor,
                      ),
                    )
                  : null,
              title: const Text("Cart"),
              centerTitle: true,
            ),
            body: Padding(
              padding: myPadding(),
              child: Column(
                children: [
                  FutureBuilder(
                      future: viewModel.userCart.doc(userDetails!.uid).get(),
                      builder: (context, snapshot) {
                        return Material(
                          elevation: 3,
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            // height: getHeight(context, 0.4),
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: AppColors.darkMainTheme)),
                            child: ListView.separated(
                                shrinkWrap: true,
                                itemCount:
                                    snapshot.data?.get("cartItems").length ?? 0,
                                separatorBuilder: (context, index) =>
                                    height(10),
                                itemBuilder: (context, index) {
                                  final item =
                                      snapshot.data?.get("cartItems")[index] ??
                                          {};
                                  if (snapshot.hasData) {
                                    return CartContainerWidget(
                                      image: item["image"],
                                      itemName: item["itemName"],
                                      itemQuantity: "${item["itemQuantity"]}",
                                      itemPrice: item["itemPrice"].toString(),
                                      onTapMinus: () async {
                                        if (quantity[item["index"]] > 0) {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          quantity[item["index"]]--;
                                          if (quantity[item["index"]] == 0) {
                                            cartItems.removeWhere((e) =>
                                                e["itemID"] == item["itemID"]);
                                            prefs.setBool(
                                                "isAdded_${item["index"]}",
                                                false);
                                            prefs.getBool(
                                                "isAdded_${item["index"]}");
                                          }
                                          prefs.setInt(
                                              "quantity_${item["index"]}",
                                              quantity[item["index"]]);
                                          prefs.getInt(
                                              "quantity_${item["index"]}");
                                          cartItems
                                              .where((e) =>
                                                  e["itemID"] == item["itemID"])
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
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.setInt(
                                            "quantity_${item["index"]}",
                                            quantity[item["index"]]);
                                        prefs.getInt(
                                            "quantity_${item["index"]}");
                                        cartItems
                                            .where((e) =>
                                                e["itemID"] == item["itemID"])
                                            .forEach((element) {
                                          element["itemQuantity"] =
                                              quantity[item["index"]];
                                        });
                                        await viewModel.updateUser();
                                        viewModel.rebuildUi();
                                      },
                                      onTapDelete: () async {
                                        cartItems.removeWhere((e) =>
                                            e["itemID"] == item["itemID"]);
                                        quantity[item["index"]] = 0;
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.setBool(
                                            "isAdded_${item["index"]}", false);
                                        prefs.getBool(
                                            "isAdded_${item["index"]}");
                                        prefs.setInt(
                                            "quantity_${item["index"]}",
                                            quantity[item["index"]]);
                                        prefs.getInt(
                                            "quantity_${item["index"]}");
                                        cartItems
                                            .where((e) =>
                                                e["itemID"] == item["itemID"])
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
                                }),
                          ),
                        );
                      }),
                  height(getHeight(context, 0.04)),
                  Column(
                    children: [
                      CartRowWidget(
                          title: "Subtotal",
                          price: "Rs.${viewModel.totalAmount().toString()}"),
                      height(getHeight(context, 0.02)),
                      CartRowWidget(
                          title: "Platform Fee",
                          price: "Rs.${platformCharges.toString()}"),
                      height(getHeight(context, 0.02)),
                      const CartRowWidget(title: "Delivery Fee", price: "Rs.0"),
                      height(getHeight(context, 0.02)),
                      CartRowWidget(
                          title: "Total",
                          price:
                              "Rs.${int.parse(viewModel.totalAmount().toString()) + platformCharges}"),
                      height(getHeight(context, 0.04)),
                      TextFormField(
                        controller: viewModel.addNoteController,
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Add a note",
                          fillColor: AppColors.whiteColor,
                          filled: true,
                          hintStyle: TextStyle(color: AppColors.borderColor),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.darkMainTheme),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.darkMainTheme),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      height(getHeight(context, 0.06)),
                      MyButton(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ConfirmAddressView()));
                        },
                        label: "Confirm Your Address",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
