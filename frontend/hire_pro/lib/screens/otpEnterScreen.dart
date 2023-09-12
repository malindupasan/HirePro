import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/providers/customer_provider.dart';
import 'package:hire_pro/widgets/SmallSquareInput.dart';
import 'package:hire_pro/widgets/SmallArrowButton.dart';
import 'package:hire_pro/widgets/TermsAndPolicy.dart';
import 'package:provider/provider.dart';

class OtpEnterScreen extends StatelessWidget {
  final TextEditingController digit1 = TextEditingController();
  final TextEditingController digit2 = TextEditingController();
  final TextEditingController digit3 = TextEditingController();
  final TextEditingController digit4 = TextEditingController();
  final TextEditingController digit5 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    dynamic email = ModalRoute.of(context)!.settings.arguments;
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('images/hireProWithoutBG.png'),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      alignment: Alignment.center,
                      child: Text(
                        'Enter the 5-digit code sent to you at $email',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SmallSquareInput(digit1),
                        SmallSquareInput(digit2),
                        SmallSquareInput(digit3),
                        SmallSquareInput(digit4),
                        SmallSquareInput(digit5),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey[200],
                      ),
                      height: 40,
                      width: 245,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('I haven\'t received a code (0.09)',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              )),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmallArrowButton(kSecondaryYellow, Icons.arrow_back,
                              () {
                            Navigator.pop(context);
                          }),
                          SmallArrowButton(kMainYellow, Icons.arrow_forward,
                              () {
                          //   String code =
                          //       '{$digit1.text}.{$digit2.text}.{$digit3.text}.{$digit4.text}.{$digit5.text}';
                          // int codeno=  int.parse(code);

                            // Navigator.pushNamed(context, '/register_success');
                          }),
                        ],
                      ),
                    ),
                  ]),
            ),
            const Expanded(child: TermsAndPolicy()),
          ],
        ),
      ),
    ));
  }
}
