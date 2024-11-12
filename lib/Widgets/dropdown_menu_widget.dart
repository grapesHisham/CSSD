import 'package:flutter/material.dart';

class CustomDropDownMenuWidget extends StatelessWidget {
  final List<DropdownMenuEntry<dynamic>> dropdownMenuEntries;
  final Function(dynamic) onSelected;
  final String label;
  final double? dropDownWidth;

  const CustomDropDownMenuWidget(
      {super.key,
      required this.dropdownMenuEntries,
      required this.onSelected,
      required this.label,
      this.dropDownWidth});

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      menuHeight: 230 ,
        width: dropDownWidth,
        label: Text(label),
        inputDecorationTheme: InputDecorationTheme(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        dropdownMenuEntries: dropdownMenuEntries,
        onSelected: onSelected);
  }
}
