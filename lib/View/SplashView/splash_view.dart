// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go/View/BottomNavBarView/bottom_nav_bar_view.dart';
import 'package:food_go/View/LoginView/login_view.dart';
import 'package:food_go/ViewModel/SplashViewModel/splash_view_model.dart';
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
            if (FirebaseAuth.instance.currentUser == null) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginView()));
            } else {
              if (FirebaseAuth.instance.currentUser!.emailVerified == true) {
                userID = FirebaseAuth.instance.currentUser!.uid;
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BottomNavBarView()));
              } else {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginView()));
              }
            }
          });
        },
        viewModelBuilder: () => SplashViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            body: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "assets/images/splash_screen.png",
                  fit: BoxFit.cover,
                )),
          );
        });
  }
}
