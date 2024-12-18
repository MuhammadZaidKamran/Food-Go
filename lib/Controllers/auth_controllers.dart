import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthControllers {
  final authentication = FirebaseAuth.instance;

  Future signUp(
      {required String email,
      required String password,
      required context}) async {
    try {
      await authentication
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Account Created Successfully",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ));
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
      debugPrint(e.toString());
    }
  }

  Future login(
      {required String email,
      required String password,
      required context}) async {
    try {
      await authentication
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Login Successfully")));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "No user found for that email.",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ));
        debugPrint("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Wrong password provided for that user.",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ));
        debugPrint("Wrong password provided for that user.");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
