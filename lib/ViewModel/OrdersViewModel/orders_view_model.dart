import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

class OrdersViewModel extends BaseViewModel {
  final orderDetails = FirebaseFirestore.instance
      .collection("orders")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection(FirebaseAuth.instance.currentUser!.uid);

  List<dynamic> displayOrderList = [];
  var address;

  CameraPosition initialPosition = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);

  final Completer<GoogleMapController> googleMapController = Completer();

  List<Marker> markers = [
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(37.42796133580664, -122.085749655962),
        infoWindow: InfoWindow(title: "Current Location")),
  ];
  var newAddress;

  Future getLocation(address) async {
    newAddress = address;
    final controller = await googleMapController.future;
    List<Location> location = await locationFromAddress(newAddress);
    List<Placemark> placeMarks = await placemarkFromCoordinates(
        location.first.latitude, location.first.longitude);
    print(location.first.latitude.toString());
    print(location.first.longitude.toString());
    markers.add(Marker(
        markerId: MarkerId("2"),
        infoWindow: InfoWindow(
            title:
                "${placeMarks.first.street} ${placeMarks.first.locality} ${placeMarks.first.postalCode} ${placeMarks.first.country}"),
        position: LatLng(location.first.latitude, location.first.longitude)));
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(location.first.latitude, location.first.longitude),
      zoom: 14,

      // bearing: 45.0,
    )));
  }
}
