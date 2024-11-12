import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cssd/Widgets/custom_textfield.dart';
import 'package:cssd/Widgets/dropdown_menu_widget.dart';
import 'package:cssd/Widgets/rounded_container.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/controller/request_controler.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/view/widgets/requests_widgets/dropdown_search.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/controller/sterilization_controller.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/sterilization_models/items_list_model.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/view/widgets/sterilization_widgets/overlay_widget.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SterilizationRequestViewCssdCussDeptUser extends StatelessWidget {
  const SterilizationRequestViewCssdCussDeptUser({super.key});

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;

    final requestControler =
        Provider.of<RequestControler>(context, listen: false);

    final sterilizationController =
        Provider.of<SterilizationControllerCssdCussDeptUser>(context,
            listen: false);

    Future.microtask(() async {
      await sterilizationController.departmentDropdownFunction();
    });

    return Scaffold(
      backgroundColor: StaticColors.scaffoldBackgroundcolor,
      appBar: AppBar(
        title:
            Text('Sterilization Request', style: FontStyles.appBarTitleStyle),
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
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(children: [
            Wrap(
              runSpacing: 10,
              spacing: 10,
              children: [
                Consumer<SterilizationControllerCssdCussDeptUser>(
                    builder: (context, sterilizationConsumer, child) {
                  /*  if (sterilizationConsumer.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (sterilizationConsumer.departmentDropdownItems.isEmpty) {
                    return const Center(
                        child: Text("No departments available"));
                  } */
                  return CustomDropDownMenuWidget(
                    dropDownWidth: 190,
                    label: "Department",
                    dropdownMenuEntries: sterilizationConsumer
                        .departmentDropdownItems
                        .map((departments) => DropdownMenuEntry(
                            value: departments.subId,
                            label: departments.subName!))
                        .toList(),
                    onSelected: (value) {
                      if (value != null) {
                        sterilizationController.setSelectedDepartment = value;
                      }
                    },
                  );
                }),
                SizedBox(height: 10.h),
                CustomDropDownMenuWidget(
                    dropDownWidth: 150,
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: "High", label: "High"),
                      DropdownMenuEntry(value: "Medium", label: "Medium"),
                      DropdownMenuEntry(value: "Low", label: "Low"),
                    ],
                    onSelected: (p0) {},
                    label: "Priority"),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600, maxHeight: 400),
              child: RoundedContainer(
                containerHeight: mediaQuery.height / 7,
                containerBody: CustomTextFormField(
                  controller: sterilizationController.remarksController,
                  label: const Text("Remarks"),
                  textfieldBorder: false,
                ),
              ),
            ),

            //items listing and textfield
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 10,
              runSpacing: 10,
              children: [
                // DropDownWithSearchFiltering(
                //   mediaQuery: mediaQuery,
                //   requestControler: requestControler,
                // ),
                ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxWidth: 150, maxHeight: 50),
                  child: Consumer<SterilizationControllerCssdCussDeptUser>(
                      builder: (context, sterilizationConsumer, child) {
                    return TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          label: Text("Item Name")),
                      onChanged: (value) {
                        sterilizationController.fetchItems(value);
                        if (sterilizationConsumer.itemsList.isNotEmpty) {
                          /* showOverlay(
                              context, sterilizationConsumer.itemsNames); */
                           
                        }
                      },
                      controller: sterilizationController.itemNameController,
                    );
                  }),
                ),
                Consumer<SterilizationControllerCssdCussDeptUser>(
                      builder: (context, sterilizationConsumer, child) {
                    return CustomDropdown<GetItemNameModelData>(
                      hintText: "Items",
                      
                      items: sterilizationConsumer.itemsList, onChanged: (p0) {
                      
                    },);
                  }
                ),
                SizedBox(
                  width: 90,
                  child: CustomTextFormField(
                    label: const Text("Quantity"),
                    controller: sterilizationController.quantityController,
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}


/* Consumer<SterilizationControllerCssdCussDeptUser>(
                      builder: (context, controller, child) {
                        if (controller.isLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (controller.departmentDropdownItems.isEmpty) {
                          return const Center(
                              child: Text("No departments available"));
                        }
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: DropdownButton<GetDepartmentListModelData>(
                            isExpanded: true,
                            hint: const Text("Select Department"),
                            items: controller.departmentDropdownItems
                                .map((GetDepartmentListModelData element) =>
                                    DropdownMenuItem<GetDepartmentListModelData>(
                                      value: element,
                                      child: Text(element.subName.toString()),
                                    ))
                                .toList(),
                            onChanged: (selectedDepartment) {
                              log("Selected department: $selectedDepartment");
                            },
                          ),
                        );
                      },
                    ), */