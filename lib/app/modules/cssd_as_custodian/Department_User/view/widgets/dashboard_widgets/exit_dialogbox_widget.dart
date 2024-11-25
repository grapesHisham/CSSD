import 'dart:io';

import 'package:cssd/Widgets/custom_dialog.dart';
import 'package:flutter/material.dart';

Future<void> exitDialogBox(BuildContext context) async {
  return customDialog(
    dialogContext: context,
    dialogContent: const Text("Are you sure to exit?"),
    onAcceptDefaultAction: () {
      exit(0);
    },
    onCancelDefaultAction: () {
      Navigator.pop(context);
    },
  );
}
