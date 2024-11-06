import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:flutter/material.dart';

class DashboardViewCssdCussDeptUser extends StatelessWidget {
  const DashboardViewCssdCussDeptUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ButtonWidget(
            buttonLabel: "Sterilization request",
            onPressed: () {
              Navigator.pushNamed(
                  context, Routes.sterilizationRequestViewCssdCussDeptUser);
            },
          ),
          const Text("Department Login"),
        ],
      ),
    );
  }
}
