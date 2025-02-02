import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_go/View/OrderSuccessfulView/order_successful_view.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Global/stripe_keys.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class StripeService {
  static final StripeService instance = StripeService();

  Future makePayment({
    required amount,
    required context,
    required address,
    required platformFee,
    required deliveryCharges,
    required totalAmount,
    required note,
  }) async {
    try {
      String? paymentIntentClientSecret =
          await createPaymentIntent(amount, "usd");
      if (paymentIntentClientSecret == null) return;
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentClientSecret,
        merchantDisplayName: "FoodGo",
      ));
      await showPaymentSheet(
          context, address, platformFee, deliveryCharges, totalAmount, note);
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
    return null;
  }

  Future showPaymentSheet(
      context, address, platformFee, deliveryCharges, totalAmount, note) async {
    try {
      final currentDate = DateFormat("dd/MM/yyyy").format(DateTime.now());
      String dateTime = DateTime.now().millisecondsSinceEpoch.toString();
      await Stripe.instance.presentPaymentSheet().then((value) async {
        await FirebaseFirestore.instance
            .collection("orders")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection(FirebaseAuth.instance.currentUser!.uid)
            .doc(dateTime)
            .set({
          "orderId": dateTime,
          "userID": FirebaseAuth.instance.currentUser!.uid,
          "date": currentDate,
          "orderItems": cartItems,
          "status": 0,
          "address": address,
          "platFormFee": platformFee,
          "deliveryCharges": deliveryCharges,
          "totalAmount": totalAmount,
          "note": note,
        }).then((value) async {
          await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => OrderSuccessfulView(
                        status: 0,
                        date: currentDate,
                        orderId: dateTime,
                        userId: FirebaseAuth.instance.currentUser!.uid,
                        orderConfirmedList: cartItems,
                        address: address,
                        platformFee: platformFee,
                        deliveryCharges: deliveryCharges,
                        totalAmount: totalAmount,
                        note: note,
                      )));
        });
      });
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
