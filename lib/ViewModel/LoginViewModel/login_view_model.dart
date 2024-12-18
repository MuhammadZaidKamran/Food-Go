import 'package:flutter/material.dart';
import 'package:food_go/Controllers/auth_controllers.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final authController = AuthControllers();
}
