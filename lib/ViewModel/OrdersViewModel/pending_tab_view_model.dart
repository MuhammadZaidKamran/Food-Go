import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

class PendingTabViewModel extends BaseViewModel{
  final orderDetails = FirebaseFirestore.instance
      .collection("orders")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection(FirebaseAuth.instance.currentUser!.uid);

  List<dynamic> displayOrderList = [];
  // var address;

  CameraPosition initialPosition = const CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);

  final Completer<GoogleMapController> googleMapController = Completer();

  List<Marker> markers = [
    const Marker(
        markerId: MarkerId("1"),
        position: LatLng(37.42796133580664, -122.085749655962),
        infoWindow: InfoWindow(title: "Current Location")),
  ];
  // var newAddress;
  Map<String, CameraPosition> orderCameraPositions = {};
}