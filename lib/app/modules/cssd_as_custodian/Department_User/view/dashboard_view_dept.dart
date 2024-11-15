import 'dart:developer';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/clickable_card.dart';
import 'package:cssd/Widgets/notification_icon.dart';
import 'package:cssd/Widgets/rounded_container.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/model/sampleRequestList.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/controller/dashboard_controller_dept.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/dahboard_models/samplePieChart_model.dart';
import 'package:cssd/app/modules/login_module/view/widgets/logout_popup.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:cssd/util/app_util.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:cssd/util/hex_to_color_with_opacity.dart';
import 'package:cssd/util/local_storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
  late String? selectedDepartment;
  @override
  void initState() {
    selectedDepartment =
        LocalStorageManager.getString(StorageKeys.selectedDepartmentCounter);
    final dashboardController = Provider.of<DashboardControllerCssdCussDeptUser>(context,listen: false);
    dashboardController.getPieChartData(selectedDepartment!);
    dashboardController.departmentDropdownFunction();
    // controller.selectedDepartment = null;
    hasPrivileges =
        LocalStorageManager.getBool(StorageKeys.privilegeFlagCssdAndDept)!;
    userName = LocalStorageManager.getString(StorageKeys.loggedinUser) ??
        "Department user";
    LocalStorageManager.setString(StorageKeys.lastOpenedIsCssd, "dept");
    if (selectedDepartment == null) {
      log("already selected department is : $selectedDepartment so showing popup");
      // if department is not already selected the show the popup
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAlertDialog();
      });
    }

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
          toolbarHeight: 140,
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Hey, $userName", style: FontStyles.appBarTitleStyle),
                  InkWell(onTap: () {}, child: const NotificationIcon())
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              //department dropdown
              SizedBox(
                width: mediaQuery.width,
                height: 50,
                child: Consumer<DashboardControllerCssdCussDeptUser>(
                    builder: (context, dashboardConsumer, child) {
                  return CustomDropdown.search(
                    decoration: CustomDropdownDecoration(
                        closedBorder: Border.all(color: Colors.grey.shade100)),
                    initialItem: LocalStorageManager.getString(
                        StorageKeys.selectedDepartmentCounter),
                    hintText: "Department name",
                    items: dashboardConsumer.departmentDropdownItems
                        .map((item) => item.subName.toString())
                        .toList(),
                    onChanged: (selectedDepartment) {
                      if (selectedDepartment != null) {
                        dashboardConsumer.getPieChartData(selectedDepartment);
                        dashboardConsumer.selectedDepartment =
                            selectedDepartment;
                        LocalStorageManager.setString(
                            StorageKeys.selectedDepartmentCounter,
                            selectedDepartment);
                        log("stored to selectedDepartmentCounter : ${LocalStorageManager.getString(StorageKeys.selectedDepartmentCounter)}");
                      } else {
                        showToast(context, "Select department");
                      }
                    },
                  );
                }),
              )
            ],
          ),
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Consumer<DashboardControllerCssdCussDeptUser>(
                            builder: (context, dashboardConsumer,child) {
                              
                              return SfCircularChart(
                                palette: [
                                  hexToColorWithOpacity(hexColor: "#ff6361"),
                                  hexToColorWithOpacity(hexColor: "#58508d"),
                                  hexToColorWithOpacity(hexColor: "#bc5090"),
                                  hexToColorWithOpacity(hexColor: "#003f5c"),
                                  hexToColorWithOpacity(hexColor: "#ffa600"),
                                ],
                                title: const ChartTitle(
                                    text: 'Request Details',
                                    textStyle: TextStyle(color: Colors.black)),
                                legend: const Legend(
                                    isVisible: true,
                                    textStyle: TextStyle(color: Colors.black),
                                    position: LegendPosition.left),
                                series: <PieSeries<Map<String, dynamic>, String>>[
                                  PieSeries<Map<String, dynamic>, String>(
                                    dataSource: dashboardConsumer.pieChartData,
                                    explode: true,
                                    explodeIndex: 0,
                                    xValueMapper: (Map<String, dynamic> data, _) =>
                                        data.keys.first,
                                    yValueMapper: (Map<String, dynamic> data, _) =>
                                        data.values.first,
                                    dataLabelSettings: const DataLabelSettings(
                                      isVisible: true,
                                    ),
                                  ),
                                ],
                              );
                            }
                          ),
                        ],
                      )
                    ],
                  ),
                ),
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
                const SizedBox(height: 20.0),
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
        Navigator.pushNamedAndRemoveUntil(context,
            Routes.bottomNavBarDashboardCssdUser, (Route route) => false);
      },
    );
  }

  Future showAlertDialog() async {
    final dashboardController =
        context.read<DashboardControllerCssdCussDeptUser>();
    dashboardController.departmentDropdownFunction();
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          actions: [
            ButtonWidget(
              buttonColor: const Color.fromARGB(255, 48, 160, 85),
              buttonLabel: "ok",
              onPressed: () {
                final String? selectedDepartment =
                    dashboardController.getSelectedDepartment;
                if (selectedDepartment != null) {
                  LocalStorageManager.setString(
                      StorageKeys.selectedDepartmentCounter,
                      selectedDepartment);
                  log("Stored department to selectedDepartmentCounter: $selectedDepartment");
                  Navigator.pop(context);
                } else {
                  showToast(context, "Selected Department is null");
                }
              },
            ),
          ],
          title: const Text("Select department"),
          content: Consumer<DashboardControllerCssdCussDeptUser>(
              builder: (context, dashboardConsumer, child) {
            return CustomDropdown.search(
              decoration: CustomDropdownDecoration(
                  closedBorder: Border.all(color: Colors.grey.shade100)),
              hintText: "Department name",
              items: dashboardConsumer.departmentDropdownItems
                  .map((item) => item.subName.toString())
                  .toList(),
              onChanged: (selectedDepartment) {
                if (selectedDepartment != null) {
                  dashboardConsumer.selectedDepartment = selectedDepartment;
                  LocalStorageManager.setString(
                      StorageKeys.selectedDepartmentCounter,
                      selectedDepartment);
                } else {
                  showToast(context, "Select department");
                }
              },
            );
          }),
        );
      },
    );
  }
}
