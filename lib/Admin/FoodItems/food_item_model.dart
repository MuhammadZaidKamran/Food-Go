import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_go/utils/Global/global.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

class FoodItemModel extends BaseViewModel {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemName_2Controller = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  // TextEditingController itemQuantityController = TextEditingController();
  TextEditingController itemRatingController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();

  bool isAdded = false;
  File? selectedImage;

  // ignore: prefer_typing_uninitialized_variables
  var imageFile;

  addItems() async {
    await FirebaseFirestore.instance
        .collection("all items")
        .add({
          'itemName': itemNameController.text,
          'itemName_2': itemName_2Controller.text,
          'itemPrice': itemPriceController.text,
          'itemQuantity': 0,
          'itemRating': itemRatingController.text,
          'itemDescription': itemDescriptionController.text,
          'isFavorite': isFavoriteList,
        })
        // ignore: avoid_print
        .then((value) => print("$value Added"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to Add item : $error"));
  }
}
