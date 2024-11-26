import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/controller/dashboard_controller_dept.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/controller/used_item_entry_controller.dart';
import 'package:cssd/util/app_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FetchItemsForSelectedDepartment extends StatefulWidget {
  const FetchItemsForSelectedDepartment({
    super.key,
    required this.dashboardController,
  });

  final DashboardControllerCssdCussDeptUser dashboardController;

  @override
  State<FetchItemsForSelectedDepartment> createState() =>
      _FetchItemsForSelectedDepartmentState();
}

class _FetchItemsForSelectedDepartmentState
    extends State<FetchItemsForSelectedDepartment> {
  late String? selectedDepartment;
  @override
  void initState() {
    final dashboardController =
        Provider.of<DashboardControllerCssdCussDeptUser>(context,
            listen: false);
    selectedDepartment = dashboardController.getSelectedDepartment;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UsedItemEntryController>(
        // items search suggestions
        builder: (context, usedItemEntryConsumer, child) {
      final dashboardController =
          Provider.of<DashboardControllerCssdCussDeptUser>(context,
              listen: false);

      selectedDepartment = dashboardController.getSelectedDepartment;
      return CustomDropdown.searchRequest(
        onChanged: (selectedItemModel) {
          if (selectedItemModel != null) {
            log('currently selected item : ${selectedItemModel.productName}');
            usedItemEntryConsumer.setSelectedItemModel = selectedItemModel;
          } else {
            showSnackBarNoContext(isError: true, msg: "selected item is null");
          }
        },
        futureRequestDelay: const Duration(milliseconds: 0),
        futureRequest: (stringItem) async {
          if (selectedDepartment == null) {
            showSnackBarNoContext(
                isError: true, msg: "Select department to list items");
          } else {
            await usedItemEntryConsumer.fetchItems(
                itemname: stringItem, department: selectedDepartment!);
          }
          /*  await usedItemEntryConsumer.fetchItems(
              itemname: stringItem,
              department: dashboardController.getSelectedDepartment!); */

          return usedItemEntryConsumer.getItemsList;
        },
        headerBuilder: (context, selectedItem, enabled) {
          if (usedItemEntryConsumer.getSelectedItemModel?.productName == null) {
            return const Text("");
          }
            log("item model is ${usedItemEntryConsumer.getSelectedItemModel?.productName}");
          return Text(selectedItem.productName ?? "");
        },
        listItemBuilder: (context, item, isSelected, onItemSelect) => ListTile(
          title: Text(item.productName ?? ""),
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
    });
  }
}
