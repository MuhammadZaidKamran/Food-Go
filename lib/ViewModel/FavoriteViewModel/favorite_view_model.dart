// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:stacked/stacked.dart';

class FavoriteViewModel extends BaseViewModel {
  String itemId = "";
  Future removeFavorite({required BuildContext context}) async {
    try {
      await FirebaseFirestore.instance
          .collection("favoriteItems")
          .doc(itemId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
        children: [
          Icon(
            Icons.delete,
            color: AppColors.whiteColor,
          ),
          width(getWidth(context, 0.1)),
          const Text("Deleted Successfully"),
        ],
      )));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future updateFavorites({
    required String image,
    required String itemName,
    required String itemPrice,
    required String itemRating,
    required String itemName_2,
    required String itemDescription,
    required int itemQuantity,
    required bool isFavorite,
    required BuildContext context,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection("all items")
          .doc(itemId)
          .update({
        "image": image,
        "itemName": itemName,
        "itemPrice": itemPrice,
        "itemRating": itemRating,
        "itemName_2": itemName_2,
        "itemDescription": itemDescription,
        "itemQuantity": itemQuantity,
        "isFavorite": isFavorite
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
