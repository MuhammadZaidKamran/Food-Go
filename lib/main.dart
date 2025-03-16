import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_go/View/SplashView/splash_view.dart';
import 'package:food_go/firebase_options.dart';
import 'package:food_go/utils/Global/flutter_notification_service.dart';
import 'package:food_go/utils/Global/stripe_keys.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestExactAlarmPermission();
  await FlutterNotificationService.init();
  Stripe.publishableKey = stripePublishableKey;
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
        name: "food-go", options: DefaultFirebaseOptions.currentPlatform);
  }
  runApp(const MyApp());
}

Future<void> requestExactAlarmPermission() async {
  if (await Permission.scheduleExactAlarm.isDenied) {
    await openAppSettings();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),
    );
  }
}
