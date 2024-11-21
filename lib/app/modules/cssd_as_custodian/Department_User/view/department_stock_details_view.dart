import 'dart:developer';

import 'package:cssd/Widgets/custom_textfield.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/controller/dashboard_controller_dept.dart';
import 'package:cssd/util/app_util.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/local_storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DepartmentStockDetailsView extends StatefulWidget {
  const DepartmentStockDetailsView({super.key});

  @override
  State<DepartmentStockDetailsView> createState() =>
      _DepartmentStockDetailsViewState();
}

late String? selectedDepartment;

class _DepartmentStockDetailsViewState
    extends State<DepartmentStockDetailsView> {
  @override
  void initState() {
    selectedDepartment =
        LocalStorageManager.getString(StorageKeys.selectedDepartmentCounter);
    final dashboardController =
        Provider.of<DashboardControllerCssdCussDeptUser>(context,
            listen: false);
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      if (selectedDepartment != null) {
        await dashboardController.filterFutureList("", selectedDepartment!);
      } else {
        showSnackBar(context: context, isError: true, msg: "Select Department");
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final dashboardController =
        Provider.of<DashboardControllerCssdCussDeptUser>(context,
            listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: const Text(
          "Department Stock Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: GradientColors.backgroundGradient)),
        child: SafeArea(
          child: Column(
            children: [
              Consumer<DashboardControllerCssdCussDeptUser>(
                  builder: (context, dashboardConsumer, child) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFormField(
                    hintText: "Search items",
                    // textFieldSize: Size(mediaQuery.width - 20.w, 0.0),
                    controller: dashboardConsumer.searchController,
                    onChanged: (query) {
                      if (selectedDepartment != null) {
                        log(query);
                        dashboardConsumer.filterFutureList(
                            query, selectedDepartment!);
                      } else {
                        showSnackBar(
                            context: context,
                            isError: true,
                            msg: "Select Department first");
                      }
                    },
                  ),
                );
              }),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<DashboardControllerCssdCussDeptUser>(
                      builder: (context, dashboardConsumer, child) {
                    return GridView.builder(
                      itemCount: dashboardConsumer.filteredDeptStockList.length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          mainAxisExtent: 70),
                      itemBuilder: (context, index) {
                        final product =
                            dashboardConsumer.filteredDeptStockList[index];
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(product.productName),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "${product.stock}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
