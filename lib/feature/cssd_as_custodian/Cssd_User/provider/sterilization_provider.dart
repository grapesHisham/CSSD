import 'dart:developer';

import 'package:flutter/material.dart';

class SterilizationProvider extends ChangeNotifier {
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  String? selectedMachine;

  void updateSelectedMachine(String? newMachine) {
    selectedMachine = newMachine;
    notifyListeners();
  }

  List<String> sterilizationMachines = [
    'Autoclave',
    'Ethylene Oxide Sterilizer',
    'Hydrogen Peroxide Plasma Sterilizer',
    'Dry Heat Sterilizer',
    'Low-Temperature Sterilizer',
    'Ultraviolet Sterilizer',
    'Steam Sterilizer',
  ];
}
