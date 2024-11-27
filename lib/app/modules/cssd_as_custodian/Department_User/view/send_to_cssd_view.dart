import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/custom_textfield.dart';
import 'package:cssd/Widgets/rounded_container.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/controller/dashboard_controller_dept.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/controller/sterilization_controller.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/view/widgets/department_selection_all_pages_widget.dart';
import 'package:cssd/util/app_util.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_act/slide_to_act.dart';

class SterilizationRequestViewCssdCussDeptUser extends StatelessWidget {
  const SterilizationRequestViewCssdCussDeptUser({super.key});

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    final dashboardController =
        Provider.of<DashboardControllerCssdCussDeptUser>(context,
            listen: false);
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
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        //department selection dropdown
                        DepartmentSelectionWidget(
                          dashboardController: dashboardController,
                        ),

                        SizedBox(
                          height: 10.h,
                        ),
                        //get used items dropdown
                        Consumer<SterilizationControllerCssdCussDeptUser>(
                            // items search suggestions
                            builder: (context, sterilizationConsumer, child) {
                          final dashboardController =
                              Provider.of<DashboardControllerCssdCussDeptUser>(
                                  context,
                                  listen: false);

                          // fetching selected department from dashboard
                          String selectedDepartment =
                              dashboardController.getSelectedDepartment;
                          return CustomDropdown.searchRequest(
                            onChanged: (selectedItemModel) {
                              if (selectedItemModel != null) {
                                log('currently selected item : ${selectedItemModel.productName}');
                                sterilizationConsumer.setSelectedItemModel =
                                    selectedItemModel;
                              } else {
                                showSnackBarNoContext(
                                    isError: true,
                                    msg: "selected item is null");
                              }
                            },
                            futureRequestDelay: const Duration(milliseconds: 0),
                            futureRequest: (stringItem) async {
                              // api calling to get the item name
                              if (selectedDepartment == "") {
                                showSnackBarNoContext(
                                    isError: true,
                                    msg: "Select department to search items");
                              } else {
                                await sterilizationConsumer.fetchUsedItems(
                                    searchQuery: stringItem,
                                    location: selectedDepartment);
                              }
                              // list of items for the search query
                              return sterilizationConsumer
                                  .getUsedItemsListForSearch;
                            },
                            headerBuilder: (context, selectedItem, enabled) {
                              if (sterilizationConsumer
                                      .getSelectedUsedItemModel?.productName ==
                                  null) {
                                // clear the header when itemmodel is null - set when department in changed from dropdown
                                return const Text("");
                              }
                              log("item model is ${sterilizationConsumer.getSelectedUsedItemModel?.productName}");
                              return Text(selectedItem.productName);
                            },
                            listItemBuilder:
                                (context, item, isSelected, onItemSelect) =>
                                    ListTile(
                              title: Text(item.productName),
                              subtitle: Text(
                                "used quantity : ${item.usedQty}",
                              ),
                            ),
                            decoration: CustomDropdownDecoration(
                              closedBorder: Border.all(color: Colors.grey),
                            ),
                            hintText: "Items",
                            searchHintText: "Search items",
                            hideSelectedFieldWhenExpanded: false,
                            validator: (item) {
                              if (item == null) {
                                return "Section required";
                              }
                              return null;
                            },
                          );
                        }),
                      ],
                    )),
                SizedBox(
                  width: 10.w,
                ),
                Flexible(
                    // flex: 1,
                    child: Column(
                  children: [
                    //priority dropdown
                    DropdownMenu(
                        menuHeight: 230,
                        label: const Text(
                          "Priority",
                          overflow: TextOverflow.fade,
                        ),
                        inputDecorationTheme: InputDecorationTheme(
                          fillColor: Colors.amber,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                        ),
                        dropdownMenuEntries: const [
                          DropdownMenuEntry(
                            value: "High",
                            label: "High Priority",
                          ),
                          DropdownMenuEntry(
                              value: "Medium", label: "Medium Priority"),
                          DropdownMenuEntry(
                              value: "Low", label: "Low Priority"),
                        ],
                        trailingIcon: const Padding(
                          padding: EdgeInsets.only(right: 0),
                          child: Icon(Icons.arrow_drop_down),
                        ),
                        onSelected: (priority) {
                          if (priority != null) {
                            sterilizationController.setPriority(priority);
                          } else {
                            log("priority null so default priority Medium is passed ");
                          }
                        }),

                    SizedBox(
                      height: 10.h,
                    ),
                    // quantity dropdown
                    CustomTextFormField(
                      /* inputFormatters: [
              FilteringTextInputFormatter.digitsOnly, // Restricts input to digits only
            ], */
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      textFieldSize: const Size(double.infinity, 80.0),
                      label: const FittedBox(child: Text("Quantity")),
                      controller: sterilizationController.quantityController,
                    ),
                  ],
                )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonWidget(
                buttonLabel: "Add",
                onPressed: () {
                  final quantity =
                      sterilizationController.quantityController.text;
                  final item = sterilizationController.getSelectedUsedItemModel;
                  if (quantity.isNotEmpty && item?.productName != null) {
                    log("add button clicked");
                    sterilizationController.addItemsToGrid(
                        item!, int.parse(quantity));
                    sterilizationController.clearInputs();
                  } else {
                    log(" Empty String , selected item : ${item?.productName}, quantity: $quantity");

                    showSnackBarNoContext(
                        isError: true, msg: "Item name or Quantity is empty");
                  }
                },
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Flexible(
              child: Consumer<SterilizationControllerCssdCussDeptUser>(
                  builder: (context, sterilizationConsumer, child) {
                return Scrollbar(
                  child: ListView.builder(
                    itemCount: sterilizationConsumer
                        .getSelectedItemsQuantityList.length,
                    itemBuilder: (context, index) {
                      final item = sterilizationConsumer
                          .getSelectedItemsQuantityList[index];
                      return Card(
                        color: Colors.lightBlue.shade100,
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 15),
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
                                      Text(item.productname)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Quantity:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(' ${item.qty}'),
                                    ],
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    sterilizationConsumer
                                        .deleteCurrentItemFromList(item);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.black,
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
            //send to cssd button
            /* ButtonWidget(
              buttonLabel: "Send for Sterilization",
              onPressed: () {
          /*                   customDialog(
                  dialogContext: context,
                  dialogContent: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //remarks container
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                            maxWidth: 600, maxHeight: 400),
                        child: RoundedContainer(
                          containerHeight: mediaQuery.height / 7,
                          containerBody: CustomTextFormField(
                            minLines: 1,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            controller:
                                sterilizationController.remarksController,
                            label: const Text("Remarks"),
                            textfieldBorder: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onAcceptDefaultAction: () {
                    //api call
                    sterilizationController
                        .sendUsedItemsToCssd(
                            dashboardController.getSelectedDepartment)
                        .then((_) {
                      Navigator.pop(context);
                    });
                  },
                  onCancelDefaultAction: () {
                    Navigator.pop(context);
                  },
                ); */
              },
            ), */
            //remarks container
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600, maxHeight: 400),
              child: RoundedContainer(
                containerHeight: 100,
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: SlideAction(
                outerColor: StaticColors.scaffoldBackgroundcolor,
                text: "Slide to send to cssd",
                sliderButtonIconPadding: 10,
                onSubmit: () {
                  return sterilizationController.sendUsedItemsToCssd(
                      dashboardController.getSelectedDepartment);
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

//remarks container
/* ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: 600, maxHeight: 400),
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
              ), */

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
