import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hirepro/constants.dart';
import 'package:hirepro/screens/editProfile/passwordChecker.dart';
import 'package:hirepro/services/api.dart';
import 'package:hirepro/widgets/HireProAppBar.dart';
import 'package:hirepro/widgets/MainButton.dart';
import 'package:hirepro/widgets/ToggleEyeField.dart';
import 'package:hirepro/widgets/passwordValidateField.dart';

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
            body: SingleChildScrollView(
              child: Container(
                height: 400,
                margin: EdgeInsets.symmetric(horizontal: 15),
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
                      MainButton('Change Password', () {
                        checker.matchPasswords(currentPassword.text,
                            newPassword.text, newPasswordDup.text, context);
                      }),
                    ]),
              ),
            )));
  }
}
