import 'package:flutter/material.dart';
import 'package:hirepro/constants.dart';
import 'package:hirepro/services/stripeService.dart';
import 'package:hirepro/widgets/SmallArrowButton.dart';
import 'package:hirepro/widgets/TermsAndPolicy.dart';
import 'package:hirepro/widgets/check_icon_large.dart';

class TaskCompletedScreen extends StatelessWidget {
  StripeService stripeService = StripeService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('images/hireProWithoutBG.png'),
                    CheckIconLarge(),
                    Column(
                      children: [
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                          alignment: Alignment.center,
                          child: Text(
                            'Your task has been completed',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text(
                            'To complete your payment, just tap the button below.'),
                      ],
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                      child: SmallArrowButton(kMainYellow, Icons.arrow_forward,
                          () {
                        print("clicked");
                        stripeService.makePayment();
                       
                      }),
                    ),
                  ]),
            ),
            Expanded(child: TermsAndPolicy()),
          ],
        ),
      ),
    ));
  }
}
