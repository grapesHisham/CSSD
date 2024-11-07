import 'dart:developer';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/department_list_model.dart';
import 'package:cssd/util/app_util.dart';
import 'package:flutter/material.dart';

class SterilizationControllerCssdCussDeptUser extends ChangeNotifier {
  SterilizationControllerCssdCussDeptUser() {
    fetchDepartments();
  }
  List<String?> departmentNames = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchDepartments() async {
    try {
      _isLoading = true;
      notifyListeners();

      final client = await AppUtil.createAdminTokenApiClient();

      DepartmentListModel response = await client.getDepartementList();
      departmentNames =
          response.data!.map((department) => department.subName).toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print("Error fetching departments: $e");
    }
  }
//   List<String?> departmentNames = [];
//   // List<DropdownMenuEntry<dynamic>> departmentDropDownEntries = [];
//   Future<void> deparmentList() async {
//     final client = await AppUtil.createAdminTokenApiClient();
//     try {
//   DepartmentListModel response = await client.getDepartementList();

//   if (response.status == 200) {
//     if (response.data != null) {
//       departmentNames =
//           response.data!.map((department) => department.subName).toList();
//       log("API response data: ${response.data}");

//     } else {
//       departmentNames = [];
//       log("Department list received is empty");
//     }
//   } else {
//     log("response other than 200");
//   }
// } on Exception catch (e) {
//   log(e.toString());
// }

//     notifyListeners();
//   }

  void callDepartmentList() {
    //if you need to refresh department list
    fetchDepartments();
    notifyListeners();
  }

  void printList(var list) {
    log("List is : $list");
  }
}
