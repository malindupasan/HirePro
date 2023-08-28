import 'package:hire_pro/controllers/signup_controller.dart';
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
  SignupController signupController = SignupController();
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
  final _loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            Form(
              key: _loginFormKey,
              child: Expanded(
                flex: 10,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
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
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FormFieldRegular('Your Email', emailController,
                                false, Icon(Icons.email_rounded), (val) {
                              if (signupController.emailValidator(val) != null)
                                return signupController.emailValidator(val);
                              return null;
                            }),
                            FormFieldRegular('Password', passwordController,
                                true, Icon(Icons.lock_rounded), (val) {
                              if (val == null || val.isEmpty) {
                                return "Password can't be empty";
                              }
                              return null;
                            }),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(errorMessage),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                'Forgot Password?',
                                style:
                                    TextStyle(color: kMainYellow, fontSize: 14),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            MainButton('Login', () {
                              if (_loginFormKey.currentState!.validate()) {
                                api.loginUser(emailController,
                                    passwordController, preferences, context);
                              } // Navigator.pushNamed(context, '/home');
                            }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/otp');
                                  },
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(
                                        color: kMainYellow, fontSize: 14),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
            const Expanded(
              flex: 2,
              child: TermsAndPolicy(),
            )
          ],
        ),
      ),
    ));
  }
}
