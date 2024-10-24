import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/clickable_card.dart';
import 'package:cssd/Widgets/date_picker_widget.dart';
import 'package:cssd/Widgets/endDrawer.dart';
import 'package:cssd/Widgets/rounded_container.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/model/sampleBatchNoQuantity.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/model/sampleRequestList.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/provider/pickup_provider.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/view/widgets/requests_widgets/from_to_date_picker_widget.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PickupPageCssdCussCssdLogin extends StatelessWidget {
  const PickupPageCssdCussCssdLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    final pickupProvider = Provider.of<PickupProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: StaticColors.scaffoldBackgroundcolor,
      endDrawer: endDrawer(),
      appBar: AppBar(
        title: Text('Pickup', style: FontStyles.appBarTitleStyle),
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
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  // department selection dropdown
                  child: Consumer<PickupProvider>(
                      builder: (context, pickupProvider, child) {
                    return DropdownMenu(
                      inputDecorationTheme: InputDecorationTheme(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                      width: 1.0.sw - 30,
                      menuHeight: 250,
                      label: const Text("Select Deparment"),
                      controller: pickupProvider.departmentSelection,
                      enableSearch: false,
                      enableFilter: false,
                      dropdownMenuEntries: pickupProvider.sampleDepartmentName
                          .map((dept) =>
                              DropdownMenuEntry(value: dept, label: dept))
                          .toList(),
                    );
                  }),
                ),
                //date picker and show button
                Consumer<PickupProvider>(
                    builder: (context, pickupProvider, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: DatePickerWidget(
                          label: "From",
                          controller: pickupProvider.fromDateTextController,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: DatePickerWidget(
                          label: "To",
                          controller: pickupProvider.toDateTextController,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      ButtonWidget(
                        buttonLabel: "Show",
                        onPressed: () {},
                      )
                    ],
                  );
                }),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Request list",
                    style: FontStyles.bodyPieTitleStyle,
                  ),
                ),
                //searched request list
                SizedBox(
                  height: mediaQuery.height * 0.35,
                  child: RoundedContainer(
                      containerBody: Scrollbar(
                    child: ListView.builder(
                      itemCount: sampleHighPriorityRequestsList.length,
                      itemBuilder: (context, index) {
                        final request = sampleHighPriorityRequestsList[index];

                        return ClickableCard(
                            cardColor: Colors.white,
                            requestID: request.requestID,
                            requestTitle: request.requestTitle,
                            requestDate: request.requestDate,
                            reqiestTime: "10.00",
                            requestDepartment: request.requestDepartment,
                            requestSubTitle: request.requestSubTitle);
                      },
                    ),
                  )),
                ),
                Text(
                  "Items under the selected request",
                  style: FontStyles.bodyPieTitleStyle,
                ),
                //items list
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: mediaQuery.height * 0.25
                  ),
                  child: SizedBox(
                    height: mediaQuery.height * 0.30,
                    child: RoundedContainer(
                        containerBody: Scrollbar(
                      child: ListView.builder(
                        itemCount: sampleHighPriorityRequestsList.length,
                        itemBuilder: (context, index) {
                          final request = sampleHighPriorityRequestsList[index];
                          final quantity =
                              SamplebBatchNo().sampleQuantityList[index];
                          final batch = SamplebBatchNo().sampleBatchNo[index];
                          return Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Checkbox(
                                    value: true,
                                    onChanged: (value) {},
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  flex: 6,
                                  child: Text(request.requestSubTitle),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                        child: Text(
                                          'Batch no. : $batch',
                                        ),
                                      ),
                                      SizedBox(
                                        height: 9.0.h,
                                      ),
                                      FittedBox(
                                        child: Text(
                                          'Quantity : $quantity',
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )),
                  ),
                ),

                Center(
                  child: ButtonWidget(
                    buttonLabel: "Pickup",
                    onPressed: () {},
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
