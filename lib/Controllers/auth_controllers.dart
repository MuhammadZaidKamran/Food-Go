import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go/View/BottomNavBarView/bottom_nav_bar_view.dart';
import 'package:food_go/View/VerificationView/verification_view.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class AuthControllers extends BaseViewModel {
  final authentication = FirebaseAuth.instance;

  Future signUp(
      {required String userName,
      required String email,
      required String password,
      required String confirmPassword,
      required String phoneNumber,
      required context}) async {
    try {
      await authentication
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        // ScaffoldMessenger.of(context).showSnackBar(
        //     snackBarAnimationStyle:
        //         AnimationStyle(duration: const Duration(seconds: 1)),
        //     const SnackBar(
        //       content: Text(
        //         "Account Created Successfully",
        //         style: TextStyle(color: Colors.white),
        //       ),
        //       backgroundColor: Colors.green,
        //     ));
        await FirebaseFirestore.instance
            .collection("users")
            .doc(value.user!.uid)
            .set({
          "userID": value.user!.uid,
          "userName": userName,
          "email": value.user!.email,
          "phoneNumber": phoneNumber,
          "favoriteItems": [],
          "cartItems": [],
          "platformFee": 10,
          "deliveryCharges": 49,
        }).then((value) async {
          user = {
            "userID": FirebaseAuth.instance.currentUser!.uid,
            "userName": userName,
            "email": email,
            "phoneNumber": phoneNumber,
          };
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("userID", user!["userID"]);
          await prefs.setString("userName", user!["userName"]);
          await prefs.setString("email", user!["email"]);
          await prefs.setString("phoneNumber", user!["phoneNumber"]);
          // print(prefs.getString("userName"));
        });
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const VerificationView()));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "The password provided is too weak.",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "The account already exists for that email.",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future login(
      {required String email,
      required String password,
      required context}) async {
    try {
      await authentication
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Login Successfully"),
          backgroundColor: Colors.green,
        ));
        final String? currentUserEmail =
            FirebaseAuth.instance.currentUser!.email;
        FirebaseFirestore.instance
            .collection("users")
            .snapshots()
            .listen((snapshot) async {
          String userName = "";
          String phoneNumber = "";
          snapshot.docs
              .where(
                  (e) => e["userID"] == FirebaseAuth.instance.currentUser!.uid)
              .map((e) => userName = e["userName"].toString())
              .toSet()
              .toString();
          snapshot.docs
              .where((docs) =>
                  docs["userID"] == FirebaseAuth.instance.currentUser!.uid)
              .map((e) => phoneNumber = e["phoneNumber"].toString())
              .toSet()
              .toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("userName", userName);
          await prefs.setString("email", currentUserEmail!);
          await prefs.setString("phoneNumber", phoneNumber);
          notifyListeners();
          rebuildUi();
        });
      });
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const BottomNavBarView()));
    } on FirebaseAuthException catch (e) {
      // if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.code,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
      // debugPrint("No user found for that email.");
      // }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future forgotPassword({required String email, required context}) async {
    try {
      await authentication.sendPasswordResetEmail(email: email).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Password Reset Email Sent",
            style: TextStyle(color: AppColors.whiteColor),
          ),
          backgroundColor: Colors.green,
        ));
        Navigator.pop(context);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
              style: TextStyle(color: AppColors.whiteColor),
            ),
            backgroundColor: Colors.red,
          ),
          snackBarAnimationStyle:
              AnimationStyle(duration: const Duration(seconds: 1)));
    }
  }
}
