import 'dart:async';
import 'dart:developer';

import 'package:cssd/util/app_routes.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/local_storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await checkIfAlreadyLoggedin(); //turn on later check
    });

    super.initState();
  }

  Future<void> checkIfAlreadyLoggedin() async {
    final bool? hasPrivileges =
        LocalStorageManager.getBool(StorageKeys.privilegeFlagCssdAndDept);
    final String? currentToken =
        LocalStorageManager.getString(StorageKeys.loginToken);
    final List<String> privilegesList = LocalStorageManager.getStringList(
            StorageKeys.loggedinUserPrivilegesList) ??
        [];
    if (currentToken != null) {
      log("Token exists $currentToken");
      log("Previleges for the user : $hasPrivileges");
      if (privilegesList.contains("312") && privilegesList.contains("316")) {
        Navigator.pushNamedAndRemoveUntil(context,Routes.switchBetweenCssdAndDepartment,(Route<dynamic> route) => false);
        /* Navigator.pushNamedAndRemoveUntil(context,Routes.bottomNavBarDashboardCssdUser,(Route<dynamic> route) => false); */
      } else if (privilegesList.contains("312")) {
        LocalStorageManager.setBool(
            StorageKeys.privilegeFlagCssdAndDept, false);
        Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.bottomNavBarDashboardCssdUser,
            (Route<dynamic> route) => false);
      } else if (privilegesList.contains("316")) {
        LocalStorageManager.setBool(
            StorageKeys.privilegeFlagCssdAndDept, false);
        Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.dashboardViewCssdCussDeptUser,
            (Route<dynamic> route) => false);
      }
    } else if (currentToken == null) {
      Timer(
          const Duration(seconds: 1),
          () => Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.loginScreen,
                (route) => false,
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: GradientColors.splashGradient),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/sanitize_transparent.png",
                      width: 70,
                    ),
                    const Text(
                      "CSSD",
                      style: TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        // shadows: <Shadow>[
                        //   Shadow(
                        //     offset: Offset(5.0, 7.0),
                        //     blurRadius: 3.0,
                        //     color: Colors.black26,
                        //   )]
                      ),
                    ),
                    const Text(
                      "Centralized Sterilization and Supply Department",
                      style: TextStyle(fontSize: 16, color: Colors.white54),
                    ),
                  ],
                ),
              ),
              Lottie.asset("assets/lottie/loading_lottie.json",
                  width: 80, frameRate: const FrameRate(90)),
            ],
          ),
        ),
      ),
    );
  }
}
