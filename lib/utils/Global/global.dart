import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

myPadding() {
  return const EdgeInsets.symmetric(vertical: 25, horizontal: 15);
}

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
