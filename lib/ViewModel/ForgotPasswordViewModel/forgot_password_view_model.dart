import 'package:flutter/material.dart';
import 'package:food_go/Controllers/auth_controllers.dart';
import 'package:stacked/stacked.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  
  final emailController = TextEditingController();

  final authController = AuthControllers();

  final formKey = GlobalKey<FormState>();

}
