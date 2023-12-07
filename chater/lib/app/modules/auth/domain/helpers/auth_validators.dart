import 'package:flutter/foundation.dart';

class AuthValidators {
  // Create error messages to send.

  final String _passwordErrMsg = "Password must have at least 6 characters.";

// A simple email validator that  checks the presence and position of @
  String? emailValidator(String? val) {
    debugPrint("emailValidator $val");
    if (val != null) {
      final bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(val);
      // if (emailValid == false) {
      if (!emailValid) {
        return "Emial is Not Valid";
      }
    }
    return null;
  }

  // Password validator
  String? passwordVlidator(String? val) {
    final String password = val as String;

    if (password.isEmpty || password.length <= 5) return _passwordErrMsg;

    return null;
  }

  String? userNameValidator(String? val) {
    if (val != null && val.length > 3) {
      return null;
    } else {
      return "UserNama must be more than 3 charecters";
    }
  }
}
