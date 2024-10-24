import 'package:cssd/Widgets/endDrawer.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimelineViewCssdCussCssdLogin extends StatelessWidget {
  const TimelineViewCssdCussCssdLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StaticColors.scaffoldBackgroundcolor,
      endDrawer: endDrawer(),
      appBar: AppBar(
        title: Text('Timeline', style: FontStyles.appBarTitleStyle),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.0.h, vertical: 10.0.h),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            color: Colors.white),
        child: SingleChildScrollView(
          child: Column(
            children: [

            ],
          ),
        )),
    );
  }
}