import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

class OrderSuccessfulViewModel extends BaseViewModel {
  final orederDetails = FirebaseFirestore.instance
      .collection("orders")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection(FirebaseAuth.instance.currentUser!.uid).snapshots();
}
