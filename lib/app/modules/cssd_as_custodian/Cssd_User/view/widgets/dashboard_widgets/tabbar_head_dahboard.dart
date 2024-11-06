import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/controller/dashboard_controller.dart';
import 'package:cssd/util/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:text_marquee/text_marquee.dart';

class DashboardTabBarHead extends StatelessWidget {
  final String titleText;
  final String countText;
  final int tabIndex;

  const DashboardTabBarHead({
    super.key,
    required this.titleText,
    required this.countText,
    required this.tabIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardController>(
        builder: (context, dashboardController, child) {
      bool isSelected =
          dashboardController.selectedTabbarIndex == tabIndex ? true : false;
      // log("is selected value: $isSelected  , controller value: ${dashboardController.selectedIndex}, tabindex $tabIndex");
      return Tab(
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: TextMarquee(
                      titleText,
                      spaceSize: 15,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      
                      width: 29.w,
                      height: 29.h,
                      padding: EdgeInsets.all(2.0.w),
                      margin: EdgeInsets.only(left: 2.0.w),
                      decoration: BoxDecoration(
                          color:
                              isSelected ? Colors.white : Colors.grey.shade100,
                          shape: BoxShape.circle),
                      child: Center(
                        child: Text(countText,
                            style: FontStyles.todaysSterilizationCount),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
