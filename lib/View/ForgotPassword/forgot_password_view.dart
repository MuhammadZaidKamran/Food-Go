import 'package:flutter/material.dart';
import 'package:food_go/ViewModel/ForgotPasswordViewModel/forgot_password_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/TextFieldWidget/textfield_widget_2.dart';
import 'package:stacked/stacked.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => ForgotPasswordViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 20),
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
                      height(30),
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
                        ),
                      ),
                      Image.asset(
                        "assets/images/burger-icon.webp",
                        scale: 3.5,
                      ),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                      const Text(
                        "  FORGOT\nPASSWORD",
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
                        top: MediaQuery.of(context).size.height * 0.015),
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        textField_2(
                            "Email", Icons.mail, viewModel.emailController),
                        const SizedBox(
                          height: 20,
                        ),
                        // textField_2("Password", Icons.key,
                        //     viewModel.passwordController),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: InkWell(
                        //     onTap: () {
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) =>
                        //                   ForgotPasswordView()));
                        //     },
                        //     child: Text(
                        //       "Forgot Password?",
                        //       style: TextStyle(color: AppColors.darkMainTheme),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 15,
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
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const BottomNavBarView()));
                              },
                              child: const Text(
                                "Send Email",
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
              ],
            ),
          );
        });
  }
}
