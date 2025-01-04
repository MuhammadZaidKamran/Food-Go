import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';

class CartViewModel extends BaseViewModel {
  CollectionReference userCart = FirebaseFirestore.instance.collection("users");
}
