// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class HomeViewDetailModel extends BaseViewModel {
  CollectionReference allItems =
      FirebaseFirestore.instance.collection('all items');
      CollectionReference foodCombos =
      FirebaseFirestore.instance.collection('foodCombos');
  String itemId = '';
  bool isCheeseAdded = false;
  bool isGarlicAdded = false;

  Future updateUser() async {
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
        "deliveryCharges" : 49,
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
