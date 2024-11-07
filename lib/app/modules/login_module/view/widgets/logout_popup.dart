import 'package:cssd/Widgets/custom_dialog.dart';
import 'package:cssd/app/modules/login_module/controller/login_provider.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


Future<void> logoutPopup(BuildContext context) async {
final loginController =  Provider.of<LoginController>(context, listen: false);
  
  return customDialog( 
      dialogContext: context, 
      dialogContent: const Text("Are you sure to logout?"),
      dialogShowDefaultActions: true,
      defaultAcceptText: "Logout",
      defaultCancelText: "Cancel",
      onAcceptDefaultAction: () {
        // create the logout function here
        loginController.logoutFunction();
        Navigator.pushNamedAndRemoveUntil(context, Routes.loginScreen,(route) => false );
        // clear the local storage on logout 
      },
      onCancelDefaultAction: () {
        Navigator.pop(context);
      },
      );
}
