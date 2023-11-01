import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hirepro/env.dart';
import 'package:http/http.dart' as http;

class StripeService {
  Map<String, dynamic>? paymentIntent;
  final Function onSuccess;
  final Function onFailure;

  // Constructor to accept success and failure callbacks
  StripeService({required this.onSuccess, required this.onFailure});

  void makePayment(amount) async {
    try {
      print("dd");
      paymentIntent = await createPaymentIntent(amount);
      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: "US", currencyCode: "USD", testEnv: true);

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!["client_secret"],
              style: ThemeMode.light,
              merchantDisplayName: 'HirePro',
              googlePay: gpay));

      displayPaymentSheet();
    } catch (e) {
      print("dd");
      print(e);
      onFailure(e.toString());
    }
  }

  void displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print('done');
      onSuccess();
    } catch (e) {
      if (e is StripeException) {
        print(e.error.message);
      }
      print('failed');
      onFailure(e.toString());
    }
  }

  createPaymentIntent(amount) async {
    try {
      Map<String, dynamic> body = {"amount":"$amount", "currency": "USD"};
      http.Response response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer $stripePrivateKey',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print(response.body);
      return json.decode(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
