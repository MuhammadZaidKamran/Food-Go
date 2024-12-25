import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

myPadding() {
  return const EdgeInsets.symmetric(vertical: 50, horizontal: 15);
}

final box = GetStorage();

height(double height) {
  return SizedBox(
    height: height,
  );
}

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

final List<bool> bools = [false, false, false, false];
final List<int> quantity = [0, 0, 0, 0];

final userDetails = FirebaseAuth.instance.currentUser;
