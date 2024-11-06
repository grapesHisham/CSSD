import 'package:cssd/Widgets/clickable_card.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/model/sampleBatchNoQuantity.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/model/sampleRequestList.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/controller/dashboard_controller.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/view/request_details_view.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/view/widgets/dashboard_widgets/tabbar_head_dahboard.dart';
import 'package:cssd/util/fonts.dart';
import 'package:cssd/util/hex_to_color_with_opacity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabBarDashboard extends StatelessWidget {
  const TabBarDashboard({
    super.key,
    required this.dashboardProvider,
  });

  final DashboardController dashboardProvider;

  @override
  Widget build(BuildContext context) {
     final mediaQuery = MediaQuery.of(context).size;
    final isMobile = mediaQuery.width <= 500;
    return DefaultTabController(
      length: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 40.h,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(255, 197, 197, 197),
                      blurRadius: 2.0,

                      offset: Offset(1, 4),
                      spreadRadius: -0.5),
                ],
                borderRadius: BorderRadius.all(Radius.circular(10.h)),
                color: hexToColorWithOpacity(hexColor: "FDF7FF"),
                // gradient: LinearGradient(
                //     begin: Alignment.centerLeft,
                //     end: Alignment.centerRight,
                //     colors: [
                //       // hexToColorWithOpacity(hexColor: "DADADF"),
                //       hexToColorWithOpacity(hexColor: "F2F2F7"),
                //       hexToColorWithOpacity(hexColor: "F2F2F7"),
                //     ]),
                ),
            child: Builder(builder: (context) {
              return TabBar(
                onTap: (value) {
                  dashboardProvider.updateSelectedIndex(value);
                },
                indicator: BoxDecoration(
                    color: hexToColorWithOpacity(hexColor: "5D55B3"),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    )),
                labelColor: Colors.white,
                labelStyle: FontStyles.todaysSterilizationText,
                unselectedLabelColor: Colors.black87,
                // indicatorColor: StaticColors.scaffoldBackgroundcolor,
                indicatorColor: hexToColorWithOpacity(hexColor: "5D55B3"),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,

                tabs: [
                  DashboardTabBarHead(
                    titleText: isMobile ? 'High ' : 'High Priority',
                    countText: sampleHighPriorityRequestsList.length.toString(),
                    tabIndex: 0,
                  ),
                  DashboardTabBarHead(
                    titleText: isMobile ? 'Medium ' : 'Medium Priority',
                    countText:
                        sampleMediumPriorityRequestsList.length.toString(),
                    tabIndex: 1,
                  ),
                  DashboardTabBarHead(
                   titleText: isMobile ? 'Low ' : 'Low Priority',
                    countText: sampleLowPriorityRequestsList.length.toString(),
                    tabIndex: 2,
                  ),
                ],
              );
            }),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _highPriorityTabView(),
                _mediumPriorityTabView(),
                _lowPriorityTabView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _lowPriorityTabView() {
    return ListView.builder(
      // itemCount: dashboardProvider.mediumPriorityRequests.length,
      itemCount: sampleLowPriorityRequestsList.length,
      itemBuilder: (context, index) {
        final request = sampleLowPriorityRequestsList[index];
        // final request = dashboardProvider.mediumPriorityRequests[index];
        return ClickableCard(
          cardColor: Colors.white,
          reqiestTime: request.requestTime,
          requestID: request.requestID,
          requestDate: request.requestDate,
          requestDepartment: request.requestDepartment,
          requestSubTitle: request.requestSubTitle,
          requestTitle: request.requestTitle,
        );
      },
    );
  }

  Widget _mediumPriorityTabView() {
    return ListView.builder(
      // itemCount: dashboardProvider.mediumPriorityRequests.length,
      itemCount: sampleMediumPriorityRequestsList.length,
      itemBuilder: (context, index) {
        final request = sampleMediumPriorityRequestsList[index];
        // final request = dashboardProvider.mediumPriorityRequests[index];
        return ClickableCard(
          cardColor: Colors.white,
          reqiestTime: request.requestTime,
          requestID: request.requestID,
          requestDate: request.requestDate,
          requestDepartment: request.requestDepartment,
          requestSubTitle: request.requestSubTitle,
          requestTitle: request.requestTitle,
        );
      },
    );
  }

  Widget _highPriorityTabView() {
    return ListView.builder(
      // itemCount: dashboardProvider.mediumPriorityRequests.length,
      itemCount: sampleHighPriorityRequestsList.length,
      itemBuilder: (context, index) {
        final request = sampleHighPriorityRequestsList[index];
        final requestID = SampleGeneratedList().sampleRequestNumber[index];
        // final request = dashboardProvider.mediumPriorityRequests[index];
        return ClickableCard(
          cardClickFunction: () {
            // Navigator.pushNamed(context, Routes.requestDetailsViewCssdCussCssLogin);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RequestDetailsViewCssdCussCssLogin(),
                ));
          },
          cardColor: Colors.white,
          reqiestTime: request.requestTime,
          requestID: requestID.toString(),
          requestDate: request.requestDate,
          requestDepartment: request.requestDepartment,
          requestSubTitle: request.requestSubTitle,
          requestTitle: request.requestTitle,
        );
      },
    );
  }
}
