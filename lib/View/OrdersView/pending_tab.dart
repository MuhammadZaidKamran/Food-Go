import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go/View/OrderSuccessfulView/order_successful_view.dart';
import 'package:food_go/ViewModel/OrdersViewModel/pending_tab_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/MyButton/my_button.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

class PendingTab extends StatelessWidget {
  const PendingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) async {
        // final controller = await viewModel.googleMapController.future;
        viewModel.orderDetails.snapshots().listen((snapshot) async {
          viewModel.displayOrderList = snapshot.docs.where((
            e) => e["status"] == 0).toList();
          viewModel.markers.clear(); // Clear old markers

          for (var order in snapshot.docs) {
            if (order["userID"] == FirebaseAuth.instance.currentUser!.uid) {
              String address = order["address"];

              try {
                List<Location> locations = await locationFromAddress(address);

                if (locations.isNotEmpty) {
                  LatLng position = LatLng(
                      locations.first.latitude, locations.first.longitude);

                  // Create a unique marker for each order
                  viewModel.markers.add(Marker(
                    markerId: MarkerId(order.id), // Unique MarkerId
                    position: position,
                    infoWindow: InfoWindow(
                      title: "Order #${order["orderId"]}",
                      snippet: order["address"],
                    ),
                  ));

                  // Store the camera position for later use
                  viewModel.orderCameraPositions[order.id] = CameraPosition(
                    target: position,
                    zoom: 14,
                  );
                }
              } catch (e) {
                print("Error fetching location for $address: $e");
              }
            }
          }

          viewModel.rebuildUi();
          
        });
      },
      viewModelBuilder: () => PendingTabViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          // appBar: AppBar(
          //   title: const Text("Orders"),
          //   centerTitle: true,
          // ),
          body: ListView.separated(
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
                      SizedBox(
                        width: getWidth(context, 1),
                        height: 100,
                        child: GoogleMap(
                          initialCameraPosition:
                              viewModel.orderCameraPositions != null &&
                                      viewModel.orderCameraPositions
                                          .containsKey(orderDetails.id)
                                  ? viewModel.orderCameraPositions[
                                      orderDetails
                                          .id]! // Use saved position
                                  : const CameraPosition(
                                      target: LatLng(0, 0),
                                      zoom: 14), // Default
          
                          onMapCreated: (controller) async {
                            if (viewModel.orderCameraPositions != null &&
                                viewModel.orderCameraPositions
                                    .containsKey(orderDetails.id)) {
                              await Future.delayed(const Duration(
                                  milliseconds:
                                      500)); // Delay for smooth loading
                              controller.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                viewModel
                                    .orderCameraPositions[orderDetails.id]!,
                              ));
                            }
                          },
                          zoomControlsEnabled: false,
                          mapType: MapType.normal,
                          markers: {
                            viewModel.markers.firstWhere(
                              (marker) =>
                                  marker.markerId.value == orderDetails.id,
                              orElse: () => const Marker(
                                  markerId: MarkerId("default"),
                                  position: LatLng(0, 0)),
                            ),
                          },
                        ),
                      ),
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
                                  fromPending: true,
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
          ),
        );
      },
    );
  }
}
