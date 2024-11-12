import 'dart:async';

import 'package:cssd/Widgets/promo_card.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:cssd/util/hex_to_color_with_opacity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pushable_button/pushable_button.dart';

class SwitchBetweenCssdAndDepartment extends StatelessWidget {
  const SwitchBetweenCssdAndDepartment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PushableButton(
              elevation: 8,
              hslColor: HSLColor.fromColor(
                  hexToColorWithOpacity(hexColor: "#38D582")),
              height: 140,
              onPressed: () {
                Timer(const Duration(milliseconds: 200), () {
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.bottomNavBarDashboardCssdUser,
                      (Route route) => false);
                });
              },
              child: const Text(
                "CSSD User",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            PushableButton(
              elevation: 8,
              hslColor: HSLColor.fromColor(
                  hexToColorWithOpacity(hexColor: "#38D582")),
              height: 140,
              onPressed: () {
                Timer(const Duration(milliseconds: 200), () {
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.dashboardViewCssdCussDeptUser,
                      (Route route) => false);
                });
              },
              child: const Text(
                "Department User",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            )
            // PromoCard(
            //   cssdNetworkImage: true,
            //   deptNetworkImage: false,
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // PromoCard(
            //   cssdNetworkImage: false,
            //   deptNetworkImage: true,
            // )
          ],
        ),
      ),
    );
  }
}
