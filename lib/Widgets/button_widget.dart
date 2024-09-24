import 'package:cssd/util/colors.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonLabel;
  final Function() onPressed;
  const ButtonWidget(
      {super.key, required this.buttonLabel, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 8, backgroundColor: StaticColors.buttonPurple1),
        onPressed: onPressed,
        child: Text(
          buttonLabel,
          style:
              const TextStyle(color: StaticColors.textwhiteLight, fontSize: 20),
        ));
  }
}
