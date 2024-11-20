import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/controller/dashboard_controller_dept.dart';
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
    return Consumer<DashboardControllerCssdCussDeptUser>(
        // items search suggestions
        builder: (context, dashboardConsumer, child) {
      return CustomDropdown.searchRequest(
        onChanged: (selectedValue) {
          if (selectedValue != null) {
            dashboardConsumer.selectedDepartment =
                selectedValue;
          }
        },
        futureRequestDelay: const Duration(milliseconds: 0),
        futureRequest: (stringItem) async {
          await dashboardConsumer.fetchItems(
              itemname: stringItem,
              department:
                  dashboardController.getSelectedDepartment!);
    
          return dashboardConsumer.itemsNames;
        },
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