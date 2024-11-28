import 'dart:developer';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/clickable_card.dart';
import 'package:cssd/Widgets/notification_icon.dart';
import 'package:cssd/Widgets/rounded_container.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/model/sampleRequestList.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/controller/dashboard_controller_dept.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/view/widgets/dashboard_widgets/department_selection_dashboard_widget.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/view/widgets/dashboard_widgets/exit_dialogbox_widget.dart';
import 'package:cssd/app/modules/login_module/view/widgets/logout_popup.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:cssd/util/app_util.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:cssd/util/hex_to_color_with_opacity.dart';
import 'package:cssd/util/local_storage_manager.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
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
    log("dashbord init");
    final dashboardController =
        Provider.of<DashboardControllerCssdCussDeptUser>(context,
            listen: false);
    //fetch currently selected department
    selectedDepartment = dashboardController.getSelectedDepartment;
    dashboardController.departmentDropdownFunction();
    if (selectedDepartment != "") {
      log("Selected department is : $selectedDepartment");
      //if department is selection is available then get pie data and its details
      dashboardController.pieChartData.clear();
      dashboardController.getPieChartData(selectedDepartment!);
      dashboardController.fetchRequestDetails(selectedDepartment!);
      dashboardController.fetchMyRequests(selectedDepartment!);
    } else {
      dashboardController.pieChartData.clear();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showSnackBar(context: context, isError: true, msg: "Select department");
      });
    }
    // if user has both cssd and dept privileges
    hasPrivileges =
        LocalStorageManager.getBool(StorageKeys.privilegeFlagCssdAndDept)!;
    userName = LocalStorageManager.getString(StorageKeys.loggedinUser) ??
        "Department user";
    LocalStorageManager.setString(StorageKeys.lastOpenedIsCssd, "dept");
    if (selectedDepartment == "") {
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
    log("dashboard page build");
    final dashboardController =
        Provider.of<DashboardControllerCssdCussDeptUser>(context,
            listen: false);
    final mediaQuery = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        // logoutPopup(context);
        // Navigator.pop(context);
        exitDialogBox(context);
      },
      child: Scaffold(
        floatingActionButton: _buildFloatingActionButton(hasPrivileges),
        backgroundColor: StaticColors.scaffoldBackgroundcolor,
        appBar: AppBar(
          toolbarHeight: 143,
          centerTitle: false,
          title: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Hey, $userName", style: FontStyles.appBarTitleStyle),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            logoutPopup(context);
                          },
                          icon: const Icon(FluentIcons.power_20_filled)),
                      InkWell(onTap: () {}, child: const NotificationIcon()),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              //department dropdown
              SizedBox(
                width: mediaQuery.width,
                height: 50,
                child: DepartmentSelectionDashboardWidget(
                    dashboardController: dashboardController),
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
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //pie chart
                        Consumer<DashboardControllerCssdCussDeptUser>(
                            builder: (context, dashboardConsumer, child) {
                          final isDataAvailable =
                              dashboardConsumer.hasValidData;
                          return Visibility(
                            visible: isDataAvailable ? true : false,
                            replacement: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text("Send Requests to load Stats"),
                                SizedBox(
                                  width: 10.w,
                                ),
                                SizedBox(
                                  width: 140,
                                  child: Lottie.asset(
                                      'assets/lottie/PieAnimation - 1731912508343.json'),
                                ),
                              ],
                            ),
                            //syncfusion pie chart
                            child: SizedBox(
                              height: 180,
                              child: SfCircularChart(
                                onChartTouchInteractionDown:
                                    (ChartTouchInteractionArgs args) {
                                  log("${args.position.dy} : ${args.position.dy}");
                                  Navigator.pushNamed(
                                      context,
                                      Routes
                                          .requestDetailsViewCssdCussDeptUser);
                                },
                                palette: [
                                  //colors of the pie chart in order
                                  hexToColorWithOpacity(hexColor: "#ff6361"),
                                  hexToColorWithOpacity(hexColor: "#58508d"),
                                  hexToColorWithOpacity(hexColor: "#bc5090"),
                                  hexToColorWithOpacity(hexColor: "#003f5c"),
                                  hexToColorWithOpacity(hexColor: "#ffa600"),
                                ],
                                title: const ChartTitle(
                                    alignment: ChartAlignment.near,
                                    text: 'Request Details',
                                    textStyle: TextStyle(color: Colors.black)),
                                legend: const Legend(
                                    //its the indications of the chart
                                    isVisible: true,
                                    textStyle: TextStyle(color: Colors.black),
                                    position: LegendPosition.left),
                                onTooltipRender: (TooltipArgs args) {},
                                series: <PieSeries<Map<String, dynamic>,
                                    String>>[
                                  PieSeries<Map<String, dynamic>, String>(
                                    dataSource: dashboardConsumer.pieChartData,
                                    explode: true,
                                    explodeIndex: 0,
                                    xValueMapper:
                                        (Map<String, dynamic> data, _) =>
                                            data.keys.first,
                                    yValueMapper:
                                        (Map<String, dynamic> data, _) =>
                                            data.values.first,
                                    dataLabelSettings: const DataLabelSettings(
                                      isVisible: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    )
                  ],
                ),
              ),

              //navigation buttons
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DashboardButtons(
                    icon: FluentIcons.tray_item_add_20_filled,
                    iconName: "Used Item Entry",
                    onTap: () {
                      Navigator.pushNamed(
                          context, Routes.usedItemEntryViewCssdCussDeptUser);
                    },
                  ),
                  DashboardButtons(
                    icon: FluentIcons.send_16_filled,
                    iconName: "Send To Cssd",
                    onTap: () {
                      Navigator.pushNamed(context,
                          Routes.sterilizationRequestViewCssdCussDeptUser);
                    },
                  ),
                  const DashboardButtons(
                    icon: FluentIcons.news_16_filled,
                    iconName: "Reports",
                  ),
                  // DashboardButtons(
                  //   icon: FluentIcons.timeline_20_filled,
                  //   iconName: "Timeline",
                  // ),
                  DashboardButtons(
                    icon: FluentIcons.stack_16_filled,
                    iconName: "Stock in Dept",
                    onTap: () {
                      Navigator.pushNamed(
                          context, Routes.departmentStockDetailsView);
                    },
                  )
                ],
              ),

              //request listing
              Expanded(
                child: RoundedContainer(
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
                            childWidget: Icon(
                              Icons.refresh,
                              color: Colors.white,
                            ),
                            buttonTextSize: 14,
                            buttonSize: const Size(49, 30),
                            onPressed: () {},
                          )
                        ],
                      ),
                      Expanded(
                        child: Consumer<DashboardControllerCssdCussDeptUser>(
                            builder: (context, dashboardConsumer, child) {
                          return ListView.builder(
                            itemCount:
                                dashboardConsumer.getMyRequestList.length,
                            itemBuilder: (context, index) {
                              final request =
                                  dashboardConsumer.getMyRequestList[index];
                              String apiRequestTime =
                                  request.reqTime.toString();
                              DateTime parsedDateTime =
                                  DateTime.parse(apiRequestTime);
                              String formatedDate = DateFormat('yyyy-MM-dd')
                                  .format(parsedDateTime);
                              String formatedTime =
                                  DateFormat('hh:mm a').format(parsedDateTime);
                              log("time :${request.reqTime} ");
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Card(
                                  elevation: 2,
                                  color: hexToColorWithOpacity(
                                    hexColor: "#FFFCE8",
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // id
                                        Flexible(
                                            flex: 1,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2.0),
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: hexToColorWithOpacity(
                                                    hexColor: "DD403A"),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: FittedBox(
                                                  child: Text(
                                                    "Req ID:  ${request.reqId} ",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            )),
                                        SizedBox(
                                          width: 8.0.w,
                                        ),
                                        //requested by and time
                                        Flexible(
                                            flex: 3,
                                            child: Wrap(
                                              direction: Axis.vertical,
                                              children: [
                                                Text(
                                                    "Requested by : ${request.requser}"),
                                                Text("Date : $formatedDate"),
                                                Text("Time : $formatedTime"),
                                              ],
                                            )),
                                        SizedBox(
                                          width: 2.0.w,
                                        ),
                                        // accecpted ? by who
                                        Flexible(
                                            flex: 2,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text("Status : "),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                       /*  border: Border.all(
                                                            color: Colors.grey.shade100), */
                                                      ),
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            request.isAccepted ==
                                                                    true
                                                                ? Colors.green
                                                                : Colors.red,
                                                        maxRadius: 4.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                /*   request.isAccepted ==
                                                                  true ? const Text(
                                                  "Accepted ",
                                                  style: TextStyle(
                                                      color:
                                                         Colors.green
                                                              ),
                                                ) : const Text(
                                                  "Not Accepted",
                                                  style: TextStyle(
                                                      color:
                                                         Colors.redAccent
                                                              ),
                                                ) , */
                                                request.isAccepted == true
                                                    ? Text(
                                                        "Accepted By: ${request.acceptedUser}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      )
                                                    : const SizedBox.shrink(),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              );

                              /* return ClickableCard( 
                                    requestID: list.reqId.toString(),
                                    requestTitle: list.requser,
                                    requestDate: list.reqTime.toUtc().toString(),
                                    reqiestTime: list.reqTime.toUtc().toIso8601String(),
                                    requestDepartment: list.acceptedUser ?? "",
                                    requestSubTitle: list.isAccepted.toString()); */
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
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
                selectedDepartment = LocalStorageManager.getString(
                    StorageKeys.selectedDepartmentCounter);
                if (selectedDepartment == null) {
                  showSnackBar(
                      context: context,
                      isError: true,
                      msg: "Select Department");
                } else {
                  Navigator.pop(context);
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

class DashboardButtons extends StatelessWidget {
  const DashboardButtons({
    super.key,
    required this.icon,
    required this.iconName,
    this.onTap,
  });

  final IconData icon;
  final String iconName;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          //single item
          children: [
            SizedBox(
              width: 60,
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: StaticColors.scaffoldBackgroundcolor),
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
                width: 60,
                child: Text(
                  iconName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
