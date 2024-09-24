import 'package:cssd/feature/cssd_as_custodian/Cssd_Login/view/dashboard_view.dart';
import 'package:cssd/view/login_screen.dart';
import 'package:cssd/view/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashScreen = '/';
  static const String loginScreen = '/loginScreen';
  /*cssd pages  -- cssd custodian*/ 
  static const String cssdDashboard = '/cssdDashboard'; 

  static final Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => const Splash(),
    loginScreen: (context) => const LoginScreen(),
    /*cssd pages -- cssd custodian*/
    cssdDashboard: (context) => const DashboardView_cssdlogin_cssdcustodian(),
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