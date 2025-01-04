// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go/View/BottomNavBarView/bottom_nav_bar_view.dart';
import 'package:food_go/View/LoginView/login_view.dart';
import 'package:food_go/ViewModel/SplashViewModel/splash_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
//import 'package:google_fonts/google_fonts.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onViewModelReady: (viewModel) {
          Future.delayed(const Duration(seconds: 2), () async {
            if (viewModel.user == null) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginView()));
            } else if (viewModel.user != null) {
              userID = FirebaseAuth.instance.currentUser!.uid;
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BottomNavBarView()));
            }
          });
        },
        viewModelBuilder: () => SplashViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Container(
              padding: EdgeInsets.zero,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topLeft,
                      colors: [
                    AppColors.mainTheme,
                    const Color.fromARGB(255, 218, 127, 127)
                  ])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Align(
                    heightFactor: 5.0,
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Foodgo",
                      style: TextStyle(
                          fontSize: 39,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Stack(children: [
                      Image.asset(
                        fit: BoxFit.cover,
                        "assets/images/image 2.png",
                        height: 190,
                        width: 160,
                      ),
                      Container(
                        padding: EdgeInsets.zero,
                        margin: const EdgeInsets.only(left: 70, top: 10),
                        child: Image.asset(
                          fit: BoxFit.cover,
                          "assets/images/image 1.png",
                          height: 180,
                          width: 165,
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
