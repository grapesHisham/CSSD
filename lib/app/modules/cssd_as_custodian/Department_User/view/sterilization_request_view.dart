import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/custom_textfield.dart';
import 'package:cssd/Widgets/dropdown_menu_widget.dart';
import 'package:cssd/Widgets/rounded_container.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/controller/sterilization_controller.dart';
import 'package:cssd/util/app_util.dart';
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

    final sterilizationController =
        Provider.of<SterilizationControllerCssdCussDeptUser>(context,
            listen: false);

    Future.microtask(() async {
      await sterilizationController.departmentDropdownFunction(); //add later check
    });

    return Scaffold(
      backgroundColor: StaticColors.scaffoldBackgroundcolor,
      appBar: AppBar(
        title:
            Text('Sterilization Request', style: FontStyles.appBarTitleStyle),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.0.h, vertical: 10.0.h),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.max, children: [
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
                      dropDownWidth: mediaQuery.width * 0.4,
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
                  CustomDropDownMenuWidget(dropdownMenuEntries: const [
                    DropdownMenuEntry(value: "High", label: "High"),
                    DropdownMenuEntry(value: "Medium", label: "Medium"),
                    DropdownMenuEntry(value: "Low", label: "Low"),
                  ], onSelected: (p0) {}, label: "Priority"),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              //remarks container
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 600, maxHeight: 400),
                child: RoundedContainer(
                  containerHeight: mediaQuery.height / 7,
                  containerBody: CustomTextFormField(
                    minLines: 1,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
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
                  SizedBox(
                    width: mediaQuery.width / 1.6,
                    child: Consumer<SterilizationControllerCssdCussDeptUser>(
                        // items search suggestions
                        builder: (context, sterilizationConsumer, child) {
                      return CustomDropdown.searchRequest(
                        onChanged: (selectedValue) {
                          if (selectedValue != null) {
                            sterilizationConsumer.setSelectedItemDropdown =
                                selectedValue;
                          }
                        },
                        futureRequestDelay: Duration(milliseconds: 0),
                        futureRequest: (StringItem) async {
                          await sterilizationConsumer.fetchItems(StringItem);

                          return sterilizationConsumer.itemsNames;
                        },
                        decoration: CustomDropdownDecoration(
                          closedBorder: Border.all(color: Colors.grey),
                        ),
                        hintText: "Items",
                        searchHintText: "Search items",
                        hideSelectedFieldWhenExpanded: false,
                      );
                    }),
                  ),
                  CustomTextFormField(
                    // quantity dropdown
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    textFieldSize: const Size(90.0, 80.0),
                    label: const Text("Quantity"),
                    controller: sterilizationController.quantityController,
                  ),
                  ButtonWidget(
                    buttonLabel: "Add",
                    onPressed: () {
                      final quantity =
                          sterilizationController.quantityController.text;
                      final item =
                          sterilizationController.getSelectedItemDropdown;
                      if (quantity.isNotEmpty && item.isNotEmpty) {
                        log("add button clicked");
                        sterilizationController.addItemsToGrid(item, quantity);
                        sterilizationController.clearInputs();
                      } else {
                        // showToast(context,"Empty String , selected item : $item, quantity: $quantity");
                        showSnackBarNoContext(
                            isError: true,
                            msg:
                                "Empty String , selected item : $item, quantity: $quantity");
                      }
                      showToast(context, "Item added  $item : $quantity");
                    },
                  )
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              SizedBox(
                height: 190,
                child: Consumer<SterilizationControllerCssdCussDeptUser>(
                    builder: (context, sterilizationConsumer, child) {
                  return Scrollbar(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 1.7,
                      ),
                      itemCount:
                          sterilizationConsumer.getSelectedItemsQuantity.length,
                      itemBuilder: (context, index) {
                        final item = sterilizationConsumer
                            .getSelectedItemsQuantity[index];
                        return Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Item:',
                                          overflow: TextOverflow.visible,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        SizedBox(
                                            width: 60,
                                            // child: Text(" ${item['itemName']}"))
                                            child: Text("${item['itemName']}"))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Quantity:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(' ${item['quantity']}'),
                                      ],
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      sterilizationConsumer
                                          .deleteCurrentItemFromList(item);
                                      log("deleted item ${sterilizationConsumer.getSelectedItemsQuantity}");
                                    },
                                    icon: const Icon(Icons.delete))
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
              ButtonWidget(
                buttonLabel: "Send for Sterilization",
                onPressed: () {
                  //add methode to sent for sterilization
                },
              )
            ]),
          ),
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