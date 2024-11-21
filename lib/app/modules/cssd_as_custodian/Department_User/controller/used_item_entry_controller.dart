import 'dart:developer';

import 'package:cssd/app/api/dio_interceptors/dio_interceptor.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/sterilization_models/items_list_model.dart';
import 'package:cssd/util/app_util.dart';
import 'package:flutter/material.dart';

class UsedItemEntryController extends ChangeNotifier {
  TextEditingController quantityController = TextEditingController();

  GetItemNameModelData? _selectedItemModel;
  GetItemNameModelData? get getSelectedItemModel => _selectedItemModel;
  set setSelectedItemModel(GetItemNameModelData value) {
    _selectedItemModel = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //fetch items list for selected department
  final List<GetItemNameModelData> _itemsList = [];
  List<GetItemNameModelData> get getItemsList => _itemsList;
  List<String> _itemsNames =
      []; //un used for now , to list just item names without other details
  List<String> get itemsNames => _itemsNames;
  // final String selectedDepartment = LocalStorageManager.getString(StorageKeys.selectedDepartmentCounter) ;
  Future<void> fetchItems(
      {required String itemname, required String department}) async {
    _itemsList.clear();
    final client = await DioUtilAuthorized.createApiClient();
    try {
      _isLoading = true;
      notifyListeners();
      final response = await client.getItemName(department, itemname);
      _itemsList.addAll(response.data ?? []);
      _itemsNames = _itemsList.map((item) => item.productName ?? '').toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      log("exception : $e");
    }
  }

  //fetch if there is enough quantity of items left for user item entry
  Future<void> qtyValidation({
    required int qty,
    required int productid,
    required String location,
    required bool isPckg, //send isPckg as String
  }) async {
    final client = await DioUtilAuthorized.createApiClient();
    try {
      final response = await client.getQtyValidation(
          qty, productid, location, "$isPckg"); //general response
      if (response.status == 200) {
        //quantity valid
        showSnackBarNoContext(isError: false, msg: response.message);
      } else if (response.status == 206) {
        showSnackBarNoContext(
            isError: true, msg: "Check if all values are passed");
        log("Quantity validation error-206, passed values can be null , passed values are $isPckg,$location,$productid,$qty");
      } else if (response.status == 300) {
        //quantity greater than current stock
        showSnackBarNoContext(isError: true, msg: response.message);
      } else {
        log("some error occured status code : ${response.status} message: ${response.message}");
      }
    } catch (e) {
      log("Exception at quality validation $e");
    }
  }
}
