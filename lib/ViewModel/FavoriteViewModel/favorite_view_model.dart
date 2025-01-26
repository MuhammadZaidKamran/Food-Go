// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class FavoriteViewModel extends BaseViewModel {
  CollectionReference userFavorites =
      FirebaseFirestore.instance.collection("users");
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

  Future updateUser({
    required context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "email": userDetails!.email,
        "cartItems": cartItems,
        "userID": userDetails!.uid,
        "favoriteItems": favoriteItems,
        "userName" : prefs.getString("userName"),
        "phoneNumber" : prefs.getString("phoneNumber"),
        "platformFee" : 10,
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Future updateFavorites({
  //   required String image,
  //   required String itemName,
  //   required String itemPrice,
  //   required String itemRating,
  //   required String itemName_2,
  //   required String itemDescription,
  //   required bool isFavorite,
  //   required BuildContext context,
  // }) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection("all items")
  //         .doc(itemId)
  //         .update({
  //       "image": image,
  //       "itemName": itemName,
  //       "itemPrice": itemPrice,
  //       "itemRating": itemRating,
  //       "itemName_2": itemName_2,
  //       "itemDescription": itemDescription,
  //       "isFavorite": isFavorite
  //     });
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }
}
