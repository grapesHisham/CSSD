import 'package:cssd/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FontStyles {
  //Textsizes
  static double appBarTitleSize = 25.0.sp;

  //TextStyles
  static TextStyle appBarTitleStyle = TextStyle(
    color: StaticColors.textwhiteLight,
    fontSize: appBarTitleSize,
  );

  static TextStyle bodyPieTitleStyle = const TextStyle(
      color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold);

  static TextStyle piePercentageValueTextStyle =  TextStyle(
      color: Colors.white, fontSize: 12.0.sp, fontWeight: FontWeight.bold);

  //total stock container text
  static TextStyle totalStockContainerTextStyle = const TextStyle(
      color: StaticColors.totalStockContainerStockText,
      fontSize: 36,
      fontWeight: FontWeight.bold);

  //todays sterilization font
  static TextStyle todaysSterilizationText = const TextStyle(
      color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold);

  static TextStyle todaysSterilizationCount =
       TextStyle(fontSize: 10.sp, color: Colors.black);
}
