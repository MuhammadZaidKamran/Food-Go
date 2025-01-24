import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_go/View/AddressView/address_view.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

class GoogleMapViewModel extends BaseViewModel {
  final ref = FirebaseDatabase.instance.ref("userDeliveryAddress");
  bool isReceive = false;
  final List optionList = ["Home", "Work", "Other"];
  Location? newCameraPosition;
  int selectedIndex = 0;
  final searchController = TextEditingController();
  CameraPosition initialPosition = const CameraPosition(
    target: LatLng(24.8607, 67.0011),
    zoom: 14,
  );

  final Completer<GoogleMapController> googleMapController = Completer();
  List<Marker> markers = [
    const Marker(
      markerId: MarkerId("1"),
      position: LatLng(24.8607, 67.0011),
      infoWindow: InfoWindow(title: "Google"),
    ),
  ];

  Future getCurrentLocation() async {
    await Geolocator.requestPermission().then((value) {}).catchError((error) {
      debugPrint(error.toString());
    });

    return await Geolocator.getCurrentPosition().then((value) async {
      final controller = await googleMapController.future;
      markers.add(
        Marker(
          markerId: const MarkerId("2"),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: const InfoWindow(title: "Current Location"),
        ),
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(value.latitude, value.longitude), zoom: 14)));
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(value.latitude, value.longitude);
      searchController.text =
          "${placeMarks.first.street} ${placeMarks.first.locality} ${placeMarks.first.postalCode} ${placeMarks.first.country}";
      rebuildUi();
    });
  }

  Future addUserDeliveryAddress({
    required latitude,
    required longitude,
    required String destination,
    required context,
  }) async {
    String dateTime = DateTime.now().millisecondsSinceEpoch.toString();
    ref.child(FirebaseAuth.instance.currentUser!.uid).child(dateTime).set({
      "id" : dateTime,
      "userID": FirebaseAuth.instance.currentUser!.uid,
      "latitude": latitude,
      "longitude": longitude,
      "destination": destination,
    }).then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const AddressView()));
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }
}
