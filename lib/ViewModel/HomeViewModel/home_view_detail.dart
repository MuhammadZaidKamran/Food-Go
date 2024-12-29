// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:stacked/stacked.dart';

class HomeViewDetailModel extends BaseViewModel {
  CollectionReference allItems =
      FirebaseFirestore.instance.collection('all items');
  String itemId = '';

  Future updateUser() async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "email": userDetails!.email,
        "cartItems": cartItems,
        "userID": userDetails!.uid,
        "favoriteItems": favoriteItems,
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // updateAddItems(
  //     String image,
  //     String itemName,
  //     String price,
  //     String rating,
  //     String itemName_2,
  //     String itemDescription,
  //     int itemQuantity,
  //     BuildContext context) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection("all items")
  //         .doc(itemId)
  //         .update({
  //       "image": image,
  //       "itemName": itemName,
  //       "itemPrice": price,
  //       "itemRating": rating,
  //       "itemName_2": itemName_2,
  //       "itemDescription": itemDescription,
  //       "itemQuantity": itemQuantity
  //       // FieldValue.increment(1)
  //     });
  //     // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     //     backgroundColor: Colors.green,
  //     //     content: Text("Your cart has been updated")));
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // updateAddToCart(
  //     String image,
  //     String itemName,
  //     String price,
  //     String rating,
  //     String itemName_2,
  //     String itemDescription,
  //     // int itemQuantity,
  //     BuildContext context) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection("addToCartItems")
  //         .doc(itemId)
  //         .update({
  //       "image": image,
  //       "itemName": itemName,
  //       "itemPrice": price,
  //       "itemRating": rating,
  //       "itemName_2": itemName_2,
  //       "itemDescription": itemDescription,
  //       // "itemQuantity": itemQuantity
  //       // FieldValue.increment(1)
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         backgroundColor: Colors.green,
  //         content: Text("Your cart has been updated")));
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // addToCart(
  //     String image,
  //     String itemName,
  //     String price,
  //     String rating,
  //     String itemName_2,
  //     String itemDescription,
  //     int itemQuantity,
  //     BuildContext context) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection("addToCartItems")
  //         .doc(itemId)
  //         .set({
  //       "image": image,
  //       "itemName": itemName,
  //       "itemPrice": price,
  //       "itemRating": rating,
  //       "itemName_2": itemName_2,
  //       "itemDescription": itemDescription,
  //       "itemQuantity": itemQuantity
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         backgroundColor: Colors.green,
  //         content: Row(
  //           children: [
  //             Icon(
  //               Icons.check_circle,
  //               color: AppColors.whiteColor,
  //             ),
  //             width(getWidth(context, 0.1)),
  //             const Text("Added to Cart Successfully"),
  //           ],
  //         )));
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // Future addToFavorites({
  //   required String image,
  //   required String itemName,
  //   required String itemPrice,
  //   required String itemRating,
  //   required String itemName_2,
  //   required String itemDescription,
  //   required int itemQuantity,
  //   required bool isFavorite,
  //   required BuildContext context,
  // }) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection("favoriteItems")
  //         .doc(itemId)
  //         .set({
  //       "image": image,
  //       "itemName": itemName,
  //       "itemPrice": itemPrice,
  //       "itemRating": itemRating,
  //       "itemName_2": itemName_2,
  //       "itemDescription": itemDescription,
  //       "itemQuantity": itemQuantity,
  //       "isFavorite": isFavorite
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         backgroundColor: AppColors.mainTheme,
  //         content: Row(
  //           children: [
  //             Icon(
  //               Icons.favorite,
  //               color: AppColors.whiteColor,
  //             ),
  //             width(getWidth(context, 0.1)),
  //             const Text("Add to Favorites Successfully"),
  //           ],
  //         )));
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // Future updateFavorites({
  //   required String image,
  //   required String itemName,
  //   required String itemPrice,
  //   required String itemRating,
  //   required String itemName_2,
  //   required String itemDescription,
  //   required int itemQuantity,
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
  //       "itemQuantity": itemQuantity,
  //       "isFavorite": isFavorite
  //     });
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // Future removeFavorites({required BuildContext context}) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection("favoriteItems")
  //         .doc(itemId)
  //         .delete();
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Row(
  //       children: [
  //         Icon(
  //           Icons.delete,
  //           color: AppColors.whiteColor,
  //         ),
  //         width(getWidth(context, 0.1)),
  //         const Text("Deleted Successfully"),
  //       ],
  //     )));
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }
}
