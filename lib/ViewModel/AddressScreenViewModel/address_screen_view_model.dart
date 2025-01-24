import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:stacked/stacked.dart';

class AddressScreenViewModel extends BaseViewModel {
  final ref = FirebaseDatabase.instance
      .ref("userDeliveryAddress")
      .child(FirebaseAuth.instance.currentUser!.uid);
  var deliveryAddress;
  List placesName = [];
  List newAddressName = [];
  var addressName = {};
  String? address;


  
}
