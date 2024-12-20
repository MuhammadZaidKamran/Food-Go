import 'package:flutter/material.dart';
import 'package:food_go/ViewModel/SignupViewModel/signup_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Widgets/MyButton/my_button.dart';
import 'package:food_go/utils/Widgets/MyTextField/my_text_field.dart';
import 'package:stacked/stacked.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => SignupViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Form(
              key: viewModel.formKey,
              child: Column(
                children: [
                  Stack(children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 27, left: 15, right: 15),
                      height: MediaQuery.of(context).size.height * 0.39,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(70),
                              bottomRight: Radius.circular(70)),
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                AppColors.mainTheme,
                                const Color.fromARGB(255, 218, 127, 127)
                              ])),
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: InkWell(
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
                              )),
                          Image.asset(
                            "assets/images/burger-icon.webp",
                            scale: 4,
                          ),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          const Text(
                            "SIGNUP",
                            style: TextStyle(
                                letterSpacing: 1,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.7792),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Stack(children: [
                          Image.asset(
                            fit: BoxFit.cover,
                            "assets/images/image 2.png",
                            scale: 2,
                          ),
                          Container(
                            padding: EdgeInsets.zero,
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.2,
                                top: MediaQuery.of(context).size.height * 0.07),
                            child: Image.asset(
                              fit: BoxFit.cover,
                              "assets/images/image 1.png",
                              scale: 2,
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 30),
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.333),
                        //height: 350,
                        width: MediaQuery.of(context).size.width * 0.92,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            gradient: const LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Color.fromARGB(205, 158, 158, 158),
                                  Color.fromARGB(231, 255, 255, 255)
                                  // const Color.fromARGB(255, 0, 0, 0),
                                  // const Color.fromARGB(255, 255, 255, 255),
                                  // const Color.fromARGB(255, 0, 0, 0)
                                ])),
                        child: Column(
                          children: [
                            MyTextField(
                              controller: viewModel.userController_1,
                              label: "Username",
                              prefixIcon: const Icon(Icons.account_circle),
                              prefixIconColor: AppColors.darkMainTheme,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter username";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            MyTextField(
                              label: "Email",
                              prefixIcon: const Icon(Icons.mail),
                              prefixIconColor: AppColors.darkMainTheme,
                              controller: viewModel.emailController_1,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "PLease enter email";
                                } else if (!value.contains("@gmail.com")) {
                                  return "Please enter valid email";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            MyTextField(
                              label: "Password",
                              prefixIcon: const Icon(Icons.key),
                              prefixIconColor: AppColors.darkMainTheme,
                              controller: viewModel.passwordController_1,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "PLease enter password";
                                } else if (value.length < 8) {
                                  return "Password must be at least 8 characters";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            MyButton(
                                onTap: () {
                                  if (viewModel.formKey.currentState!
                                      .validate()) {
                                    viewModel.isLoading = true;
                                    viewModel.rebuildUi();
                                    viewModel.authController
                                        .signUp(
                                            userName: viewModel
                                                .userController_1.text
                                                .trim(),
                                            email: viewModel
                                                .emailController_1.text
                                                .trim(),
                                            password: viewModel
                                                .passwordController_1.text
                                                .trim(),
                                            context: context)
                                        .then((value) {
                                      viewModel.isLoading = false;
                                      viewModel.rebuildUi();
                                    });
                                  }
                                },
                                isLoading: viewModel.isLoading,
                                label: "Sign Up"),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  color: Colors.white,
                                  elevation: 5,
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/google-icon.png",
                                        width: 30,
                                        height: 30,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.11,
                                      ),
                                      const Text(
                                        "Continue with Google",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.5),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          );
        });
  }
}
