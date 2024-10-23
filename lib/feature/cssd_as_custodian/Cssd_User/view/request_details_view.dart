import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/endDrawer.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:flutter/material.dart';

class RequestDetailsViewCssdCussCssLogin extends StatelessWidget {
  const RequestDetailsViewCssdCussCssLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StaticColors.scaffoldBackgroundcolor,
      endDrawer: endDrawer(),
      appBar: AppBar(
        title: Text('Requests Details', style: FontStyles.appBarTitleStyle),
        automaticallyImplyLeading: false,
        actions: [
          ButtonWidget(
            buttonLabel: "Timeline",
            onPressed: () {},
          )
        ],
      ),
      body: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: Colors.white),
          child: const Text("No data")),
    );
  }
}
