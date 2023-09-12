import 'package:flutter/material.dart';
import 'package:hire_pro/controllers/signup_controller.dart';
import 'package:hire_pro/providers/customer_provider.dart';
import 'package:hire_pro/services/email.dart';
import 'package:hire_pro/widgets/FormFieldRegular.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/TermsAndPolicy.dart';
import 'package:provider/provider.dart';

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
  Email email_verify = Email();

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
                    // await customer.sendVerifyCode(code);
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
                      print('kk');
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
