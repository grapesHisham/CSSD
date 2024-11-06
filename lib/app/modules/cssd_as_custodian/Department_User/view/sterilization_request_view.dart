import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/view/widgets/issue_widgets.dart/dropdown_menu_widget.dart';
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
              CustomDropDownMenuWidget(
                dropDownWidth: 190,
                label: "Department",
                dropdownMenuEntries:
                    sterilizationController.departmentDropDownEntries,
                onSelected: (p0) {},
              ),
            ])));
  }
}
