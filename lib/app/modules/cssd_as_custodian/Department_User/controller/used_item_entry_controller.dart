import 'dart:developer';

import 'package:cssd/app/api/dio_interceptors/dio_interceptor.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/sterilization_models/items_list_model.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/used_item_model/used_items_model.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/view/widgets/dashboard_widgets/datagrid_used_item_entry_table_widget.dart';
import 'package:cssd/util/app_util.dart';
import 'package:flutter/material.dart';

class UsedItemEntryController extends ChangeNotifier {
  TextEditingController quantityController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool validateQuantity() {
    return formKey.currentState!.validate();
  }

  GetItemNameModelData? _selectedItemModel;
  GetItemNameModelData? get getSelectedItemModel => _selectedItemModel;
  set setSelectedItemModel(GetItemNameModelData value) {
    _selectedItemModel = value;
    notifyListeners();
  }

  String? _selectedItemName;
  String? get selectedItemName => _selectedItemName;
  set setSelectedItemName(String itemName) {
    _selectedItemName = itemName;
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
  bool _isQtyValid = false;
  bool get getIsQtyValid => _isQtyValid;
  set isQtyValid(bool value) {
    _isQtyValid = value;
    notifyListeners();
  }

  Future<bool> qtyValidation({
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
        _isQtyValid = true;
        return true;
      } else if (response.status == 206) {
        showSnackBarNoContext(
            isError: true, msg: "Check if all values are passed");
        log("Quantity validation error-206, passed values can be null , passed values are $isPckg,$location,$productid,$qty");
        return false;
      } else if (response.status == 300) {
        //quantity greater than current stock
        showSnackBarNoContext(isError: true, msg: response.message);
        return false;
      } else {
        log("some error occured status code : ${response.status} message: ${response.message}");
        return false;
      }
    } catch (e) {
      log("Exception at quality validation $e");
      return false;
    }
  }

  //adding items to the used items table before sending

  List<UsedItemsListModelData> _usedItemsTableBeforeSubmitList = [];
  List<UsedItemsListModelData> get  getUsedItemsTableBeforeSubmitList => _usedItemsTableBeforeSubmitList;

  List<UsedItemsListModelData> addToUsedItemsTableBeforeSubmit({
    required int productId,
    required String productName,
    required String location,
    required int uQty,
  }) {
    _usedItemsTableBeforeSubmitList.add(UsedItemsListModelData(
        productId: productId,
        productName: productName,
        location: location,
        uQty: uQty));
    notifyListeners();
    return _usedItemsTableBeforeSubmitList;
  }
}
