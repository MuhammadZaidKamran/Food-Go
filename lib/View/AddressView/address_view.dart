// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';
// import 'package:food_go/View/GoogleMapView/google_map_view.dart';
// import 'package:food_go/ViewModel/AddressScreenViewModel/address_screen_view_model.dart';
// import 'package:food_go/utils/Colors/colors.dart';
// import 'package:food_go/utils/Global/global.dart';
// import 'package:food_go/utils/Widgets/MyButton/my_button.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:stacked/stacked.dart';

// class AddressView extends StatelessWidget {
//   const AddressView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder.reactive(
//       onViewModelReady: (viewModel) async {
//         viewModel.ref.onValue.listen((snapshot) async {
//           debugPrint(snapshot.snapshot.child("latitude").value.toString());
//           viewModel.deliveryAddress = snapshot.snapshot.value ?? {};

//           debugPrint(viewModel.deliveryAddress.toString());

//           // Clear the previous data before adding new ones
//           viewModel.placesName.clear();

//           // Process each address
//           for (var entry in viewModel.deliveryAddress.entries) {
//             var value = entry.value;

//             try {
//               debugPrint(value["latitude"].toString());
//               List<Placemark> placeMarks = await placemarkFromCoordinates(
//                 value["latitude"],
//                 value["longitude"],
//               );

//               // Add the place to placesName list
//               viewModel.placesName.add(placeMarks.first.toJson());
//               debugPrint(viewModel.placesName.toString());
//             } catch (e) {
//               debugPrint("Error fetching placemark: $e");
//             }
//           }
//         });
//       },
//       viewModelBuilder: () => AddressScreenViewModel(),
//       builder: (context, viewModel, child) {
//         return Scaffold(
//           appBar: AppBar(
//             title: const Text("Address"),
//             centerTitle: true,
//           ),
//           body: Padding(
//             padding: myPadding(),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: viewModel.placesName.isEmpty
//                       ? Center(
//                           child: CircularProgressIndicator(),
//                         )
//                       : FirebaseAnimatedList(
//                           query: viewModel.ref,
//                           itemBuilder: (context, snapshot, animation, index) {
//                             // Check if index is valid
//                             if (index >= viewModel.placesName.length) {
//                               return SizedBox.shrink();
//                             }

//                             // Safely access the data
//                             final address = viewModel.placesName[index];
//                             return Container(
//                               margin: const EdgeInsets.only(top: 15),
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 10, horizontal: 10),
//                               width: double.infinity,
//                               height: getHeight(context, 0.12),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                     color: AppColors.mainTheme, width: 1.5),
//                               ),
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         snapshot
//                                             .child("destination")
//                                             .value
//                                             .toString(),
//                                         style: TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.w500,
//                                           color: AppColors.blackColor,
//                                         ),
//                                       ),
//                                       InkWell(
//                                         onTap: () {
//                                           // Add delete functionality if needed
//                                         },
//                                         child: Icon(
//                                           Icons.delete,
//                                           color: AppColors.darkMainTheme,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Icon(
//                                         Icons.location_on,
//                                         color: AppColors.blackColor,
//                                       ),
//                                       width(getWidth(context, 0.02)),
//                                       Expanded(
//                                         child: Text(
//                                           "${address["street"] ?? "Unknown Street"}, "
//                                           "${address["locality"] ?? "Unknown Locality"}, "
//                                           "${address["postalCode"] ?? "Unknown Postal Code"}, "
//                                           "${address["country"] ?? "Unknown Country"}",
//                                           maxLines: 2,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold,
//                                             color: AppColors.blackColor,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                 ),
//                 MyButton(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => GoogleMapView()),
//                     );
//                   },
//                   label: "Add Delivery Address",
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:food_go/View/GoogleMapView/google_map_view.dart';
import 'package:food_go/ViewModel/AddressScreenViewModel/address_screen_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/MyButton/my_button.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class AddressView extends StatelessWidget {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onViewModelReady: (viewModel) async {
          await getData().then((value) {
            debugPrint(viewModel.newAddressName.toString());
          });
          // viewModel.placesName = (prefs.get("address") as List<String>?) ?? [];
        },
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
                                    onTap: () {},
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
                                      newAddressName[index]['name'] ??
                                          "Unknown Street",
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
                      },
                    ),
                  ),
                  MyButton(
                      onTap: () {
                        Navigator.push(
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
