import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/doctorProfileImage.dart';
import 'package:cssd/Widgets/endDrawer.dart';
import 'package:cssd/Widgets/notification_icon.dart';
import 'package:cssd/Widgets/pie_indicator.dart';
import 'package:cssd/Widgets/rounded_container.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/provider/dashboard_controller.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/view/widgets/dashboard_widgets/tabbar_dashboard.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class DashboardView_cssdUser_cssdcustodian extends StatelessWidget {
  const DashboardView_cssdUser_cssdcustodian({super.key});

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.of(context).size;
    final dashboardProvider =
        Provider.of<DashboardController>(context, listen: false);

    return Scaffold(
      backgroundColor: StaticColors.scaffoldBackgroundcolor,
      endDrawer: endDrawer(),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                actions: [
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, Routes.alertView_cssdCus_cssdLogin);
                      },
                      child: const NotificationIcon()),
                  const SizedBox(width: 10),
                  Builder(
                    builder: (context) {
                      return IconButton(
                        icon: const Icon(Icons.menu, size: 30),
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                      );
                    },
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  height: mediaQuery.height,
                  width: mediaQuery.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    color: Colors.white,
                  ),
                  child: SizedBox(
                    height: mediaQuery.height,
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      "Request Chart",
                                      style: FontStyles.bodyPieTitleStyle,
                                    )),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: PieChart(
                                      PieChartData(sections: [
                                        PieChartSectionData(
                                          titleStyle: FontStyles
                                              .piePercentageValueTextStyle,
                                          value: 33,
                                          color: StaticColors.pieRequestCount,
                                          radius: 30,
                                        ),
                                        PieChartSectionData(
                                          titleStyle: FontStyles
                                              .piePercentageValueTextStyle,
                                          value: 55,
                                          color: StaticColors
                                              .pieSterilizationOnProgress,
                                          radius: 30,
                                        ),
                                        PieChartSectionData(
                                          titleStyle: FontStyles
                                              .piePercentageValueTextStyle,
                                          value: 12,
                                          color: StaticColors
                                              .pieSterilizationComplete,
                                          radius: 30,
                                        ),
                                      ]),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  pieIndications(),
                                ],
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: mediaQuery.height *0.45,
                                child: RoundedContainer(
                                  containerBody: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                              "Today's Sterilization Requests "),
                                          ButtonWidget(
                                              borderRadius: 8,
                                              buttonTextSize: 14,
                                              buttonLabel: "ALL",
                                              onPressed: () {}),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Expanded(
                                        child: TabBarDashboard(
                                            dashboardProvider: dashboardProvider),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                    
                              // Other content here
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Hovering Doctor's Profile Image
          const Positioned(
            top: -20,
            left: 0,
            child: doctorProfile(),
          ),
          // Doctor's Name below the profile image
          Positioned(
            top: 25.h,
            left: 120,
            child: Text("Hey, Dev", style: FontStyles.appBarTitleStyle),
          ),
        ],
      ),
      // bottomNavigationBar: const BottomNavigationBarDashboard(),
    );
  }

  Column pieIndications() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Indicator(
          color: StaticColors.pieRequestCount,
          text: 'Request count',
          isSquare: false,
        ),
        SizedBox(height: 6),
        Indicator(
          color: StaticColors.pieSterilizationOnProgress,
          text: 'Sterilization on progress',
          isSquare: false,
        ),
        SizedBox(height: 6),
        Indicator(
          color: StaticColors.pieSterilizationComplete,
          text: 'Sterilization complete',
          isSquare: false,
        ),
        SizedBox(height: 4),
      ],
    );
  }
}
