import 'package:flutter_flex/utils/validator.dart';

class AuthUtils {
  /// Form validation for email address field.
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    } else if (Validator.validateEmail(email) == false) {
      return 'Please enter a valid email';
    }
    return null;
  }

  /// Form validation for password field.
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    } else if (password.length < 6) {
      return 'Password must be 6 characters long';
    }
    return null;
  }
}
