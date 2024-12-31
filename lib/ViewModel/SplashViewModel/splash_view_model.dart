import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go/View/BottomNavBarView/bottom_nav_bar_view.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends BaseViewModel {
  final user = FirebaseAuth.instance.currentUser;

  Future updateUserItems(context) async {
    try {
      // FirebaseFirestore.instance
      //     .collection("users")
      //     .snapshots()
      //     .listen((snapshot) {
      //   favoriteItems = snapshot.docs
      //       .where((doc) =>
      //           doc["userID"] == FirebaseAuth.instance.currentUser!.uid)
      //       .map((doc) => doc["favoriteItems"])
      //       .toList();
      //   cartItems = snapshot.docs
      //       .where((doc) =>
      //           doc["userID"] == FirebaseAuth.instance.currentUser!.uid)
      //       .map((doc) => doc["cartItems"])
      //       .toList();
      //   notifyListeners();
      // });
      //.onData((value) async {
      //   try {
      //     await FirebaseFirestore.instance
      //         .collection("users")
      //         .doc(FirebaseAuth.instance.currentUser!.uid)
      //         .set({
      //       "email": userDetails!.email,
      //       "cartItems": cartItems,
      //       "userID": userDetails!.uid,
      //       "favoriteItems": favoriteItems,
      //     }).then((value) {
      //       Navigator.pushReplacement(
      //           context,
      //           MaterialPageRoute(
      //               builder: (context) => const BottomNavBarView()));
      //     });
      //   } catch (e) {
      //     debugPrint(e.toString());
      //   }
      // });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future updateUser(context) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "email": userDetails!.email,
        "cartItems": cartItems,
        "userID": userDetails!.uid,
        "favoriteItems": favoriteItems,
      }).then((value) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BottomNavBarView()));
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
