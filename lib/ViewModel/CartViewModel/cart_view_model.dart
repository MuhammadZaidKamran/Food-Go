import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class CartViewModel extends BaseViewModel {
  CollectionReference userCart = FirebaseFirestore.instance.collection("users");
  final addNoteController = TextEditingController();

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
        "userName": prefs.getString("userName"),
        "phoneNumber": prefs.getString("phoneNumber"),
        "platformFee": 10,
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // var platformCharges;


  totalAmount() {
    int myTotal = 0;
    for (var element in cartItems) {
      myTotal += int.parse(element["itemPrice"].toString()) *
          int.parse(element["itemQuantity"].toString());
    }
    return myTotal;
  }
}
