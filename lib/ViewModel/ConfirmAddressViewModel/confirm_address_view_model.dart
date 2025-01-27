import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:stacked/stacked.dart';

class ConfirmAddressViewModel extends BaseViewModel {
  final ref = FirebaseDatabase.instance
      .ref("userDeliveryAddress")
      .child(FirebaseAuth.instance.currentUser!.uid);

  int myIndex = 0;
  var addressMap;
  var selectedAddress;
  var selectedSecondAddress;
}
