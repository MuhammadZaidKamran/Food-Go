import 'package:flutter/material.dart';
import 'package:food_go/ViewModel/SignupViewModel/signup_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Widgets/TextFieldWidget/textfield_widget_3.dart';
import 'package:stacked/stacked.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => SignupViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Column(
              children: [
                Stack(children: [
                  Container(
                    padding: EdgeInsets.only(top: 27, left: 15, right: 15),
                    height: MediaQuery.of(context).size.height * 0.39,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(70),
                            bottomRight: Radius.circular(70)),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              AppColors.redColor,
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
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white),
                                  child: Icon(
                                    Icons.arrow_back_ios_new,
                                    color: AppColors.redColor,
                                  )),
                            )),
                        Image.asset(
                          "assets/images/burger-icon.webp",
                          scale: 4,
                        ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        Text(
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
                        top: MediaQuery.of(context).size.height * 0.73),
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
                              top: MediaQuery.of(context).size.height * 0.085),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.333),
                      //height: 350,
                      width: MediaQuery.of(context).size.width * 0.92,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                const Color.fromARGB(205, 158, 158, 158),
                                const Color.fromARGB(231, 255, 255, 255)
                                // const Color.fromARGB(255, 0, 0, 0),
                                // const Color.fromARGB(255, 255, 255, 255),
                                // const Color.fromARGB(255, 0, 0, 0)
                              ])),
                      child: Column(
                        children: [
                          textField_3("Username", Icons.account_circle,
                              viewModel.userController_1),
                          SizedBox(
                            height: 15,
                          ),
                          textField_3(
                              "Email", Icons.mail, viewModel.emailController_1),
                          SizedBox(
                            height: 15,
                          ),
                          textField_3("Password", Icons.key,
                              viewModel.passwordController_1),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: AppColors.darkRed,
                                elevation: 5,
                                onPressed: () {},
                                child: Text(
                                  "SignUp",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
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
                                      width: MediaQuery.of(context).size.width *
                                          0.11,
                                    ),
                                    Text(
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
          );
        });
  }
}
