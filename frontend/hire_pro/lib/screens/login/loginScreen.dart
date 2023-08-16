import 'dart:convert';
import 'package:hire_pro/env.dart';
import 'package:hire_pro/widgets/MyNavigationWidget.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/FormFieldRegular.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/GoogleLogin.dart';
import 'package:hire_pro/widgets/LineDivider.dart';
import 'package:hire_pro/widgets/TermsAndPolicy.dart';
import 'package:http/http.dart' as http;

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

  void loginUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var reqBody = {
        'email': emailController.text,
        'password': passwordController.text,
      };
      var response = await http.post(Uri.parse(login),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(reqBody));
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        print(jsonResponse['status']);
        var myToken = jsonResponse['token'];
        sesstionToken = myToken;
        Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(myToken);
        id = jwtDecodedToken['id'];
        preferences.setString('token', myToken);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyNavigationWidget(token: myToken)));
        // Navigator.pushNamed(context, '/category');
      } else {
        print('ggggg');
      }
    }
  }

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
                      FormFieldRegular('Your Email', emailController, false),
                      FormFieldRegular('Password', passwordController, true),
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
                        loginUser();
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
