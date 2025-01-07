import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  List<String> options = ["All", "Combos"];

  int myIndex = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  //bool isFavorite = false;
}
