import 'dart:developer';
import 'package:cssd/app/api/dio_interceptors/dio_interceptor.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/send_for_sterilization_models/get_used_items_for_search.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/send_for_sterilization_models/post_send_to_cssd_model.dart';
import 'package:cssd/util/app_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SterilizationControllerCssdCussDeptUser extends ChangeNotifier {
  SterilizationControllerCssdCussDeptUser() {
    log("send to cssd added items list init state : $_getUsedItemsListForSearch");
  }

  @override
  void dispose() {
    quantityController.dispose();
    remarksController.dispose();
    super.dispose();
  }

  String _priority = "Medium";
  String get getPriority => _priority;
  void setPriority(String priority) {
    _priority = priority;
    notifyListeners();
  }

  TextEditingController remarksController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  // TextEditingController itemNameController = TextEditingController();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Selected used item  model
  GetUsedItemsForSearchData? _selectedUsedItemModel;
  GetUsedItemsForSearchData? get getSelectedUsedItemModel =>
      _selectedUsedItemModel;
  set setSelectedItemModel(GetUsedItemsForSearchData? value) {
    _selectedUsedItemModel = value;
    notifyListeners();
  }

  // get list of items to search which are used - used items search
  List<GetUsedItemsForSearchData> _getUsedItemsListForSearch = [];
  List<GetUsedItemsForSearchData> get getUsedItemsListForSearch =>
      _getUsedItemsListForSearch;

  Future<void> fetchUsedItems(
      {required String searchQuery, required String location}) async {
    _getUsedItemsListForSearch.clear();
    final client = await DioUtilAuthorized.createApiClient();
    try {
      final response = await client.getUsedItemNamesSearch(
          searchQuery, location); //product name , location
      if (response.status == 200) {
        _getUsedItemsListForSearch.addAll(response.data);
        if (kDebugMode) {
          log("used items fetched = $_getUsedItemsListForSearch");
        }
        notifyListeners();
      } else {
        showSnackBarNoContext(isError: true, msg: "Error fetching used items");
      }
    } catch (e) {
      log("Exception caught searching used items : $e");
    }
  }

  void clearInputs() {
    //to clear the values inside the text fields - items and quantity , after adding it to gridview builder
    quantityController.clear();
    setSelectedItemModel = null;
    setPriority("");
  }

  // adding items to list view builder for adding items to send to cssd
  final List<Sendcssditem> _selectedItemsQuantityList = [];
  List<Sendcssditem> get getSelectedItemsQuantityList =>
      _selectedItemsQuantityList;
  void addItemsToGrid(GetUsedItemsForSearchData itemModel, int quantity) {
    final existingIndex = _selectedItemsQuantityList
        .indexWhere((item) => item.productname == itemModel.productName);

    if (existingIndex != -1) {
      //if item already exists
      showSnackBarNoContext(isError: true, msg: "Item already exist");
    } else {
      //if item does not already exist
      _selectedItemsQuantityList.add(Sendcssditem(
          productname: itemModel.productName,
          productId: itemModel.productId,
          qty: quantity));
      log(_selectedItemsQuantityList.toString());

      showSnackBarNoContext(
          isError: false,
          msg: "Item added  ${itemModel.productName} : $quantity");
      notifyListeners();
    }
  }

  Future<bool> sendUsedItemsToCssd(String location) async {
    final client = await DioUtilAuthorized.createApiClient();
    try {
      if (_selectedItemsQuantityList.isEmpty) {
        //dont call api if there is no items
        showSnackBarNoContext(isError: true, msg: "No Items added");
        return false;
      } else {
        final response = await client.sendToCssd(PostSendToCssd(
            location: location,
            priority: getPriority,
            remarks: remarksController.text,
            sendcssditems: _selectedItemsQuantityList));
        log("Send to cssd items : ${PostSendToCssd(location: location, priority: getPriority, remarks: remarksController.text, sendcssditems: _selectedItemsQuantityList).toJson()}");
        if (response.status == 200) {
          showSnackBarNoContext(isError: false, msg: response.message);
          _selectedItemsQuantityList.clear();
          notifyListeners();
          return true;
        } else {
          // other than 200
          showSnackBarNoContext(isError: true, msg: response.message);
        }
      }
    } catch (e) {
      log("Exception while sent to cssd $e");
      return false;
    }
    return false;
  }

  void deleteCurrentItemFromList(Sendcssditem item) {
    log("delete selected item , item = ${item.productname} ,id: ${item.productId} , qnty:  ${item.qty}");
    _selectedItemsQuantityList.remove(item);
    notifyListeners();
  }
}
