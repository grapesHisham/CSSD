import 'dart:developer';
import 'package:flutter/foundation.dart';

class DashboardController extends ChangeNotifier {
  // dashboard tabbar selection
  int _selectedTabbarIndex = 0;

  int get selectedTabbarIndex => _selectedTabbarIndex;

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
