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
}
