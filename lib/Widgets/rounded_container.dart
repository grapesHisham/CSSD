import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Widget containerBody;
  final Color containerColor;

  const RoundedContainer(
      {super.key,
      required this.containerBody,
      this.containerColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.of(context).size;
    return Container(
        width: mediaQuery.width,
        margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
            border: Border.all(
                width: 1, color: const Color.fromRGBO(0, 0, 0, 0.12)),
            borderRadius: BorderRadius.circular(12),
            color: containerColor),
        child: InkWell(child: containerBody));
  }
}
