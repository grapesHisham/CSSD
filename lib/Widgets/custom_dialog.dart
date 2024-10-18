import 'package:flutter/material.dart';

/*usage 
 CustomDialog(
   dialogContext: context,
    dialogShowDefaultActions: false,
     dialogTitle: const Text("data"),
     dialogActions: [
     ButtonWidget(
        borderRadius: 10,
        buttonLabel: "hai",
        onPressed: () {},
      )
    ]);

*/

@override
Future<void> customDialog({
  required BuildContext dialogContext,
  required Widget dialogTitle,
  List<Widget>? dialogActions,
  bool dialogShowDefaultActions = true,
  void Function()? onCancelDefaultAction,
  void Function()? onAcceptDefaultAction,
}) async {
  return showDialog(
    
      context: dialogContext,
      builder: (context) {
        return AlertDialog(
          
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: dialogTitle,
          actions: dialogShowDefaultActions
              ? _defaultActions(
                  context,
                  onCancelDefaultAction: onCancelDefaultAction,
                  onAcceptDefaultAction: onAcceptDefaultAction,
                )
              : dialogActions,
        );
      });
}

List<Widget> _defaultActions(
  BuildContext context, {
  void Function()? onCancelDefaultAction,
  void Function()? onAcceptDefaultAction,
}) {
  return [
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        // Navigator.of(context).pop(false);
        onCancelDefaultAction;
      },
      child: const Text(
        'Cancel',
        style: TextStyle(color: Colors.white),
      ),
    ),
    ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text("Ok", style: TextStyle(color: Colors.white)),
        onPressed: () {
          onAcceptDefaultAction;
        }),
  ];
}
