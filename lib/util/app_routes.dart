import 'package:cssd/feature/cssd_as_custodian/Cssd_User/view/alert_view.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/view/dashboard_view.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/view/requests_view.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/view/widgets/dashboard_widgets/bottom_navigation_bar.dart';

import 'package:cssd/view/login_screen.dart';
import 'package:cssd/view/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashScreen = '/';
  static const String loginScreen = '/loginScreen';
  /*cssd pages  -- cssd custodian*/
  static const String bottomNavBarDashboard = '/BottomNavigationBarDashboard';
  static const String dashboardView_cssdUser_cssdcustodian = '/dashboardView_cssdUser_cssdcustodian';
  static const String alertView_cssdCus_cssdLogin = '/AlertView_cssdCus_cssdLogin';
  static const String requestsView_cssdUser_cssdcustodian = '/RequestsView_cssdUser_cssdcustodian';

  static final Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => const Splash(),
    loginScreen: (context) => const LoginScreen(),
    /*cssd pages -- cssd custodian*/
    bottomNavBarDashboard: (context) => const BottomNavigationBarDashboard(),
    dashboardView_cssdUser_cssdcustodian: (context) =>  const DashboardView_cssdUser_cssdcustodian(),
    alertView_cssdCus_cssdLogin: (context) =>  const AlertView_cssdCus_cssdLogin(),
    requestsView_cssdUser_cssdcustodian: (context) =>   RequestsView_cssdUser_cssdcustodian(),
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