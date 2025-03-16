import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class CartViewModel extends BaseViewModel {
  CollectionReference userCart = FirebaseFirestore.instance.collection("users");
  final addNoteController = TextEditingController();
  CameraPosition initialPosition = const CameraPosition(target: LatLng(24.8607, 67.0011),zoom: 14);
  final Completer<GoogleMapController> googleMapController = Completer();
  List<Marker> markers = [
    const Marker(markerId: MarkerId("1"),position: LatLng(24.8607, 67.0011),
    )
  ];

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
        "deliveryCharges": 49,
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }


  totalAmount() {
    int myTotal = 0;
    for (var element in cartItems) {
      myTotal += int.parse(element["itemPrice"].toString()) *
          int.parse(element["itemQuantity"].toString());
    }
    return myTotal;
  }
}
