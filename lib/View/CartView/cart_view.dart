import 'package:flutter/material.dart';
import 'package:food_go/View/BottomNavBarView/bottom_nav_bar_view.dart';
import 'package:food_go/View/ConfirmAddressView/confirm_address_view.dart';
import 'package:food_go/ViewModel/CartViewModel/cart_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Global/stripe_service.dart';
import 'package:food_go/utils/Widgets/CartContainerWidget/cart_container_widget.dart';
import 'package:food_go/utils/Widgets/CartRowWidget/cart_row_widget.dart';
import 'package:food_go/utils/Widgets/MyButton/my_button.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class CartView extends StatelessWidget {
  const CartView(
      {super.key, this.goBack = false, this.data, this.confirmAddress = false});
  final bool? goBack;
  // ignore: prefer_typing_uninitialized_variables
  final data;
  final bool? confirmAddress;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onViewModelReady: (viewModel) async {
          if (confirmAddress == true) {
            final controller = await viewModel.googleMapController.future;
            List<Location> location =
                await locationFromAddress(data.toString());
            List<Placemark> placeMarks = await placemarkFromCoordinates(
                location.first.latitude, location.first.longitude);
            viewModel.markers.add(Marker(
              markerId: const MarkerId("2"),
              position:
                  LatLng(location.first.latitude, location.first.longitude),
              infoWindow: InfoWindow(
                  title:
                      "${placeMarks.first.street} ${placeMarks.first.locality} ${placeMarks.first.postalCode} ${placeMarks.first.country}"),
            ));
            controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(
                        location.first.latitude, location.first.longitude),
                    zoom: 14)));
            viewModel.rebuildUi();
          } else {
            return null;
          }
          SharedPreferences prefs = await SharedPreferences.getInstance();
          for (int i = 0; i < quantity.length; i++) {
            quantity[i] = prefs.getInt("quantity_$i") ?? 0;
          }
          // for (var i = 0; i < isAdded.length; i++) {
          //   isAdded[i] = prefs.getBool("isAdded_$i") ?? false;
          // }
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
            body: SingleChildScrollView(
              child: Padding(
                padding: myPadding(),
                child: Column(
                  children: [
                    confirmAddress == true
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Order Summary",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor,
                              ),
                            ),
                          )
                        : const SizedBox(),
                    confirmAddress == true ? height(12) : const SizedBox(),
                    FutureBuilder(
                        future: viewModel.userCart.doc(userDetails!.uid).get(),
                        builder: (context, snapshot) {
                          if (cartItems.isNotEmpty) {
                            return Material(
                              elevation: 3,
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                // height: getHeight(context, 0.4),
                                decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: AppColors.darkMainTheme)),
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data
                                            ?.get("cartItems")
                                            .length ??
                                        0,
                                    separatorBuilder: (context, index) =>
                                        height(10),
                                    itemBuilder: (context, index) {
                                      final item = snapshot.data
                                              ?.get("cartItems")[index] ??
                                          {};
                                      if (snapshot.hasData) {
                                        return CartContainerWidget(
                                          isConfirmed: confirmAddress!,
                                          image: item["image"],
                                          itemName: item["itemName"],
                                          itemQuantity:
                                              "${item["itemQuantity"]}",
                                          itemPrice:
                                              item["itemPrice"].toString(),
                                          onTapMinus: () async {
                                            if (quantity[item["index"]] > 0) {
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              quantity[item["index"]]--;
                                              if (quantity[item["index"]] ==
                                                  0) {
                                                cartItems.removeWhere((e) =>
                                                    e["itemID"] ==
                                                    item["itemID"]);
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
                                                      e["itemID"] ==
                                                      item["itemID"])
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
                                                    e["itemID"] ==
                                                    item["itemID"])
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
                                                "isAdded_${item["index"]}",
                                                false);
                                            prefs.getBool(
                                                "isAdded_${item["index"]}");
                                            prefs.setInt(
                                                "quantity_${item["index"]}",
                                                quantity[item["index"]]);
                                            prefs.getInt(
                                                "quantity_${item["index"]}");
                                            cartItems
                                                .where((e) =>
                                                    e["itemID"] ==
                                                    item["itemID"])
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
                          } else {
                            return const SizedBox();
                          }
                        }),
                    cartItems.isNotEmpty
                        ? height(getHeight(context, 0.04))
                        : const SizedBox(),
                    cartItems.isNotEmpty
                        ? Column(
                            children: [
                              CartRowWidget(
                                  title: "Subtotal",
                                  price:
                                      "Rs.${viewModel.totalAmount().toString()}"),
                              height(getHeight(context, 0.02)),
                              CartRowWidget(
                                  title: "Platform Fee",
                                  price: "Rs.${platformCharges.toString()}"),
                              height(getHeight(context, 0.02)),
                              CartRowWidget(
                                  title: "Delivery Fee",
                                  price: "Rs.${deliveryCharges.toString()}"),
                              height(getHeight(context, 0.02)),
                              CartRowWidget(
                                  title: "Total",
                                  price:
                                      "Rs.${int.parse(viewModel.totalAmount().toString()) + platformCharges + deliveryCharges}"),
                              height(getHeight(context, 0.04)),
                              TextFormField(
                                controller: viewModel.addNoteController,
                                onTapOutside: (event) {
                                  FocusScope.of(context).unfocus();
                                },
                                maxLines: 3,
                                decoration: InputDecoration(
                                  hintText: "Add a note",
                                  fillColor: AppColors.whiteColor,
                                  filled: true,
                                  hintStyle:
                                      TextStyle(color: AppColors.borderColor),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.darkMainTheme),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.darkMainTheme),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              confirmAddress == true
                                  ? height(getHeight(context, 0.04))
                                  : height(getHeight(context, 0)),
                              confirmAddress == true
                                  ? Container(
                                      width: getWidth(context, 1),
                                      // height: getHeight(context, 0.2),
                                      decoration: BoxDecoration(
                                          color: AppColors.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 15,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.toString(),
                                              style: TextStyle(
                                                  color: AppColors.blackColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            height(getHeight(context, 0.01)),
                                            SizedBox(
                                              height: getHeight(context, 0.18),
                                              width: getWidth(context, 1),
                                              child: GoogleMap(
                                                mapType: MapType.normal,
                                                zoomControlsEnabled: false,
                                                initialCameraPosition:
                                                    viewModel.initialPosition,
                                                markers: Set<Marker>.of(
                                                    viewModel.markers),
                                                onMapCreated: (controller) {
                                                  viewModel.googleMapController
                                                      .complete(controller);
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              height(getHeight(context, 0.04)),
                              MyButton(
                                onTap: () async {
                                  if (confirmAddress == true) {
                                    final totalAmount = int.parse(viewModel
                                            .totalAmount()
                                            .toString()) +
                                        int.parse(platformCharges.toString()) +
                                        int.parse(deliveryCharges.toString());
                                    await StripeService.instance.makePayment(
                                        amount: int.parse(
                                          totalAmount.toString(),
                                        ),
                                        address: data.toString(),
                                        platformFee: platformCharges.toString(),
                                        deliveryCharges: deliveryCharges.toString(),
                                        totalAmount: int.parse(
                                          totalAmount.toString(),
                                        ),
                                        note: viewModel.addNoteController.text,
                                        context: context);

                                    
                                  } else {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ConfirmAddressView()));
                                  }
                                },
                                label: confirmAddress == true
                                    ? "Confirm Payment"
                                    : "Confirm Your Address",
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
