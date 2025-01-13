import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends BaseViewModel {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  String name = "";
  String email = "";
  String phoneNumber = "";

  //  myInitMethod() async {
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .snapshots()
  //       .listen((snapshot) {
  //     snapshot.docs
  //         .where((doc) => doc["userID"] == FirebaseAuth.instance.currentUser!.uid)
  //         .map((e) => name = e["userName"].toString()
  //             // email = e["email"];
  //             // phoneNumber = e["phoneNumber"];

  //             );

  //     rebuildUi();
  //     notifyListeners();
  //   });
  // }
}
