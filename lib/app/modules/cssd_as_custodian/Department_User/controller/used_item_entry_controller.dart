import 'dart:developer';

import 'package:cssd/app/api/dio_interceptors/dio_interceptor.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/sterilization_models/items_list_model.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/used_item_model/used_items_model.dart';
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
  set setSelectedItemModel(GetItemNameModelData? value) {
    _selectedItemModel = value;
    notifyListeners();
    log("selected item is null");
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
  List<UsedItemsListModelData> get getUsedItemsTableBeforeSubmitList =>
      _usedItemsTableBeforeSubmitList;

  //For clearing the table
  void clearusedItemsTableBeforeSubmitList() {
    _usedItemsTableBeforeSubmitList.clear();
    _listMapAddedItem.clear();
    notifyListeners();
  }

  Map<String, dynamic> mapAddedItems = {};
  List<Map<String, dynamic>> _listMapAddedItem = [];
  
  List<UsedItemsListModelData> addToUsedItemsTableBeforeSubmit(
      {required int productId,
      required String productName,
      required String location,
      required int uQty,
      required BuildContext context}) {
    final existingItemIndex = _usedItemsTableBeforeSubmitList
        .indexWhere((item) => item.productId == productId);
    if (existingItemIndex == -1) {
      // item does not exist when index returns -1
      _usedItemsTableBeforeSubmitList.add(UsedItemsListModelData(
          productId: productId,
          productName: productName,
          location: location,
          uQty: uQty));
      mapAddedItems = {
        "productId": productId,
        "location": location,
        "quantity": uQty
      };
      log("added item $mapAddedItems");
      _listMapAddedItem.add(mapAddedItems);
      log("added list $_listMapAddedItem");
    } else if (existingItemIndex != -1) {
      //when item already exists in the list
      final quantity = _usedItemsTableBeforeSubmitList[existingItemIndex].uQty;
      final bool sameQnty =
          int.parse(quantityController.text) == quantity ? true : false;
      // dialog to update the quantity if needed
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Item Already Exists"),
            content: sameQnty
                ? const Text("Item already exist with same quantity")
                : Text(
                    "Item already exists with quantity: $quantity.\nDo you want to update the quantity to ${quantityController.text}?"),
            actions: <Widget>[
              TextButton(
                child:
                    sameQnty ? /*  */ const Text("cancel") : const Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: sameQnty
                    ? const Text("ok")
                    : /* need to update */ const Text("Yes"),
                onPressed: () {
                  _usedItemsTableBeforeSubmitList[existingItemIndex].uQty =
                      uQty;
                  if (!sameQnty) {
                    showSnackBarNoContext(
                        isError: false, msg: "Item quantity updated!");
                  }

                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    notifyListeners();
    return _usedItemsTableBeforeSubmitList;
  }

  // Future<void> submitUsedItemsEntries() async {
  //   final client = await DioUtilAuthorized.createApiClient();

  //   try {
  //     log("list of map data for user items entry$_listMapAddedItem , last map $mapAddedItems" );
  //     final response = await client.postUsedItemsEntry(_listMapAddedItem);
      
  //   } catch (e) {
  //     log("Exception caught while posting used items $e");
  //   }
  // }
}
