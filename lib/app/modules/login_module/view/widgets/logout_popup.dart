import 'package:cssd/Widgets/custom_dialog.dart';
import 'package:cssd/util/app_util.dart';
import 'package:flutter/material.dart';

Future<void> logoutPopup(BuildContext context) async {
  return customDialog(
      dialogContext: context,
      dialogContent: const Text("Are you sure to logout?"),
      dialogShowDefaultActions: true,
      defaultAcceptText: "Logout",
      defaultCancelText: "Cancel",
      onAcceptDefaultAction: () {
        // create the logout function here
        // clear the local storage on logout
        
        Navigator.pop(context);
        showSnackBar(context, "Error", "Logged out");
      },
      onCancelDefaultAction: () {
        Navigator.pop(context);
      },
      );
}
