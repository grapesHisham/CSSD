import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/endDrawer.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/provider/request_controler.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/view/widgets/requests_widgets/custom_dropDownSearch.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RequestsView_cssdUser_cssdcustodian extends StatelessWidget {
  RequestsView_cssdUser_cssdcustodian({super.key});
  final List<String> _sampleDepartmentName = [
    "Cardiology",
    "Neurology",
    "Pediatrics",
    "	Obstetrics and Gynecology",
    "Oncology",
    "Orthopedics",
    "Radiology",
    "Pathology",
    "General Surgery"
        "Urology",
    "Dermatology",
    "Gastroenterology",
    "Nephrology",
    "Pulmonology",
    "Psychiatry",
  ];

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry<String>> dropdownMenuEntries = _sampleDepartmentName
        .map((department) =>
            DropdownMenuEntry(value: department, label: department))
        .toList();
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
        width: mediaQuery.width,
        height: mediaQuery.height,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            color: Colors.white),
        child: SingleChildScrollView(
          controller: requestControler.scrollController,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  // select from and to date textfield
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "From",
                              style: FontStyles.bodyPieTitleStyle,
                            ),
                          ),
                          TextFormField(
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1998),
                                      initialDate: DateTime.now(),
                                      lastDate: DateTime.now())
                                  .then((pickedDate) {
                                if (pickedDate != null) {
                                  String formatedDate =
                                      "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                                  requestControler.fromDateController.text =
                                      formatedDate;
                                }
                              });
                            },
                            readOnly: true,
                            keyboardType: TextInputType.number,
                            controller: requestControler.fromDateController,
                            decoration: InputDecoration(
                              hintText: 'Day-Month-Year',
                              hintStyle: TextStyle(color: Colors.grey.shade300),
                              constraints: BoxConstraints(
                                  maxWidth: mediaQuery.width / 2.5),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.lightBlue),
                                  borderRadius: BorderRadius.circular(15)),
                              border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15)),
                              label: const FittedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("dd-mm-yy"),
                                  ],
                                ),
                              ),
                              labelStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "To",
                              style: FontStyles.bodyPieTitleStyle,
                            ),
                          ),
                          TextFormField(
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1998),
                                      initialDate: DateTime.now(),
                                      lastDate: DateTime(2200))
                                  .then((pickedDate) {
                                if (pickedDate != null) {
                                  String formatedDate =
                                      "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                                  requestControler.toDateController.text =
                                      formatedDate;
                                }
                              });
                            },
                            readOnly: true,
                            keyboardType: TextInputType.number,
                            controller: requestControler.toDateController,
                            decoration: InputDecoration(
                              hintText: 'Day-Month-Year',
                              hintStyle: TextStyle(color: Colors.grey.shade300),
                              constraints: BoxConstraints(
                                  maxWidth: mediaQuery.width / 2.5),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.lightBlue),
                                  borderRadius: BorderRadius.circular(15)),
                              border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15)),
                              label: const FittedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("dd-mm-yy"),
                                  ],
                                ),
                              ),
                              labelStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
                            controller:
                                requestControler.departmentTextController,
                            enableSearch: true,
                            enableFilter: true,
                            dropdownMenuEntries: dropdownMenuEntries,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: dropDownWithSearchFiltering(mediaQuery: mediaQuery, requestControler: requestControler),
                      )
                    ],
                  ),

                  SizedBox(width: 8.0.w),

                  SizedBox(height: 10.h),

                  Padding(
                    padding: EdgeInsets.only(left: mediaQuery.width / 14),
                    child: ButtonWidget(
                      buttonLabel: 'Show',
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


