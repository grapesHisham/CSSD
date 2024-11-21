import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/controller/dashboard_controller_dept.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/controller/used_item_entry_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FetchItemsForSelectedDepartment extends StatelessWidget {
  const FetchItemsForSelectedDepartment({
    super.key,
    required this.dashboardController,
  });

  final DashboardControllerCssdCussDeptUser dashboardController;

  @override
  Widget build(BuildContext context) {
    return Consumer<UsedItemEntryController>(
        // items search suggestions
        builder: (context, usedItemEntryConsumer, child) {
      return CustomDropdown.searchRequest(
        onChanged: (selectedItemModel) {
          if (selectedItemModel != null) {
            
          usedItemEntryConsumer.setSelectedItemModel = selectedItemModel;
          }
        },
        futureRequestDelay: const Duration(milliseconds: 0),
        futureRequest: (stringItem) async {
          await usedItemEntryConsumer.fetchItems(
              itemname: stringItem,
              department: dashboardController.getSelectedDepartment!);

          // return usedItemEntryConsumer.itemsList.map((item)=> item.productName).toList();
          return usedItemEntryConsumer.getItemsList;
        },
        headerBuilder: (context, selectedItem, enabled) =>
            Text(selectedItem.productName ?? ""),
        listItemBuilder: (context, item, isSelected, onItemSelect) => ListTile(
          title: Text(item.productName ?? ""),
        ),
        decoration: CustomDropdownDecoration(
          closedBorder: Border.all(color: Colors.grey),
        ),
        hintText: "Items",
        searchHintText: "Search items",
        hideSelectedFieldWhenExpanded: false,
      );
    });
  }
}
