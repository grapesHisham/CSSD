import 'package:cssd/Widgets/dropdown_menu_widget.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/controller/sterilization_controller.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SterilizationRequestViewCssdCussDeptUser extends StatelessWidget {
  const SterilizationRequestViewCssdCussDeptUser({super.key});

  @override
  Widget build(BuildContext context) {
    final sterilizationController =
        Provider.of<SterilizationControllerCssdCussDeptUser>(context,
            listen: false);
    return Scaffold(
        backgroundColor: StaticColors.scaffoldBackgroundcolor,
        appBar: AppBar(
          title:
              Text('Sterilization Request', style: FontStyles.appBarTitleStyle),
        ),
        body: Container(
            // height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10.0.h, vertical: 10.0.h),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: Colors.white),
            child: Column(children: [
              // InkWell(
              //   onTap: () {
              //     sterilizationController.callDepartmentList();
              //   },
              //   child: CustomDropDownMenuWidget(
              //     dropDownWidth: 190,
              //     label: "Department",
              //     dropdownMenuEntries: sterilizationController.departmentNames
              //         .map((departments) => DropdownMenuEntry(
              //             value: departments, label: departments!))
              //         .toList(),
              //     onSelected: (p0) {},
              //   ),
              // ),

              Consumer<SterilizationControllerCssdCussDeptUser>(
                builder: (context, controller, child) {
                  if (controller.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (controller.departmentNames.isEmpty) {
                    return Center(child: Text("No departments available"));
                  }

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text("Select Department"),
                      items: controller.departmentNames
                          .map((department) => DropdownMenuItem<String>(
                                value: department,
                                child: Text(department!),
                              ))
                          .toList(),
                      onChanged: (selectedDepartment) {
                        print("Selected department: $selectedDepartment");
                      },
                    ),
                  );
                },
              ),
            ])));
  }
}
