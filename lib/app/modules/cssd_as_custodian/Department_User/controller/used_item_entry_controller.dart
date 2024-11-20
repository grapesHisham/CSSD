import 'package:flutter/material.dart';

class UsedItemEntryController extends ChangeNotifier{

  TextEditingController quantityController = TextEditingController();

  String _selectedItem ="";
  String get getSelectedItem => _selectedItem;
  set setSelectedItem(String value){
    _selectedItem = value;
    notifyListeners();
  }

}