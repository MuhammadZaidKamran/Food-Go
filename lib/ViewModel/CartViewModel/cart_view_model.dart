import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:stacked/stacked.dart';

class CartViewModel extends BaseViewModel {
  CollectionReference userCart = FirebaseFirestore.instance.collection("users");

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
}
