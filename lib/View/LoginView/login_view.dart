import 'package:flutter/material.dart';
import 'package:food_go/View/ForgotPassword/forgot_password_view.dart';
import 'package:food_go/View/SignupView/signup_view.dart';
import 'package:food_go/ViewModel/LoginViewModel/login_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
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
            body: Form(
              key: viewModel.formKey,
              child: Column(
                children: [
                  Stack(children: [
                    Container(
                      padding: const EdgeInsets.only(top: 20),
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
                          Image.asset(
                            "assets/images/burger-icon.webp",
                            scale: 3.5,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "LOGIN",
                            style: TextStyle(
                                letterSpacing: 1,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 35),
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.34),
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
                            const SizedBox(
                              height: 20,
                            ),
                            MyTextField(
                                label: "Password",
                                prefixIcon: const Icon(Icons.key),
                                prefixIconColor: AppColors.darkMainTheme,
                                controller: viewModel.passwordController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter Password";
                                  }
                                  return null;
                                }),
                            const SizedBox(
                              height: 10,
                            ),
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
                                  style:
                                      TextStyle(color: AppColors.darkMainTheme),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  color: AppColors.darkMainTheme,
                                  elevation: 5,
                                  onPressed: () {
                                    if (viewModel.formKey.currentState!
                                        .validate()) {
                                      viewModel.authController.login(
                                          email: viewModel.emailController.text,
                                          password:
                                              viewModel.passwordController.text,
                                          context: context);
                                    }
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const BottomNavBarView()));
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 12,
                  ),
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
                                  builder: (context) => const SignupView()));
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
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Stack(children: [
                      Image.asset(
                        fit: BoxFit.cover,
                        "assets/images/image 2.png",
                        scale: 3,
                      ),
                      Container(
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.13,
                            top: MediaQuery.of(context).size.height * 0.055),
                        child: Image.asset(
                          fit: BoxFit.cover,
                          "assets/images/image 1.png",
                          scale: 3,
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
