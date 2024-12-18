import 'package:flutter/material.dart';

myPadding() {
  return const EdgeInsets.symmetric(vertical: 50, horizontal: 15);
}

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
