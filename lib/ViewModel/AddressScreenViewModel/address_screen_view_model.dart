import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:stacked/stacked.dart';

class AddressScreenViewModel extends BaseViewModel {
  final ref = FirebaseDatabase.instance
      .ref("userDeliveryAddress")
      .child(FirebaseAuth.instance.currentUser!.uid);
}
