import 'package:flutter/material.dart';
import 'package:hirepro/controllers/signup_controller.dart';
import 'package:hirepro/providers/customer_provider.dart';
import 'package:hirepro/services/email.dart';
import 'package:hirepro/widgets/FormFieldRegular.dart';
import 'package:hirepro/widgets/MainButton.dart';
import 'package:hirepro/widgets/TermsAndPolicy.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatelessWidget {
  SignupController signupController = SignupController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  Email email_verify = Email();

  final _signupFormKey = GlobalKey<FormState>();
  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

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
                  return null;
                }),
                FormFieldRegular(
                    'Phone Number', phoneController, false, Icon(Icons.phone),
                    (val) {
                  if (signupController.phoneValidator(val) != null) {
                    return signupController.phoneValidator(val);
                  }
                  return null;
                }),
                FormFieldRegular(
                    'Your Email', emailController, false, Icon(Icons.mail),
                    (val) {
                  if (signupController.emailValidator(val) != null)
                    return signupController.emailValidator(val);
                  return null;
                }),
                FormFieldRegular(
                    'Password', passwordController, true, Icon(Icons.lock),
                    (val) {
                  if (signupController.passwordValidator(val) != null)
                    return signupController.passwordValidator(val);
                  return null;
                }),
                MainButton('Send OTP', () async {
                  if (_signupFormKey.currentState!.validate()) {
                    int code = email_verify.generateRandomNumber();
                    final customer =
                        Provider.of<CustomerProvider>(context, listen: false);
                    bool response = await customer.register(
                        nameController.text,
                        emailController.text,
                        phoneController.text,
                        passwordController.text);
                    await customer.sendVerifyCode(code);
                    if (response) {
                      if (context.mounted) {
                        Navigator.pushNamed(context, '/otp_enter',
                            arguments: emailController.text);

                        email_verify.sendEmail(
                            name: nameController.text,
                            email: emailController.text,
                            subject: 'Email Verification Code',
                            message:
                                'To change your email address please verify with the 5 digit code $code');

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              backgroundColor: Color.fromARGB(255, 42, 201, 74),
                              content: Text('Account created successfully!')),
                        );
                      } else {
                        print('context not mounted');
                      }
                    } else {
                      print('response error');
                    }
                  }
                })
              ]),
            ),
            const TermsAndPolicy(),
          ],
        ),
      ),
    ));
  }
}
