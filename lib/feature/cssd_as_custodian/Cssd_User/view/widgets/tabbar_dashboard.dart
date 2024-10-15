import 'package:cssd/Widgets/clickable_card.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/model/sampleRequestList.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/provider/dashboard_controller.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/view/widgets/tabbar_head_dahboard.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class tabBarDashboard extends StatelessWidget {
  const tabBarDashboard({
    super.key,
    required this.dashboardProvider,
  });

  final DashboardController dashboardProvider;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            height: 40.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.h)),
                color: Colors.blue.shade100),
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
                unselectedLabelColor: Colors.grey,
                indicatorColor: StaticColors.scaffoldBackgroundcolor,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                tabs: [
                  DashboardTabBar(
                    titleText: 'High priority',
                    countText: '32',
                    tabIndex: 0,
                  ),
                  DashboardTabBar(
                    titleText: 'Medium priority',
                    countText: sampleRequestsList.length.toString(),
                    tabIndex: 1,
                  ),
                  DashboardTabBar(
                    titleText: 'Low priority',
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
      itemCount: sampleRequestsList.length,
      itemBuilder: (context, index) {
        final request = sampleRequestsList[index];
        // final request = dashboardProvider.mediumPriorityRequests[index];
        return ClickableCard(
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

  SingleChildScrollView _highPriorityTabView() {
    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(height: 10.h),
        const ClickableCard(
          reqiestTime: '12:30 am',
          requestID: '23',
          requestDate: '12/10/2024',
          requestDepartment: 'Operation Theater',
          requestSubTitle:
              "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
          requestTitle: 'OT PACKAGE',
        ),
        const ClickableCard(
          reqiestTime: '12:30 am',
          requestID: '56',
          requestDate: '11/10/2024',
          requestDepartment: 'Cardiology',
          requestSubTitle:
              "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
          requestTitle: 'Single items',
        ),
        const ClickableCard(
          reqiestTime: '12:30 am',
          requestID: '23',
          requestDate: '12/10/2024',
          requestDepartment: 'Operation Theater',
          requestSubTitle:
              "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
          requestTitle: 'OT Package & Other items',
        ),
        const ClickableCard(
          reqiestTime: '12:30 am',
          requestID: '23',
          requestDate: '12/10/2024',
          requestDepartment: 'Operation Theater',
          requestSubTitle:
              "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
          requestTitle: 'Single items',
        ),
      ]),
    );
  }
}
