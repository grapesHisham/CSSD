import 'dart:developer';
import 'package:cssd/app/api/dio_interceptors/dio_interceptor.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/send_for_sterilization_models/department_list_model.dart';
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

  // when searching for used items from dropdown
  String _selectedItemDropdown = "";
  String get getSelectedItemDropdown => _selectedItemDropdown;

  set setSelectedItemDropdown(String value) {
    _selectedItemDropdown = value;
    log("Selected dropdown value changed: $_selectedItemDropdown");
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
