import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_go/View/SplashView/splash_view.dart';
import 'package:food_go/firebase_options.dart';
import 'package:food_go/utils/Global/flutter_notification_service.dart';
import 'package:food_go/utils/Global/stripe_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNotificationService.init();
  Stripe.publishableKey = stripePublishableKey;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: 
      // LoginView(),
      SplashView(),
    );
  }
}
