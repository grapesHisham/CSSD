import 'dart:developer';
import 'package:cssd/app/api/dio_interceptors/dio_interceptor.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/send_for_sterilization_models/department_list_model.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/send_for_sterilization_models/get_used_items_for_search.dart';
import 'package:cssd/util/app_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SterilizationControllerCssdCussDeptUser extends ChangeNotifier {
  SterilizationControllerCssdCussDeptUser();

  TextEditingController remarksController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  // TextEditingController itemNameController = TextEditingController();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //list of map for items and its quantity to display on gridview builder while adding items
  final List<Map<String, dynamic>> _selectedItemsQuantity = [];
  List<Map<String, dynamic>> get getSelectedItemsQuantity =>
      _selectedItemsQuantity;

  // 
 GetUsedItemsForSearchData? _selectedUsedItemModel;
  GetUsedItemsForSearchData? get getSelectedUsedItemModel => _selectedUsedItemModel;
  set setSelectedItemModel(GetUsedItemsForSearchData? value) {
    _selectedUsedItemModel = value;
    notifyListeners();
  }

  // get list of items to search which are used - used items search
  List<GetUsedItemsForSearchData> _getUsedItemsListForSearch = [];
  List<GetUsedItemsForSearchData> get getUsedItemsListForSearch =>
      _getUsedItemsListForSearch;

  Future<void> fetchUsedItems({required String searchQuery, required String location}) async {
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
  }

  void addItemsToGrid(String itemName, String quantity) {
    // adding items to list of map
    _selectedItemsQuantity.add({"itemName": itemName, "quantity": quantity});
    log(_selectedItemsQuantity.toString());
    notifyListeners();
  }

  void deleteCurrentItemFromList(Map<String, dynamic> item) {
    _selectedItemsQuantity.remove(item);
    notifyListeners();
  }
}
