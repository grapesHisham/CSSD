import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/clickable_card.dart';
import 'package:cssd/Widgets/endDrawer.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/model/sampleRequestList.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/provider/request_controler.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/view/widgets/requests_widgets/dropdown_search.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/view/widgets/requests_widgets/from_to_date_picker_widget.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RequestsViewCssdCussCssdLogin extends StatelessWidget {
  const RequestsViewCssdCussCssdLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.of(context).size;
    final requestControler =
        Provider.of<RequestControler>(context, listen: false);

    return Scaffold(
      backgroundColor: StaticColors.scaffoldBackgroundcolor,
      endDrawer: endDrawer(),
      appBar: AppBar(
        title: Text('All Requests', style: FontStyles.appBarTitleStyle),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ), 
                FromToDatePicker(
                    fromDateController: requestControler.fromDateController,
                    toDateController: requestControler.toDateController),
                SizedBox(height: 20.h),
                // select department and select user dropdowns
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                        width: mediaQuery.width * 0.40,
                        child: DropdownMenu(
                          inputDecorationTheme: InputDecorationTheme(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          width: mediaQuery.width / 2.5,
                          label: const Text("Select Deparment"),
                          controller: requestControler.departmentTextController,
                          enableSearch: false,
                          enableFilter: false,
                          dropdownMenuEntries:
                              requestControler.dropdownMenuEntries,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: dropDownWithSearchFiltering(
                          mediaQuery: mediaQuery,
                          requestControler: requestControler),
                    )
                  ],
                ),

                SizedBox(height: 10.h),

                Padding(
                  padding: EdgeInsets.only(left: mediaQuery.width / 14),
                  child: ButtonWidget(
                    borderRadius: 12,
                    buttonLabel: 'Show',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            Expanded(
              // height: mediaQuery.height / 2, // Set a finite height
              child: ListView.builder(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.0.h, vertical: 10.w),
                shrinkWrap: true,
                itemCount:
                    sampleHighPriorityRequestsList.length, //change later on
                itemBuilder: (context, index) {
                  final request = sampleHighPriorityRequestsList[index];
                  return sampleHighPriorityRequestsList.isEmpty
                      ? null
                      : ClickableCard(
                          cardClickFunction: () {
                            Navigator.pushNamed(context,
                                Routes.requestDetailsViewCssdCussCssLogin);
                            print("Card clicked");
                          },
                          cardColor: Colors.white,
                          requestID: request.requestID,
                          requestTitle: request.requestTitle,
                          requestDate: request.requestDate,
                          reqiestTime: request.requestTime,
                          requestDepartment: request.requestDepartment,
                          requestSubTitle: request.requestSubTitle,
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
