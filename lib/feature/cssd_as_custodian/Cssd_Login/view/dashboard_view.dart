import 'package:cssd/util/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class DashboardView_cssdlogin_cssdcustodian extends StatelessWidget {
  const DashboardView_cssdlogin_cssdcustodian({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        title: const Text(
          "Cssd PersonName",
          textAlign: TextAlign.left,
          style: TextStyle(color: StaticColors.textwhiteLight),
        ),
        backgroundColor: StaticColors.scaffoldBackgroundcolor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  Icons.notifications,
                  size: 40,
                  color: Colors.white,
                ),
                Positioned(
                    left: 30,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 1.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: StaticColors.notificationAlertsNumber,
                      ),
                      child: Text(
                        "3",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ) //number of notifications -- change it later
                    )
              ],
            ),
          )
        ],
      ),
    );
  }
}
