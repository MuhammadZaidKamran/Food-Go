import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends BaseViewModel {
  final user = FirebaseAuth.instance.currentUser;
}
