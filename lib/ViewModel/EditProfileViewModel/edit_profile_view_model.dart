import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class EditProfileViewModel extends BaseViewModel {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  Future updateProfile({
    required String userName,
    required String phoneNumber,
    required BuildContext context,
  }) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "userName": userName,
      "phoneNumber": phoneNumber,
    }).then((value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("userName", userName);
      prefs.setString("phoneNumber", phoneNumber);
      mySuccessSnackBar(
          // ignore: use_build_context_synchronously
          context: context,
          message: "Profile Updated Successfully");
    }).catchError((error) {
      // ignore: use_build_context_synchronously
      myErrorSnackBar(context: context, message: error.toString());
    });
  }
}
