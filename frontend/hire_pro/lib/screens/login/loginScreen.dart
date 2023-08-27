import 'package:hire_pro/controllers/login.dart';
import 'package:hire_pro/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/FormFieldRegular.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/GoogleLogin.dart';
import 'package:hire_pro/widgets/LineDivider.dart';
import 'package:hire_pro/widgets/TermsAndPolicy.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late SharedPreferences preferences;
  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  String errorMessage = '';
  void initSharedPref() async {
    preferences = await SharedPreferences.getInstance();
  }

  Api api = Api();
  Login login = Login();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('images/hireProWithoutBG.png'),
                      GoogleLogin(),
                      const LineDivider(),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FormFieldRegular('Your Email', emailController, false,
                          Icon(Icons.email_rounded)),
                      FormFieldRegular('Password', passwordController, true,
                          Icon(Icons.lock_rounded)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(errorMessage),
                      Container(
                        width: 350,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: kMainYellow, fontSize: 14),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      MainButton('Login', () {
                        api.loginUser(emailController, passwordController,
                            preferences, context);
                        // Navigator.pushNamed(context, '/home');
                      }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/otp');
                            },
                            child: Text(
                              'Sign up',
                              style:
                                  TextStyle(color: kMainYellow, fontSize: 14),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ]),
            ),
            const Expanded(
              flex: 3,
              child: TermsAndPolicy(),
            )
          ],
        ),
      ),
    ));
  }
}
