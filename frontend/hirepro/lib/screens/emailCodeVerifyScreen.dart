import 'package:flutter/material.dart';
import 'package:hirepro/constants.dart';
import 'package:hirepro/services/email.dart';
import 'package:hirepro/widgets/MediumButton.dart';
import 'package:hirepro/widgets/SquareInputBox.dart';

class EmailCodeVerifyScreen extends StatefulWidget {
  const EmailCodeVerifyScreen({super.key});

  @override
  State<EmailCodeVerifyScreen> createState() => _EmailCodeVerifyScreenState();
}

class _EmailCodeVerifyScreenState extends State<EmailCodeVerifyScreen> {
  Email email = Email();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    int code = email.generateRandomNumber();
    email.sendEmail(
        name: 'Harini Samaliarachchi',
        email: '$args',
        subject: 'Email Verification Code',
        message:
            'To change your email address please verify with the 5 digit code $code');
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(40),
          child: Column(
            children: [
              Image.asset('images/hireProWithoutBG.png'),
              Text(
                'Enter the code sent to your email: $args',
                style: kHeading1.copyWith(fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareInputBox(),
                  SquareInputBox(),
                  SquareInputBox(),
                  SquareInputBox(),
                  SquareInputBox(),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              MediumButton('Continue', () {}, kMainYellow, Colors.white),
            ],
          ),
        ),
      ),
    ));
    ;
  }
}
