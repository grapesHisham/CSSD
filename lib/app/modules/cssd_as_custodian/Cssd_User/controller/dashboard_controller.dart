import 'dart:developer';
import 'package:flutter/foundation.dart';

class DashboardController extends ChangeNotifier {
  //admin previlege - checks if user has both privilege for cssd login and department login
  bool _adminPrivilege = true;

  // dashboard tabbar selection
  int _selectedTabbarIndex = 0;

  int get selectedTabbarIndex => _selectedTabbarIndex;
  bool get adminPrivilege => _adminPrivilege;


  void  setAdminPrivilege(bool privilege) {
    if (_adminPrivilege != privilege) {
      _adminPrivilege = privilege;
      notifyListeners();
    }
  }


  void updateSelectedIndex(int index) {
    _selectedTabbarIndex = index;
    notifyListeners();
    if (kDebugMode) {
      log("Selected tab bar index : $_selectedTabbarIndex ");
    }
  }

  //update bottom nav bar index

  int _selectedIndexBotomNav = 0;

  int get selectedIndexBotomNav => _selectedIndexBotomNav;

  void updateBottomNav(int index) {
    _selectedIndexBotomNav = index;
    notifyListeners();
    if (kDebugMode) {
      log("Selected bottom navigation bar index : $_selectedIndexBotomNav");
    }
  }
}
