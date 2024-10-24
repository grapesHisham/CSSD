import 'package:cssd/Widgets/clickable_card.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/model/sampleRequestList.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/provider/dashboard_controller.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/view/widgets/dashboard_widgets/tabbar_head_dahboard.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
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
    return DefaultTabController(
      length: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Material(
            elevation: 2.0,
            borderRadius: BorderRadius.all(Radius.circular(10.h)),
            child: Container(
              height: 40.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.h)),
                  color: Colors.white),
              child: Builder(builder: (context) {
                return TabBar(
                  onTap: (value) {
                    dashboardProvider.updateSelectedIndex(value);
                    /* while scrolling we need to update the tabindex */
                    // if (tabController
                    //     .indexIsChanging) {
                    //   log("tabcontroller index is changing ${tabController.indexIsChanging}");
                    //   Provider.of<DashboardController>(
                    //           context,
                    //           listen: false)
                    //       .updateSelectedIndex(
                    //           value);
                    // }
                  },
                  indicator: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      )),
                  labelColor: Colors.white,
                  labelStyle: FontStyles.todaysSterilizationText,
                  unselectedLabelColor: StaticColors.scaffoldBackgroundcolor,
                  indicatorColor: StaticColors.scaffoldBackgroundcolor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  tabs: [
                    DashboardTabBarHead(
                      titleText: 'High priority',
                      countText:
                          sampleHighPriorityRequestsList.length.toString(),
                      tabIndex: 0,
                    ),
                    DashboardTabBarHead(
                      titleText: 'Medium priority',
                      countText:
                          sampleMediumPriorityRequestsList.length.toString(),
                      tabIndex: 1,
                    ),
                    DashboardTabBarHead(
                      titleText: 'Low priority',
                      countText:
                          sampleLowPriorityRequestsList.length.toString(),
                      tabIndex: 2,
                    ),
                  ],
                );
              }),
            ),
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
}
