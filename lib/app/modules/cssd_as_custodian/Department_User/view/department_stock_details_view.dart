import 'dart:developer';

import 'package:cssd/Widgets/custom_textfield.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/controller/dashboard_controller_dept.dart';
import 'package:cssd/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DepartmentStockDetailsView extends StatefulWidget {
  const DepartmentStockDetailsView({super.key});

  @override
  State<DepartmentStockDetailsView> createState() =>
      _DepartmentStockDetailsViewState();
}

class _DepartmentStockDetailsViewState
    extends State<DepartmentStockDetailsView> {
  @override
  void initState() {
    final dashboardController =
        Provider.of<DashboardControllerCssdCussDeptUser>(context,
            listen: false);
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      await dashboardController.filterFutureList("");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardController =
        Provider.of<DashboardControllerCssdCussDeptUser>(context,
            listen: false);
    return Scaffold(
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
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Department Stock details",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Consumer<DashboardControllerCssdCussDeptUser>(
                  builder: (context, dashboardConsumer, child) {
                return CustomTextFormField(
                  controller: dashboardConsumer.searchController,
                  onChanged: (query) {
                    log(query);
                    dashboardConsumer.filterFutureList(query);
                  },
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
                    }
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
