import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hirepro/screens/editProfile/passwordChecker.dart';

class passwordValidateField extends StatefulWidget {
  passwordValidateField({
    super.key,
    required TextEditingController controller,
    required bool obscureText,
    required IconData icon,
    required String placeholder,
  })  : _obscureText = obscureText,
        _icon = icon,
        _placeholder = placeholder,
        _controller = controller;

  bool _obscureText;
  IconData _icon;
  String _placeholder;
  TextEditingController _controller;
  @override
  State<passwordValidateField> createState() => _passwordValidateFieldState();
}

class _passwordValidateFieldState extends State<passwordValidateField> {
  void _toggleVisibility() {
    setState(() {
      // print('tapped');
      widget._obscureText = !widget._obscureText;
      widget._icon = widget._obscureText
          ? FontAwesomeIcons.eyeSlash
          : FontAwesomeIcons.eye;
    });
  }

  PasswordChecker passwordChecker = PasswordChecker();
  String? message;
  @override
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._controller,
      obscureText: widget._obscureText,
      onChanged: (text) {
        setState(() {
          message = passwordChecker.validatePassword(text);
        });
      },
      decoration: InputDecoration(
          errorText: message == "Password is valid" ? '' : message,
          errorStyle: message == 'Password is valid'
              ? TextStyle(fontSize: 13, color: Colors.green)
              : TextStyle(
                  fontSize: 13,
                  color: Colors.red,
                ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          suffixIcon: GestureDetector(
            onTap: _toggleVisibility,
            child: Icon(
              widget._icon,
              size: 15,
            ),
          ),
          hintText: widget._placeholder,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: message == 'Password is valid'
                      ? Color.fromARGB(255, 89, 193, 93)
                      : Colors.red)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: message == 'Password is valid'
                      ? Colors.green
                      : Colors.red))),
    );
  }
}
