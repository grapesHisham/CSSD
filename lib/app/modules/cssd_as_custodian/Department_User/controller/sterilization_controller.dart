import 'dart:developer';
import 'package:cssd/app/api/dio_interceptors/dio_interceptor.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/sterilization_models/department_list_model.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/sterilization_models/items_list_model.dart';
import 'package:flutter/material.dart';

class SterilizationControllerCssdCussDeptUser extends ChangeNotifier {
  SterilizationControllerCssdCussDeptUser();

  TextEditingController remarksController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  //department dropdown fetch
  List<GetDepartmentListModelData> _departmentDropdownItems = [];
  List<GetDepartmentListModelData> get departmentDropdownItems =>
      _departmentDropdownItems;
  Future<void> departmentDropdownFunction() async {
    _departmentDropdownItems.clear();
    final client = await DioUtilAuthorized.createApiClient();
    try {
      _isLoading = true;
      notifyListeners();
      final resposne = await client.getDepartementListData();
      if (resposne.status == 200) {
        _departmentDropdownItems = resposne.data ?? [];
        _isLoading = false;

        notifyListeners();
      } else {
        _isLoading = false;
        log("status code !200  :  ${resposne.message}");
      }
    } catch (e) {
      log("exception : $e");
    }
  }

  // current selected department
  String _selectedDepartment = '';
  String get selectedDepartment => _selectedDepartment;
  set setSelectedDepartment(String value) {
    log("Currently selected department : $value");
    if (_selectedDepartment != value) {
      _selectedDepartment = value;
    }
  }

  //fetch items list for department
  final List<GetItemNameModelData> _itemsList = [];
  List<GetItemNameModelData> get itemsList => _itemsList;
   List<String> _itemsNames = [];
  List<String> get itemsNames => _itemsNames;

  Future<void> fetchItems(String itemname) async {
    _itemsList.clear();
    final client = await DioUtilAuthorized.createApiClient();
    try {
      _isLoading = true;
      notifyListeners();
      final response = await client.getItemName(_selectedDepartment, itemname);
      _itemsList.addAll(response.data ?? []);
      _itemsNames = _itemsList.map((item) => item.productName ?? '').toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      log("exception : $e");
    }
  }
}
