import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  // show or hide password
  bool _obscureText = false;
  bool get obscureText => _obscureText;

  void toggleObscureText(bool value) {
    _obscureText = value;
    notifyListeners();
  }

  //text controllers
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController loginPhoneNumberController = TextEditingController();
}
