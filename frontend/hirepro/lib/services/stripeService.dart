import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hirepro/env.dart';
import 'package:http/http.dart' as http;

class StripeService {
  Map<String, dynamic>? paymentIntent;
  void makePayment() async {
    try {
      print("dd");
      paymentIntent = await createPaymentIntent();
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
    }
  }

  void displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print('done');
    } catch (e) {
      if (e is StripeException) {
        print(e.error.message);
      }
      print('failed');
    }
  }

  createPaymentIntent() async {
    try {
      Map<String, dynamic> body = {"amount": "1000", "currency": "USD"};
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
