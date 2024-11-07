import 'dart:developer';

import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/clickable_card.dart';
import 'package:cssd/Widgets/notification_icon.dart';
import 'package:cssd/Widgets/rounded_container.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/model/sampleRequestList.dart';
import 'package:cssd/app/modules/login_module/view/widgets/logout_popup.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:cssd/util/local_storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardViewCssdCussDeptUser extends StatefulWidget {
  const DashboardViewCssdCussDeptUser({super.key});

  @override
  State<DashboardViewCssdCussDeptUser> createState() =>
      _DashboardViewCssdCussDeptUserState();
}

class _DashboardViewCssdCussDeptUserState
    extends State<DashboardViewCssdCussDeptUser> {
  late bool hasPrivileges;
  late String userName;
  @override
  void initState() {
    hasPrivileges =
        LocalStorageManager.getBool(StorageKeys.privilegeFlagCssdAndDept)!;
    userName = LocalStorageManager.getString(StorageKeys.loggedinUser)?? "Department user";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        logoutPopup(context);
      },
      child: Scaffold(
        floatingActionButton: _buildFloatingActionButton(hasPrivileges),
        backgroundColor: StaticColors.scaffoldBackgroundcolor,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: InkWell(onTap: () {}, child: const NotificationIcon()),
            )
          ],
          centerTitle: false,
          title: Text(userName, style: FontStyles.appBarTitleStyle),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10.0.h, vertical: 10.0.h),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: Colors.white),
          child: Column(
            children: [
              RoundedContainer(
                  containerBody: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "My Requests",
                        style: TextStyle(fontSize: 32.0),
                      ),
                      ButtonWidget(
                        buttonLabel: "All",
                        buttonTextSize: 14,
                        buttonSize: const Size(49, 30),
                        onPressed: () {},
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                      height: mediaQuery.height / 2.5,
                      child: ListView.builder(
                        itemCount: sampleHighPriorityRequestsList.length,
                        itemBuilder: (context, index) {
                          final list = sampleHighPriorityRequestsList[index];
                          return ClickableCard(
                              requestID: list.requestID,
                              requestTitle: list.requestTitle,
                              requestDate: list.requestDate,
                              reqiestTime: list.requestTime,
                              requestDepartment: list.requestDepartment,
                              requestSubTitle: list.requestSubTitle);
                        },
                      ),
                    ),
                  ),
                ],
              )),
              SizedBox(height: 20.0),
              Wrap(
                runAlignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                runSpacing: 10.0,
                spacing: 10.0,
                direction: Axis.horizontal,
                children: [
                  ButtonWidget(
                    buttonLabel: "Used Item Entry",
                    buttonTextSize: 14,
                    onPressed: () {},
                  ),
                  ButtonWidget(
                    buttonTextSize: 14,
                    buttonLabel: "Reports",
                    onPressed: () {},
                  ),
                  ButtonWidget(
                    buttonTextSize: 14,
                    buttonLabel: "Timeline",
                    onPressed: () {},
                  ),
                  ButtonWidget(
                    buttonTextSize: 14,
                    buttonLabel: "Sterilization request",
                    onPressed: () {
                      Navigator.pushNamed(context,
                          Routes.sterilizationRequestViewCssdCussDeptUser);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(bool hasPrivileges) {
    log("Privilege Status: $hasPrivileges");

    // Check if the user does not have the required privilege
    if (!hasPrivileges) {
      return const SizedBox.shrink(); // Return an empty widget if no privileges
    }

    // Return the floating action button if the privilege flag is true
    return FloatingActionButton.extended(
      backgroundColor: StaticColors.scaffoldBackgroundcolor,
      label: const Text(
        "Switch to Cssd",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.pushNamed(context, Routes.dashboardViewCssdCssCssdLogin);
      },
    );
  }
}
