import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/HireProAppBar.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/Toast.dart';
import 'package:hire_pro/widgets/ToggleEyeField.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _obscureText = true;
  IconData _icon = FontAwesomeIcons.eyeSlash;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: HireProAppBar(context, 'Change Password'),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ToggleEyeField(
                          obscureText: _obscureText,
                          icon: _icon,
                          placeholder: 'Enter current password'),
                      ToggleEyeField(
                          obscureText: _obscureText,
                          icon: _icon,
                          placeholder: 'Enter new password'),
                      ToggleEyeField(
                          obscureText: _obscureText,
                          icon: _icon,
                          placeholder: 'Re enter new password'),
                      Container(
                        width: 350,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: kMainYellow, fontSize: 14),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      MainButton('Change Password', () {
                        Toast()
                            .SuccessToast('Password changed', 'successfully!')
                            .show(context);
                      }),
                    ],
                  ),
                )
              ]),
            )));
  }
}
