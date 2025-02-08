import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

myPadding() {
  return const EdgeInsets.symmetric(vertical: 25, horizontal: 15);
}

String? userCurrentAddress;
bool fromAddress = false;

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

var platformCharges;
var deliveryCharges;
platFormFees() {
  FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots()
      .listen((snapshot) {
    platformCharges = snapshot.get("platformFee");
    deliveryCharges = snapshot.get("deliveryCharges");
  });
}

Future updateUser({
  required BuildContext context,
}) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "email": userDetails!.email,
      "cartItems": [],
      "userID": userDetails!.uid,
      "favoriteItems": favoriteItems,
      "userName": prefs.getString("userName"),
      "phoneNumber": prefs.getString("phoneNumber"),
      "platformFee": 10,
      "deliveryCharges": 49,
    });
  } catch (e) {
    debugPrint(e.toString());
  }
}
