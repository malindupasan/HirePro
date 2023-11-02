import 'package:flutter/material.dart';
import 'package:hirepro/constants.dart';
import 'package:hirepro/env.dart';
import 'package:hirepro/providers/task_provider.dart';
import 'package:hirepro/services/stripeService.dart';
import 'package:hirepro/widgets/MyNavigationWidget.dart';
import 'package:hirepro/widgets/SmallArrowButton.dart';
import 'package:hirepro/widgets/TermsAndPolicy.dart';
import 'package:hirepro/widgets/check_icon_large.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskCompletedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    dynamic id = ModalRoute.of(context)!.settings.arguments;
    StripeService stripeService = StripeService(
        onSuccess: () {
          Navigator.pushNamed(context, '/rating', arguments: id);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Color.fromARGB(255, 42, 201, 74),
              content: Text('Payment success!')));
        },
        onFailure: () {});
    return SafeArea(
        child: Scaffold(

            // bottomNavigationBar: MyNavigationWidget(token: sesstionToken),
            resizeToAvoidBottomInset: false,
            body: Consumer<TaskProvider>(
              builder: (context, value, child) => Center(
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
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 5),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Your task has been completed',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(
                                    'To complete your payment, just tap the button below.'),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 30),
                              child: SmallArrowButton(
                                  kMainYellow, Icons.arrow_forward, () {
                                print("clicked");
                                stripeService.makePayment('1000');
                              }),
                            ),
                          ]),
                    ),
                    Expanded(child: TermsAndPolicy()),
                  ],
                ),
              ),
            )));
  }
}
