import 'package:cssd/view/login_screen.dart';
import 'package:cssd/view/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashScreen = '/';
  static const String loginScreen = '/loginScreen';

  static final Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => const Splash(),
    loginScreen: (context) => const LoginScreen(),
  };
}


// /*  Navigations 


// Navigator.pushNamedAndRemoveUntil(
//   context,
//   Routes.home,
//   (Route<dynamic> route) => false, 
// );

// Navigator.pushReplacementNamed(context, Routes.login);

// Navigator.pushNamed(context, Routes.details);

// Navigator.pushNamed(
//   context,
//   Routes.deviceSettings,
//   arguments: {
//     'name': 'ExampleName',
//     'id': 'ExampleID',
//   },
// );

// Navigator.popUntil(context, ModalRoute.withName(Routes.home));

// */