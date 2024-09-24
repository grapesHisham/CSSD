import 'package:cssd/util/colors.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonLabel;
  final Color buttonColor;
  final Function() onPressed;
  const ButtonWidget(
      {super.key,
      required this.buttonLabel,
      required this.onPressed,
      required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 8, backgroundColor: buttonColor),
        onPressed: onPressed,
        child: Text(
          buttonLabel,
          style:
              const TextStyle(color: StaticColors.textwhiteLight, fontSize: 20),
        ));
  }
}
