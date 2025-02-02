import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go/View/OrderSuccessfulView/order_successful_view.dart';
import 'package:food_go/ViewModel/OrdersViewModel/orders_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/MyButton/my_button.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) async {
        // final controller = await viewModel.googleMapController.future;
        viewModel.orderDetails.snapshots().listen((snapshot) async {
          viewModel.displayOrderList = snapshot.docs.toList();
          viewModel.address = snapshot.docs
              .where(
                  (e) => e["userID"] == FirebaseAuth.instance.currentUser!.uid)
              .map((e) => e["address"])
              .toList();
          print(viewModel.address);
          viewModel.address.forEach((e) async {
            List<Location> location = await locationFromAddress(e.toString());
            // var addressList;
            // addressList.add({location.first.latitude, location.first.longitude});
            // print(addressList.toString());
            viewModel.markers.add(Marker(
                markerId: const MarkerId("2"),
                position:
                    LatLng(location.first.latitude, location.first.longitude)));
            print(location.first.latitude.toString());
            //         controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            //   target: LatLng(location.first.latitude, location.first.longitude),
            //   zoom: 14,

            //   // bearing: 45.0,
            // )));
            print(viewModel.markers.toString());
            // var newAdress
          });
          // List<Location> location =
          //     await locationFromAddress(e["address"].toString());
          //
          // // viewModel.address = ;
          // print(viewModel.address);
          // print(location.first.latitude.toString());
          // await viewModel.getLocation(viewModel.address);

          viewModel.rebuildUi();
        });
      },
      viewModelBuilder: () => OrdersViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Orders"),
            centerTitle: true,
          ),
          body: Padding(
              padding: myPadding(),
              child: ListView.separated(
                itemCount: viewModel.displayOrderList.length,
                separatorBuilder: (context, index) =>
                    height(getHeight(context, 0.03)),
                itemBuilder: (context, index) {
                  DocumentSnapshot orderDetails =
                      viewModel.displayOrderList[index];
                  return Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Order No: #${orderDetails["orderId"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blackColor,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: orderDetails["status"] == 0
                                      ? const Color.fromARGB(255, 228, 171, 0)
                                      : orderDetails["status"] == 1
                                          ? Colors.red
                                          : orderDetails["status"] == 2
                                              ? Colors.green
                                              : Colors.amber,
                                ),
                                child: Center(
                                    child: Text(
                                  orderDetails["status"] == 0
                                      ? "Pending"
                                      : orderDetails["status"] == 1
                                          ? "Cancelled"
                                          : orderDetails["status"] == 2
                                              ? "Completed"
                                              : "Pending",
                                  style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                )),
                              ),
                            ],
                          ),
                          height(getHeight(context, 0.01)),
                          Container(
                              width: getWidth(context, 1),
                              height: 100,
                              child: GoogleMap(
                                initialCameraPosition:
                                    viewModel.initialPosition,
                                onMapCreated: (controller) {
                                  // viewModel.googleMapController
                                  //     .complete(controller);
                                },
                                mapType: MapType.normal,
                                markers: Set<Marker>.of(viewModel.markers),
                              )),
                          height(getHeight(context, 0.01)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: AppColors.blackColor,
                              ),
                              Expanded(
                                child: Text(
                                  orderDetails["address"].toString(),
                                  style: const TextStyle(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          height(getHeight(context, 0.01)),
                          MyButton(
                            borderRadius: BorderRadius.circular(10),
                            height: 40,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderSuccessfulView(
                                      status: orderDetails["status"],
                                      date: orderDetails["date"],
                                      orderId: orderDetails["orderId"],
                                      userId: orderDetails["userID"],
                                      orderConfirmedList:
                                          orderDetails["orderItems"],
                                      address: orderDetails["address"],
                                      platformFee: orderDetails["platFormFee"],
                                      deliveryCharges:
                                          orderDetails["deliveryCharges"],
                                      totalAmount: orderDetails["totalAmount"],
                                      note: orderDetails["note"],
                                    ),
                                  ));
                            },
                            label: "View Order Details",
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )),
        );
      },
    );
  }
}
