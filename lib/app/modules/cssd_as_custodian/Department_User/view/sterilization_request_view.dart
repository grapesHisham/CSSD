import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/custom_textfield.dart';
import 'package:cssd/Widgets/dropdown_menu_widget.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/controller/dashboard_controller_dept.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/controller/sterilization_controller.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/view/widgets/department_selection_all_pages_widget.dart';
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
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              Wrap(
                runSpacing: 10,
                spacing: 10,
                children: [
                  //department selection dropdown
                  DepartmentSelectionWidget(
                    dashboardController: dashboardController,
                  ),
                  //priority dropdown
                  CustomDropDownMenuWidget(dropdownMenuEntries: const [
                    DropdownMenuEntry(value: "High", label: "High"),
                    DropdownMenuEntry(value: "Medium", label: "Medium"),
                    DropdownMenuEntry(value: "Low", label: "Low"),
                  ], onSelected: (p0) {}, label: "Priority"),

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
                              isError: true, msg: "selected item is null");
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
                        return sterilizationConsumer.getUsedItemsListForSearch;
                      },
                      headerBuilder: (context, selectedItem, enabled) {
                        if (sterilizationConsumer
                                .getSelectedUsedItemModel?.productName ==
                            null) {
                          log("item model is ${sterilizationConsumer.getSelectedUsedItemModel}");
                          // clear the header when itemmodel is null - set when department in changed from dropdown
                          return const Text("");
                        }
                        log("item model is ${sterilizationConsumer.getSelectedUsedItemModel?.productName}");
                        return Text(selectedItem.productName);
                      },
                      listItemBuilder:
                          (context, item, isSelected, onItemSelect) => ListTile(
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
                  // quantity dropdown
                  CustomTextFormField(
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
                          sterilizationController.getSelectedUsedItemModel;
                      if (quantity.isNotEmpty && item?.productName != null) {
                        log("add button clicked");
                        sterilizationController.addItemsToGrid(
                            item?.productName ?? "", quantity);
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
                  ),
                ],
              ),

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

              SizedBox(
                height: 12.h,
              ),
              SizedBox(
                height: 190,
                child: Consumer<SterilizationControllerCssdCussDeptUser>(
                    builder: (context, sterilizationConsumer, child) {
                  return Scrollbar(
                    child: ListView.builder(

                     /*  gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 1.7,
                      ), */
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
                                        Text("${item['itemName']}")
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
