import 'package:flutter/material.dart';
import 'package:food_go/ViewModel/ForgotPasswordViewModel/forgot_password_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/MyButton/my_button.dart';
import 'package:food_go/utils/Widgets/MyTextField/my_text_field.dart';
import 'package:stacked/stacked.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => ForgotPasswordViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: AppColors.whiteColor,
            body: Form(
              key: viewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
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
                    child: Column(
                      children: [
                        height(30),
                        Row(
                          children: [
                            width(getWidth(context, 0.04)),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white),
                                  child: Icon(
                                    Icons.arrow_back_ios_new,
                                    color: AppColors.mainTheme,
                                  )),
                            ),
                          ],
                        ),
                        height(getHeight(context, 0.015)),
                        Center(
                          child: Image.asset(
                            "assets/images/Foodgo.png",
                            scale: 3,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: myPadding(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Forgot Password",
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
                              return "Please Enter Email";
                            } else if (!value.contains("@")) {
                              return "Please Enter Valid Email";
                            }
                            return null;
                          },
                        ),
                        height(getHeight(context, 0.025)),
                        MyButton(
                            onTap: () {
                              if (viewModel.formKey.currentState!.validate()) {
                                viewModel.authController.forgotPassword(
                                    email:
                                        viewModel.emailController.text.trim(),
                                    context: context);
                              }
                            },
                            label: "Send Email")
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
