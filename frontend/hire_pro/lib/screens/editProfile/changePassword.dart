import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/screens/editProfile/passwordChecker.dart';
import 'package:hire_pro/services/api.dart';
import 'package:hire_pro/widgets/HireProAppBar.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/ToggleEyeField.dart';
import 'package:hire_pro/widgets/passwordValidateField.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _obscureText = true;
  IconData _icon = FontAwesomeIcons.eyeSlash;
  PasswordChecker checker = PasswordChecker();
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController newPasswordDup = TextEditingController();

  @override
  void dispose() {
    currentPassword.dispose();
    newPassword.dispose();
    newPasswordDup.dispose();
    super.dispose();
  }

  Api api = Api();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                          controller: currentPassword,
                          obscureText: _obscureText,
                          icon: _icon,
                          placeholder: 'Enter current password'),
                      passwordValidateField(
                          controller: newPassword,
                          obscureText: _obscureText,
                          icon: _icon,
                          placeholder: 'Enter new password'),
                      ToggleEyeField(
                          controller: newPasswordDup,
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
                        checker.matchPasswords(currentPassword.text,
                            newPassword.text, newPasswordDup.text, context);
                      }),
                    ],
                  ),
                )
              ]),
            )));
  }
}
