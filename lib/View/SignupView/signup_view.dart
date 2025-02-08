import 'package:flutter/material.dart';
import 'package:food_go/ViewModel/SignupViewModel/signup_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
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
            backgroundColor: AppColors.whiteColor,
            body: Form(
              key: viewModel.formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 22, left: 15, right: 15),
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
                      child: const Center(
                        child: Text(
                          "LOGO",
                          style: TextStyle(
                              letterSpacing: 1,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: myPadding(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          height(getHeight(context, 0.035)),
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
                          height(getHeight(context, 0.015)),
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
                          height(getHeight(context, 0.015)),
                          MyTextField(
                            label: "Phone Number",
                            prefixIcon: const Icon(Icons.phone_android_sharp),
                            prefixIconColor: AppColors.darkMainTheme,
                            controller: viewModel.phoneController_1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "PLease enter phone number";
                              }
                              return null;
                            },
                          ),
                          height(getHeight(context, 0.015)),
                          MyTextField(
                            label: "Password",
                            obscureText: true,
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
                          height(getHeight(context, 0.015)),
                          MyTextField(
                            label: "Confirm Password",
                            obscureText: true,
                            prefixIcon: const Icon(Icons.key),
                            prefixIconColor: AppColors.darkMainTheme,
                            controller: viewModel.confirmPasswordController_1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "PLease enter confirm password";
                              } else if (value !=
                                  viewModel.passwordController_1.text) {
                                return "Password does not match";
                              }
                              return null;
                            },
                          ),
                          height(getHeight(context, 0.025)),
                          MyButton(
                              // borderRadius: BorderRadius.circular(20),
                              height: 45,
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
                                          phoneNumber:
                                              viewModel.phoneController_1.text,
                                          confirmPassword: viewModel
                                              .confirmPasswordController_1.text,
                                          context: context)
                                      .then((value) {
                                    viewModel.isLoading = false;
                                    viewModel.rebuildUi();
                                  });
                                }
                              },
                              isLoading: viewModel.isLoading,
                              label: "Sign Up"),
                          height(getHeight(context, 0.02)),
                          SizedBox(
                            height: 45,
                            width: MediaQuery.of(context).size.width,
                            child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
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
                                    const Expanded(
                                      child: Center(
                                        child: Text(
                                          "Continue with Google",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          height(getHeight(context, 0.02)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an Account?"),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Login",
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
            ),
          );
        });
  }
}


// Center(
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 15, vertical: 20),
//                         margin: EdgeInsets.only(
//                             top: MediaQuery.of(context).size.height * 0.3),
//                         //height: 350,
//                         width: MediaQuery.of(context).size.width * 0.92,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(40),
//                             gradient: const LinearGradient(
//                                 begin: Alignment.bottomCenter,
//                                 end: Alignment.topCenter,
//                                 colors: [
//                                   Color.fromARGB(205, 158, 158, 158),
//                                   Color.fromARGB(231, 255, 255, 255)
//                                   // const Color.fromARGB(255, 0, 0, 0),
//                                   // const Color.fromARGB(255, 255, 255, 255),
//                                   // const Color.fromARGB(255, 0, 0, 0)
//                                 ])),
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 10),
//                               child: Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                   "Sign Up",
//                                   style: TextStyle(
//                                       fontSize: 25,
//                                       fontWeight: FontWeight.bold,
//                                       color: AppColors.darkMainTheme),
//                                 ),
//                               ),
//                             ),
//                             
//                             const SizedBox(
//                               height: 10,
//                             ),
                            
//                             const SizedBox(
//                               height: 10,
//                             ),
                            
//                             const SizedBox(
//                               height: 10,
//                             ),
                            
//                             const SizedBox(
//                               height: 20,
//                             ),
                            
//                           ],
//                         ),
//                       ),
//                     ),