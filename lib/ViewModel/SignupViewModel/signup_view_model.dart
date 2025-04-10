import 'package:flutter/material.dart';
import 'package:food_go/Controllers/auth_controllers.dart';
import 'package:stacked/stacked.dart';

class SignupViewModel extends BaseViewModel {
  TextEditingController userController_1 = TextEditingController();
  TextEditingController emailController_1 = TextEditingController();
  TextEditingController passwordController_1 = TextEditingController();
  TextEditingController confirmPasswordController_1 = TextEditingController();
  TextEditingController phoneController_1 = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final authController = AuthControllers();
}
