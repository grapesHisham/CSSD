import 'dart:developer';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/controller/dashboard_controller_dept.dart';
import 'package:cssd/util/app_util.dart';
import 'package:cssd/util/local_storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DepartmentSelectionDashboardWidget extends StatelessWidget {
  const DepartmentSelectionDashboardWidget({
    super.key,
    required this.dashboardController,
  });

  final DashboardControllerCssdCussDeptUser dashboardController;

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardControllerCssdCussDeptUser>(
        builder: (context, dashboardConsumer, child) {
      if (dashboardConsumer.departmentDropdownItems.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      final departmentNames = dashboardConsumer.departmentDropdownItems
          .map((dept) => dept.subName)
          .toList();

      return CustomDropdown.search(
        decoration: CustomDropdownDecoration(
            closedBorder: Border.all(color: Colors.grey)),
        initialItem: LocalStorageManager.getString(
            StorageKeys.selectedDepartmentCounter),
        hintText: "Department name",
        searchHintText: "Search department name",
        items: departmentNames,
        
        onChanged: (selectedDepartment) {
          if (selectedDepartment != null) {
            dashboardController.getPieChartData(
                selectedDepartment); // should not fetch pie chart data while changing dept from pages other than dashboard
            dashboardConsumer.updateSelectedDepartment(selectedDepartment);
            log("stored to selectedDepartmentCounter : ${LocalStorageManager.getString(StorageKeys.selectedDepartmentCounter)}");
          } else {
            showToast(context, "Select department");
          }
        },
      );
    });
  }
}
