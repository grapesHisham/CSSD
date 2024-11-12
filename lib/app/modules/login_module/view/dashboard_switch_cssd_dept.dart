import 'dart:async';

import 'package:cssd/Widgets/promo_card.dart';
import 'package:cssd/app/modules/login_module/view/widgets/clickable_button_widget.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:cssd/util/hex_to_color_with_opacity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pushable_button/pushable_button.dart';

class SwitchBetweenCssdAndDepartment extends StatelessWidget {
  const SwitchBetweenCssdAndDepartment({super.key});

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: 20.0, right: 20, top: 50, bottom: 160),
              child: Text(
                "Choose Your Department",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            Column(
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
                AnimatedHoverButton(
                  backgroundColor: hexToColorWithOpacity(hexColor: "356745"),
                  hoverColor: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                  buttonContent: Container(
                    color: Colors.amber,
                  ),
                  containerHeight: 140,
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
          ],
        ),
      ),
    );
  }
}
