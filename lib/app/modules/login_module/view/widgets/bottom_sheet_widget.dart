import 'dart:developer';

import 'package:cssd/app/modules/login_module/view/widgets/clickable_button_widget.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:cssd/util/hex_to_color_with_opacity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> showOptionsBottomSheet(
      BuildContext context, Size mediaQuery) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          width: mediaQuery.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Choose Your Profile",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AnimatedHoverButton(
                      ontap: () {
                        log("button clicked");
                        /*  Navigator.pushNamedAndRemoveUntil(context,Routes.bottomNavBarDashboardCssdUser,(Route route) => false); */
                        Navigator.pushNamed(
                          context,
                          Routes.bottomNavBarDashboardCssdUser,
                        );
                      },
                      backgroundColor:
                          hexToColorWithOpacity(hexColor: "356745"),
                      hoverColor: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                      buttonContent: Container(
                        color: Colors.transparent,
                        child: const Center(
                          child: Text(
                            "CSSD User",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      containerHeight: 60,
                      containerWidth: 130,
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    AnimatedHoverButton(
                      ontap: () {
                        log("button clicked");

                        Navigator.pushNamed(
                          context,
                          Routes.dashboardViewCssdCussDeptUser,
                        );
                      },
                      backgroundColor:
                          hexToColorWithOpacity(hexColor: "356745"),
                      hoverColor: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                      buttonContent: Container(
                        color: Colors.transparent,
                        child: const Center(
                          child: Text(
                            "Department User",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      containerHeight: 60,
                      containerWidth: 140,
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }