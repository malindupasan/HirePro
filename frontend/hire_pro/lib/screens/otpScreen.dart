import 'package:flutter/material.dart';
import 'package:hire_pro/widgets/FormFieldRegular.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/TermsAndPolicy.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
              Image.asset('images/hireProWithoutBG.png'),
              FormFieldRegular(
                  'Full Name', nameController, false, Icon(Icons.person)),
              FormFieldRegular(
                  'Phone Number', phoneController, false, Icon(Icons.phone)),
              FormFieldRegular(
                  'Your Email', emailController, false, Icon(Icons.mail)),
              FormFieldRegular(
                  'Password', passwordController, false, Icon(Icons.lock)),
              MainButton('Send OTP', () {
                Navigator.pushNamed(context, '/otp_enter');
              })
            ]),
            TermsAndPolicy(),
          ],
        ),
      ),
    ));
  }
}
