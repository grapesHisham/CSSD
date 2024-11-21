import 'dart:developer';

import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/custom_textfield.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/controller/dashboard_controller_dept.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/controller/used_item_entry_controller.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/used_item_model/used_items_model.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/view/widgets/dashboard_widgets/datagrid_used_item_entry_table_widget.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/view/widgets/dashboard_widgets/department_selection_widget.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/view/widgets/used_items_entry_widgets/items_for_selected_department_widget.dart';
import 'package:cssd/util/app_util.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:cssd/util/local_storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UsedItemEntryViewCssdCussDeptUser extends StatefulWidget {
  const UsedItemEntryViewCssdCussDeptUser({super.key});

  @override
  State<UsedItemEntryViewCssdCussDeptUser> createState() =>
      _UsedItemEntryViewCssdCussDeptUserState();
}

late String? selectedDepartment;

class _UsedItemEntryViewCssdCussDeptUserState
    extends State<UsedItemEntryViewCssdCussDeptUser> {
  List<UsedItemsListModelData> usedItems = [];
  late UsedItemsDataSource usedItemsDataSource;
  @override
  void initState() {
    selectedDepartment =
        LocalStorageManager.getString(StorageKeys.selectedDepartmentCounter);

    final usedItemsTable =
        Provider.of<UsedItemEntryController>(context, listen: false)
            .getUsedItemsTableBeforeSubmitList;
    usedItems = usedItemsTable;
    usedItemsDataSource = UsedItemsDataSource(usedItemsList: usedItems);
    log(usedItemsDataSource.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardController =
        Provider.of<DashboardControllerCssdCussDeptUser>(context,
            listen: false);
    final usedItemsController =
        Provider.of<UsedItemEntryController>(context, listen: false);

    Size mediaQuery = MediaQuery.of(context).size;
    final dashBoardController =
        Provider.of<DashboardControllerCssdCussDeptUser>(context,
            listen: false);
    return Scaffold(
        backgroundColor: StaticColors.scaffoldBackgroundcolor,
        appBar: AppBar(
          title: Text('Used Item Entry', style: FontStyles.appBarTitleStyle),
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
                  SizedBox(
                    height: 10.h,
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: [
                      SizedBox(
                        width: mediaQuery.width,
                        child: DepartmentSelectionWidget(
                          dashboardController: dashBoardController,
                        ),
                      ),
                      FetchItemsForSelectedDepartment(
                          dashboardController: dashboardController),
                      CustomTextFormField(
                        // quantity dropdown
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        textFieldSize: const Size(80.0, 80.0),
                        label: const Text(
                          "Quantity",
                          style: TextStyle(fontSize: 14),
                        ),
                        onFieldSubmitted: (quantity) {
                          if (usedItemsController.getSelectedItemModel ==
                              null  && selectedDepartment == null) {
                            showSnackBarNoContext(
                                isError: true, msg: "Select Dept / item first");
                            log("No items selected");
                          } else {
                            usedItemsController.qtyValidation(
                              isPckg: usedItemsController
                                          .getSelectedItemModel!.pckg ==
                                      1
                                  ? true
                                  : false,
                              location: selectedDepartment!,
                              productid: usedItemsController
                                  .getSelectedItemModel!.pid!,
                              qty: int.parse(
                                quantity,
                              ),
                            );
                            log("isPckg: ${usedItemsController.getSelectedItemModel!.pckg == 1}");
                            log("location: $selectedDepartment");
                            log("productid: ${usedItemsController.getSelectedItemModel!.pid!}");
                            log("qty: ${int.parse(quantity)}");
                          }
                        },
                        /*  validator: (quantity) {
                              if (quantity == null || quantity.isEmpty) {
                                return "Enter quantity";
                              }
                    
                              if (usedItemsController.getSelectedItemModel ==
                                  null) { 
                                return "Select item first";
                              }
                              return null;
                            }, */
                        controller: usedItemsController.quantityController,
                      ),
                      //add item text field
                      ButtonWidget(
                        buttonSize: const Size(0.0, 55.0),
                        buttonLabel: "Add item",
                        buttonTextSize: 14,
                        onPressed: () async {
                          final itemModel =
                              usedItemsController.getSelectedItemModel;

                          if (usedItemsController.selectedItemName != null &&
                              itemModel != null && selectedDepartment != null) {
                            bool isQntValid =
                                await usedItemsController.qtyValidation(
                              isPckg: itemModel.pckg == 1 ? true : false,
                              location: selectedDepartment!,
                              productid: itemModel.pid!,
                              qty: int.parse(
                                usedItemsController.quantityController.text ??
                                    "0",
                              ),
                            );

                            if (isQntValid) {
                              usedItemsController
                                  .addToUsedItemsTableBeforeSubmit(
                                productId: itemModel.pid!,
                                productName: itemModel.productName!,
                                location:                                  selectedDepartment!,

                                uQty: int.parse(
                                  usedItemsController.quantityController.text,
                                ),
                              );
                            }
                          } else {
                            showSnackBarNoContext(
                                isError: true, msg: "Item / dept not selected");
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0.h),
                  Consumer<UsedItemEntryController>(
                      builder: (context, usedItemConsumer, child) {
                    usedItemsDataSource = UsedItemsDataSource(
                        usedItemsList:
                            usedItemConsumer.getUsedItemsTableBeforeSubmitList);
                    return SfDataGrid(
                        source: usedItemsDataSource,
                        columns: <GridColumn>[
                          GridColumn(
                              columnName: "ProductID",
                              label: Container(
                                alignment: Alignment.center,
                                color: Colors.deepPurple,
                                child: const Text(
                                  "PID.",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              )),
                          GridColumn(
                              columnWidthMode: ColumnWidthMode.auto,
                              columnName: "ProductName",
                              label: Container(
                                alignment: Alignment.center,
                                color: Colors.deepPurple,
                                child: const Text(
                                  "Product Name",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              )),
                          GridColumn(
                              columnName: "UQty",
                              label: Container(
                                alignment: Alignment.center,
                                color: Colors.deepPurple,
                                child: const Text(
                                  "Quantity",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              )),
                          GridColumn(
                              columnName: "Location",
                              label: Container(
                                alignment: Alignment.center,
                                color: Colors.deepPurple,
                                child: const Text(
                                  "Location",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ))
                        ]);
                  })
                ])))));
  }
}
