import 'dart:developer';

import 'package:cssd/app/api/dio_interceptors/dio_interceptor.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/sterilization_models/department_list_model.dart';
import 'package:flutter/material.dart';

class DashboardControllerCssdCussDeptUser extends ChangeNotifier {
  DashboardControllerCssdCussDeptUser() {
    departmentDropdownFunction();
  }
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _selectedDepartment;
  String? get getSelectedDepartment => _selectedDepartment;
  set selectedDepartment(String? value) {
    if (value != null) {
      _selectedDepartment = value;
      notifyListeners();
    }
  }

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
}
