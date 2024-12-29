import 'package:flutter/material.dart';
import 'package:food_go/View/CartView/cart_view.dart';
import 'package:food_go/View/FavoriteView/favorite_view.dart';
import 'package:food_go/View/HomeView/home_view.dart';
import 'package:food_go/View/ProfileView/profile_view.dart';
import 'package:stacked/stacked.dart';

class BottomNavBarViewModel extends BaseViewModel {
  int index = 0;
  List<Widget> widgetList = [
    const HomeView(),
    const CartView(),
    const FavoriteView(),
    const ProfileView(),
  ];
}
