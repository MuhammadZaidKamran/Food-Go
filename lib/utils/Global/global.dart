import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:geocoding/geocoding.dart';

myPadding() {
  return const EdgeInsets.symmetric(vertical: 25, horizontal: 15);
}
String? userCurrentAddress;

height(double height) {
  return SizedBox(
    height: height,
  );
}

String? userID;
// bool isCheeseAdded = false;
// bool isGarlicAdded = false;

double getHeight(BuildContext context, double getHeight) {
  return MediaQuery.of(context).size.height * getHeight;
}

double getWidth(BuildContext context, double getWidth) {
  return MediaQuery.of(context).size.width * getWidth;
}

width(double width) {
  return SizedBox(
    width: width,
  );
}

bool isFavorite = false;

List favoriteItems = [];
List cartItems = [];
String favoriteItemID = "";

//int quantity = 0;

final List<String> images = [
  "cheese_burger",
  "chicken_burger",
  "beef_burger",
  "cheese_burger"
];

String cartImage = "";
List favoriteImage = [];

var isFavoriteList = [false, false, false, false];
List<int> quantity = [0, 0, 0, 0];

final userDetails = FirebaseAuth.instance.currentUser;

List<bool> isAdded = [false, false, false, false];

Map? user;

mySuccessSnackBar({
  required BuildContext context,
  required String message,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: AppColors.whiteColor,
        ),
      ),
      backgroundColor: AppColors.greenColor,
    ),
  );
}

myErrorSnackBar({
  required BuildContext context,
  required String message,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: AppColors.whiteColor,
        ),
      ),
      backgroundColor: Colors.red,
    ),
  );
}

final ref = FirebaseDatabase.instance
      .ref("userDeliveryAddress")
      .child(FirebaseAuth.instance.currentUser!.uid);
  var deliveryAddress;
  List placesName = [];
  List newAddressName = [];
  var addressName = {};
  String? address;
Future getData() async{
    ref.onValue.listen((snapshot) async {
            // debugPrint(snapshot.snapshot.child("latitude").value.toString());
            deliveryAddress = snapshot.snapshot.value ?? {};
            // debugPrint(viewModel.deliveryAddress.toString());
            await deliveryAddress.forEach((key, value) async {
              debugPrint(value["latitude"].toString());
              debugPrint(value["longitude"].toString());
              List<Placemark> placeMarks = await placemarkFromCoordinates(
                  value["latitude"], value["longitude"]);
              // debugPrint(placeMarks.first.toJson().toString());
              placesName.add(placeMarks.first.toJson());
              // debugPrint(viewModel.placesName.toString());
              newAddressName = placesName;
              // debugPrint(viewModel.newAddressName.toString());
              
            });
            
            // debugPrint(viewModel.newAddressName.toString());
            // viewModel.placesName.clear();
            // viewModel.deliveryAddress.forEach((key, value) async {
            //   debugPrint(value["latitude"].toString());
            //   List<Placemark> placeMarks = await placemarkFromCoordinates(
            //       value["latitude"], value["longitude"]);
            //   // viewModel.address = placeMarks.first.
            //   viewModel.addressName.addAll(placeMarks.first.toJson());
            //   debugPrint(viewModel.addressName.toString());

            //   //
            //   // debugPrint(viewModel.placesName.toString());
            //   viewModel.placesName.add(
            //       "${viewModel.addressName["street"]} ${viewModel.addressName["locality"]} ${viewModel.addressName["postalCode"]} ${viewModel.addressName["country"]}");
            //   prefs.setStringList("address", viewModel.placesName);
            //   print(viewModel.placesName.toString());
            //   viewModel.rebuildUi();
            // });
            // .forEach((key, value) async {
            //   debugPrint(value["latitude"].toString());
            //   List<Placemark> placeMarks = await placemarkFromCoordinates(
            //       value["latitude"], value["longitude"]);
            //   // viewModel.address = placeMarks.first.
            //   viewModel.addressName.addAll(placeMarks.first.toJson());
            //   debugPrint(viewModel.addressName.toString());

            //   //
            //   // debugPrint(viewModel.placesName.toString());
            //   viewModel.address =
            //       "${viewModel.addressName["street"]} ${viewModel.addressName["locality"]} ${viewModel.addressName["postalCode"]} ${viewModel.addressName["country"]}";
            //   viewModel.rebuildUi();
            // });
            // viewModel.placesName.add(viewModel.addressName);
          });
  }
