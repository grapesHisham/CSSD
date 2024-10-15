import 'package:cssd/util/colors.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonLabel;
  final Color buttonColor;
  final Function() onPressed;
  final double? buttonTextSize;
  final EdgeInsetsGeometry? buttonPadding;
  final Size? buttonSize;
  final double borderRadius;
  const ButtonWidget(
      {super.key,
      required this.buttonLabel,
      required this.onPressed,
      this.buttonColor = StaticColors.defaultButton,
      this.buttonTextSize = 20,
      this.borderRadius = 20,
      this.buttonPadding,
      this.buttonSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: buttonSize,
            padding: buttonPadding,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
            elevation: 5,
            backgroundColor: buttonColor),
        onPressed: onPressed,
        child: Text(
          textAlign: TextAlign.center,
          buttonLabel,
          style: TextStyle(
              color: StaticColors.textwhiteLight, fontSize: buttonTextSize),
        ));
  }
}
