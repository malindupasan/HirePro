import 'package:flutter/material.dart';
import 'package:hirepro/constants.dart';
import 'package:hirepro/providers/customer_provider.dart';
import 'package:hirepro/widgets/SmallSquareInput.dart';
import 'package:hirepro/widgets/SmallArrowButton.dart';
import 'package:hirepro/widgets/TermsAndPolicy.dart';
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
                              () async {
                            String code = digit1.text +
                                digit2.text +
                                digit3.text +
                                digit4.text +
                                digit5.text;
                            print(code);
                            final customer = Provider.of<CustomerProvider>(
                                context,
                                listen: false);
                            print(code);
                            if (await customer.verifyCode(code)) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor:
                                            Color.fromARGB(255, 42, 201, 74),
                                        content: Text('Code Verified!')));
                                Navigator.pushNamed(
                                    context, '/register_success');
                              }
                            } else {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor:
                                            Color.fromARGB(255, 255, 104, 87),
                                        content:
                                            Text('Code Verification failed!')));
                              }
                            }
                            // int codeno=  int.parse(code);
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
