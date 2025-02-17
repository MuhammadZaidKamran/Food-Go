import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class ComboItemsModel extends BaseViewModel {
  String itemId = "";
  final searchController = TextEditingController();
  List displayItems = [];

  searchValue(value) {
    FirebaseFirestore.instance
        .collection('foodCombos')
        .snapshots()
        .listen((snapshot) {
      displayItems = snapshot.docs
          .where(
              (doc) => doc["itemName"].toString().toLowerCase().contains(value))
          .toList();
      notifyListeners();
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