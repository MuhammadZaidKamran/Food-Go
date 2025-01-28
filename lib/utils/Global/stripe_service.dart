import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_go/utils/Global/stripe_keys.dart';
import 'package:http/http.dart' as http;

class StripeService {
  static final StripeService instance = StripeService();

  Future<void> makePayment({required amount}) async {
    try {
      String? paymentIntentClientSecret =
          await createPaymentIntent(amount, "usd");
      if (paymentIntentClientSecret == null) return;
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentClientSecret,
        merchantDisplayName: "FoodGo",
      ));
      await showPaymentSheet();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String?> createPaymentIntent(int amount, String currency) async {
    try {
      var url = "https://api.stripe.com/v1/payment_intents";
      var uri = Uri.parse(url);
      var response = await http.post(
        uri,
        body: {
          "amount": calculatedAmount(amount),
          "currency": currency,
        },
        headers: {
          "Authorization": "Bearer $stripeSecretKey",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint(data.toString());
        return data["client_secret"];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> showPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      await Stripe.instance.confirmPaymentSheetPayment();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  String? calculatedAmount(int amount) {
    final finalAmount = amount * 100;
    return finalAmount.toString();
  }
}
