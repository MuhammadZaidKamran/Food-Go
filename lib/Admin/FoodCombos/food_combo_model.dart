import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FoodComboModel extends BaseViewModel {
  TextEditingController imageController = TextEditingController();
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
        .collection("foodCombos")
        .add({
          "image": imageController.text,
          'itemName': itemNameController.text,
          'itemName_2': itemName_2Controller.text,
          'itemPrice': itemPriceController.text,
          'itemQuantity': 0,
          'itemRating': itemRatingController.text,
          'itemDescription': itemDescriptionController.text,
        })
        // ignore: avoid_print
        .then((value) => print("$value Added"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to Add item : $error"));
  }
}