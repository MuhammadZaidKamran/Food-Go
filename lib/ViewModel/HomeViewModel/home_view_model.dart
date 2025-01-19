import 'package:flutter/material.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  List<String> options = ["All", "Combos"];

  int myIndex = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future getCurrentAddress() async {
    await Geolocator.requestPermission().then((value) {}).catchError((error) {
      debugPrint(error.toString());
    });

    return await Geolocator.getCurrentPosition().then((value) async {
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(value.latitude, value.longitude);
      userCurrentAddress =
          "${placeMarks.first.street} ${placeMarks.first.locality} ${placeMarks.first.postalCode} ${placeMarks.first.country}";
      rebuildUi();
    });
  }

  //bool isFavorite = false;
}
