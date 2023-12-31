import 'dart:convert';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:flutter/material.dart';
import 'package:hirepro/constants.dart';
import 'package:hirepro/services/email.dart';
import 'package:hirepro/widgets/MediumButton.dart';

class EmailcodereqScreen extends StatefulWidget {
  const EmailcodereqScreen({super.key});

  @override
  State<EmailcodereqScreen> createState() => _EmailcodereqScreenState();
}

class _EmailcodereqScreenState extends State<EmailcodereqScreen> {
  Email email = Email();

  @override
  Widget build(BuildContext context) {
    String jsondata =
        '{"full_name": "John Doe", "email": "samaliarachchih@gmail.com", "phone_number": "123-456-7890"}';
    var userData = jsonDecode(jsondata);

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(40).copyWith(top: 0),
          child: Column(
            children: [
              Image.asset('images/hireProWithoutBG.png'),
              Text(
                'Press "Continue" to receive a 5-digit code to change your email address.',
                style: kHeading1.copyWith(fontWeight: FontWeight.w400),
              ),
            const  SizedBox(
                height: 50,
              ),
              Image.asset('images/email.png', height: 250),
           const   SizedBox(
                height: 50,
              ),
              MediumButton('Continue', () {
                Navigator.pushNamed(context, '/emailcodeverify',
                    arguments: userData['email']);
              }, kMainYellow, Colors.white),
            ],
          ),
        ),
      ),
    ));
    ;
  }
}
