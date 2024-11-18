import 'dart:developer';

import 'package:cssd/app/api/dio_interceptors/dio_interceptor.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/sterilization_models/department_list_model.dart';
import 'package:flutter/material.dart';

class DashboardControllerCssdCussDeptUser extends ChangeNotifier {
  DashboardControllerCssdCussDeptUser() {}

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _selectedDepartment;
  String? get getSelectedDepartment => _selectedDepartment;
  set selectedDepartment(String? value) {
    if (value != null) {
      _selectedDepartment = value;
      log("selected department is : $getSelectedDepartment");
      notifyListeners();
    }
  }

//department dropdown fetch
  List<GetDepartmentListModelData> _departmentDropdownItems = [];
  List<GetDepartmentListModelData> get departmentDropdownItems =>
      _departmentDropdownItems;

  Future<List<GetDepartmentListModelData>> departmentDropdownFunction() async {
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
        return _departmentDropdownItems;
      } else {
        _isLoading = false;
        log("status code !200  :  ${resposne.message}");
        return [];
      }
    } catch (e) {
      log("exception : $e");
      return [];
    }
  }

  // adding pie chart data to list of map
  final List<Map<String, dynamic>> _pieChartData = [];
  List<Map<String, dynamic>> get pieChartData => _pieChartData;
  void addToList(String label, int data) {
    // add request count or other data to
    _pieChartData.add({label: data});
    log("pie chart data list : $_pieChartData");
  }

  // fetching data for pie chart
  late int _requestCount;
  late String _requestString;
  late int _pendingCount;
  late String _pendingString;
  bool hasValidData =
      false; // if  request count = 0 & pending count is 0 4 the dept , set false to false to show lottie
  // String storedDepartment =
  //     LocalStorageManager.getString(StorageKeys.selectedDepartmentCounter)!;
  Future<void> getPieChartData(String selectedDepartment) async {
    _pieChartData.clear();
    final client = await DioUtilAuthorized.createApiClient();
    try {
      final requestCountResponse =
          await client.getRequestedCount(selectedDepartment);
      final pendingRequestCountResponse =
          await client.getPendingRequestCount(selectedDepartment);
      if (requestCountResponse.status == 200 &&
          pendingRequestCountResponse.status == 200) {
        _requestCount = requestCountResponse.data;
        _requestString = requestCountResponse.messgae;
        log("Piechart request data is label: $_requestString, value: $_requestCount");
        addToList(_requestString, _requestCount);
        _pendingCount = pendingRequestCountResponse.data;
        _pendingString = pendingRequestCountResponse.message;
        log("Piechart pending data is label: $_pendingString, value: $_pendingCount");
        addToList(_pendingString, _pendingCount);
        if (_requestCount == 0 && _pendingCount == 0) {
          hasValidData = false;
        } else {
          hasValidData = true;
        }
      }
      notifyListeners();
    } catch (e) {
      log("Error fetching pie chart data: $e");
    }
  }
}
