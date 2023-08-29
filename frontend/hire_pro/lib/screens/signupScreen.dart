import 'package:flutter/material.dart';
import 'package:hire_pro/controllers/signup_controller.dart';
import 'package:hire_pro/widgets/FormFieldRegular.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/TermsAndPolicy.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  SignupController signupController = SignupController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final _signupFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: _signupFormKey,
              child: Column(children: [
                Image.asset('images/hireProWithoutBG.png'),
                FormFieldRegular(
                    'Full Name', nameController, false, Icon(Icons.person),
                    (val) {
                  if (signupController.nameValidator(val) != null)
                    return signupController.nameValidator(val);
                return null;}),
                FormFieldRegular(
                    'Phone Number', phoneController, false, Icon(Icons.phone),
                    (val) {
                  if (signupController.phoneValidator(val) != null) {
                    return signupController.phoneValidator(val);
                  }
                  return null;
                }),
                FormFieldRegular(
                    'Your Email',
                    emailController,
                    false,
                    Icon(Icons.mail),
                      (val) {
                  if (signupController.emailValidator(val) != null)
                    return signupController.emailValidator(val);
                return null;}),
                FormFieldRegular(
                    'Password',
                    passwordController,
                    true,
                    Icon(Icons.lock),
                      (val) {
                  if (signupController.passwordValidator(val) != null)
                    return signupController.passwordValidator(val);
                return null;}),
                MainButton('Send OTP', () {
                  if (_signupFormKey.currentState!.validate()) {
                    Navigator.pushNamed(context, '/otp_enter');
                  }
                })
              ]),
            ),
            TermsAndPolicy(),
          ],
        ),
      ),
    ));
  }
}
