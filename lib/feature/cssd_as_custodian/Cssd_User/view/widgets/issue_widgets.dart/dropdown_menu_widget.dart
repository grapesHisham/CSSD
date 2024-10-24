import 'package:flutter/material.dart';

class CustomDropDownMenuWidget extends StatelessWidget {
  final List<DropdownMenuEntry<dynamic>> dropdownMenuEntries;
  final Function(dynamic) onSelected;
  final String label;

  const CustomDropDownMenuWidget(
      {super.key,
      required this.dropdownMenuEntries,
      required this.onSelected,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
        label: Text(label),
        inputDecorationTheme: InputDecorationTheme(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        dropdownMenuEntries: dropdownMenuEntries,
        onSelected: onSelected);
  }
}
