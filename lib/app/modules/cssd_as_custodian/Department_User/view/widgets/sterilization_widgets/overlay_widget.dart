
/* This widget is to show suggestions while entering text on items textfield- !working */

import 'dart:developer';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/controller/sterilization_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

OverlayEntry? overlayEntry;

void showOverlay(BuildContext context, List<String> listOfItmes) {
  final sterilizationController =
      Provider.of<SterilizationControllerCssdCussDeptUser>(context,
          listen: false);
  final renderBox = context.findRenderObject() as RenderBox;
  final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
  final position = renderBox.localToGlobal(Offset.zero, ancestor: overlay);
  log("Show overlay invoked");
  overlayEntry?.remove();
  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      left: position.dx,
      top: position.dy + renderBox.size.height,
      width: renderBox.size.width,
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(10),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 150),
          child: ListView.builder(
              itemCount: listOfItmes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(listOfItmes[index]),
                  onTap: () {
                    sterilizationController.itemNameController.text =
                        listOfItmes[index];
                    overlayEntry?.remove();
                  },
                );
              }),
        ),
      ),
    ),
  );
}
