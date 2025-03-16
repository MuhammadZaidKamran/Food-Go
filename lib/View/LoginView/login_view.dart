import 'package:flutter/material.dart';
import 'package:food_go/View/ForgotPassword/forgot_password_view.dart';
import 'package:food_go/View/SignupView/signup_view.dart';
import 'package:food_go/ViewModel/LoginViewModel/login_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/MyButton/my_button.dart';
import 'package:food_go/utils/Widgets/MyTextField/my_text_field.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: AppColors.whiteColor,
            body: Form(
              key: viewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              AppColors.mainTheme,
                              const Color.fromARGB(255, 218, 127, 127)
                            ])),
                    child: Center(
                      child: Image.asset(
                        "assets/images/Foodgo.png",
                        scale: 3,
                      ),
                    ),
                  ),
                  Padding(
                    padding: myPadding(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        height(getHeight(context, 0.035)),
                        MyTextField(
                          label: "Email",
                          prefixIcon: const Icon(Icons.mail),
                          prefixIconColor: AppColors.darkMainTheme,
                          controller: viewModel.emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter email";
                            }
                            return null;
                          },
                        ),
                        height(getHeight(context, 0.02)),
                        MyTextField(
                            label: "Password",
                            obscureText: true,
                            prefixIcon: const Icon(Icons.key),
                            prefixIconColor: AppColors.darkMainTheme,
                            controller: viewModel.passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Password";
                              }
                              return null;
                            }),
                        height(getHeight(context, 0.02)),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPasswordView()));
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(color: AppColors.darkMainTheme),
                            ),
                          ),
                        ),
                        height(getHeight(context, 0.025)),
                        MyButton(
                          height: 45,
                          // borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            if (viewModel.formKey.currentState!.validate()) {
                              viewModel.isLoading = true;
                              viewModel.rebuildUi();
                              viewModel.authController
                                  .login(
                                      email: viewModel.emailController.text,
                                      password:
                                          viewModel.passwordController.text,
                                      context: context)
                                  .then((value) {
                                viewModel.isLoading = false;
                                viewModel.rebuildUi();
                              });
                            }
                          },
                          label: "Login",
                          isLoading: viewModel.isLoading,
                        ),
                        height(getHeight(context, 0.025)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an Account?"),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupView()));
                              },
                              child: Text(
                                "SignUp",
                                style: TextStyle(
                                    color: AppColors.darkMainTheme,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}