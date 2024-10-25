import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/date_picker_widget.dart';
import 'package:cssd/Widgets/endDrawer.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/model/sampleDropDownMenuEntries.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/model/sampleRequestList.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/provider/timeline_controller.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/view/widgets/issue_widgets.dart/dropdown_menu_widget.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/view/widgets/timeline_widgets.dart/timeline_end_child_widget.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:cssd/util/hex_to_color_with_opacity.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimelineViewCssdCussCssdLogin extends StatelessWidget {
  const TimelineViewCssdCussCssdLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final timelineProviderObj =
        Provider.of<TimelineController>(context, listen: false);
    final mediaQuery = MediaQuery.of(context).size;
    var isMobile = mediaQuery.width <= 500;
    return Scaffold(
      backgroundColor: StaticColors.scaffoldBackgroundcolor,
      endDrawer: endDrawer(),
      appBar: AppBar(
        actions: [
          ButtonWidget(
            buttonColor: hexToColorWithOpacity(hexColor: "EF7000"),
            buttonLabel: "Today",
            onPressed: () {},
          ),
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer(); // Opens the end drawer
                },
              );
            },
          ),
        ],
        title: Row(
          children: [
            Text(
              "10",
              style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 9.0.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tue",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                Text("September, 2024",
                    style: TextStyle(fontSize: 14, color: Colors.white))
              ],
            )
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
          height: double.infinity,
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
              Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.end,
                spacing: 10,
                runSpacing: 20,
                children: [
                  SizedBox(
                    width: isMobile
                        ? mediaQuery.width * 0.40
                        : mediaQuery.width * 0.25,
                    child: DatePickerWidget(
                      label: "From",
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                      controller: timelineProviderObj.fromDateController,
                    ),
                  ),
                  SizedBox(
                    width: isMobile
                        ? mediaQuery.width * 0.40
                        : mediaQuery.width * 0.25,
                    child: DatePickerWidget(
                      label: "To",
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                      controller: timelineProviderObj.toDateController,
                    ),
                  ),
                  CustomDropDownMenuWidget(
                    dropDownWidth: isMobile
                        ? mediaQuery.width * 0.60
                        : mediaQuery.width * 0.25,
                    dropdownMenuEntries: sampleDepartmentDropDownEntries,
                    onSelected: (p0) {
                      print(mediaQuery.width);
                    },
                    label: "Selected Department",
                  ),
                  ButtonWidget(
                    buttonLabel: "Show",
                    onPressed: () {},
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                  child: ScrollbarTheme(
                data: const ScrollbarThemeData(
                    thumbColor: WidgetStatePropertyAll(Colors.blue),
                    radius: Radius.circular(20)),
                child: Scrollbar(
                  thickness: 10.0,
                  child: ListView.builder(
                    itemCount: sampleHighPriorityRequestsList.length,
                    itemBuilder: (context, index) {
                      final dept = sampleDepartmentDropDownEntries[index].label;
                      final request = sampleHighPriorityRequestsList[index];
                      //background container of the timeline
                      return Container(
                        color: Colors.white,
                        child: Container(
                          //container of the timeline
                          padding: EdgeInsets.all(10.0.w),
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0.w, vertical: 10.0.h),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  hexToColorWithOpacity(hexColor: "373E8F"),
                                  hexToColorWithOpacity(hexColor: "220066"),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    " REQUEST: $index",
                                    style: FontStyles.timelineHead,
                                  ),
                                  Text(
                                    " Department: $dept",
                                    style: FontStyles.timelineHead,
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 24.0.w, vertical: 20.0.h),
                                child: Column(
                                  children: [
                                    TimeLineTileWidget(
                                      endChildTitle: 'Requested',
                                      endChildSubTitle:
                                          '${request.requestDate}  ${request.requestTime}',
                                      isFirst: true,
                                      isDone: true,
                                      isLast: false,
                                    ),
                                    TimeLineTileWidget(
                                      endChildTitle: 'Accepted',
                                      endChildSubTitle:
                                          '${request.requestDate}  ${request.requestTime}',
                                      isDone: false,
                                      isLast: false,
                                      isFirst: false,
                                    ),
                                    TimeLineTileWidget(
                                      endChildTitle: 'Sterilizing',
                                      endChildSubTitle:
                                          '${request.requestDate}  ${request.requestTime}',
                                      isDone: false,
                                      isFirst: false,
                                      isLast: false,
                                    ),
                                    TimeLineTileWidget(
                                      endChildTitle: 'Sterilization complete',
                                      endChildSubTitle:
                                          '${request.requestDate}  ${request.requestTime}',
                                      isDone: false,
                                      isFirst: false,
                                      isLast: false,
                                    ),
                                    TimeLineTileWidget(
                                      endChildTitle: 'Pickup',
                                      endChildSubTitle:
                                          '${request.requestDate}  ${request.requestTime }',
                                      isFirst: false,
                                      isDone: false,
                                      isLast: false,
                                    ),
                                    TimeLineTileWidget(
                                      endChildTitle: 'Issue',
                                      endChildSubTitle:
                                          '${request.requestDate}  ${request.requestTime}',
                                      isFirst: false,
                                      isDone: false,
                                      isLast: true,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ))
            ],
          )),
    );
  }
}
