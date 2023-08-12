import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toastification/toastification.dart';

class PasswordChecker {
  String validatePassword(String input) {
    if (input != '') {}
    if (input.length < 8) {
      return "Password must be at least 8 characters long.";
    }

    bool hasDigit = false;
    bool hasSpecialChar = false;

    for (int i = 0; i < input.length; i++) {
      if (input[i].contains(RegExp(r'[0-9]'))) {
        hasDigit = true;
      } else if (input[i].contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        hasSpecialChar = true;
      }

      if (hasDigit && hasSpecialChar) {
        return "Password is valid";
      }
    }

    if (!hasDigit) {
      return "Password must contain at least one digit.";
    }

    if (!hasSpecialChar) {
      return "Password must contain at least one special character.";
    }

    return "Password is valid";
  }

  matchPasswords(String newPassword, String newPasswordDup, context) {
    if (newPassword != newPasswordDup) {
      {
        toastification.showError(
            context: context,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            icon: Icon(FontAwesomeIcons.circleExclamation),
            title: 'Passwords do not match!',
            autoCloseDuration: const Duration(seconds: 3),
            borderRadius: BorderRadius.circular(20),
            backgroundColor: Color.fromARGB(255, 253, 110, 81));
      }
    } else {
      toastification.showSuccess(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          context: context,
          icon: Icon(FontAwesomeIcons.circleCheck),
          title: 'Password changed successfully!',
          autoCloseDuration: const Duration(seconds: 3),
          borderRadius: BorderRadius.circular(20),
          backgroundColor: Color.fromARGB(255, 62, 163, 47));
    }
  }
}
