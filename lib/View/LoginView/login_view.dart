import 'package:flutter/material.dart';
import 'package:food_go/View/SignupView/signup_view.dart';
import 'package:food_go/ViewModel/LoginViewModel/login_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Widgets/TextFieldWidget/textfield_widget_2.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Column(
              children: [
                Stack(children: [
                  Container(
                    padding: EdgeInsets.only(top: 20),
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
                        Image.asset(
                          "assets/images/burger-icon.webp",
                          scale: 3.5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 35),
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.34),
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
                          textField_2(
                              "Email", Icons.mail, viewModel.emailController),
                          SizedBox(
                            height: 20,
                          ),
                          textField_2("Password", Icons.key,
                              viewModel.passwordController),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(color: AppColors.darkRed),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
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
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an Account?"),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupView()));
                      },
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                            color: AppColors.darkRed,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Spacer(),
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
          );
        });
  }
}
