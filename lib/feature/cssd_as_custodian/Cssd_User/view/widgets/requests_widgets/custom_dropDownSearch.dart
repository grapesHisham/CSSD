import 'package:cssd/feature/cssd_as_custodian/Cssd_User/provider/request_controler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class dropDownWithSearchFiltering extends StatelessWidget {
  const dropDownWithSearchFiltering({
    super.key,
    required this.mediaQuery,
    required this.requestControler,
  });

  final Size mediaQuery;
  final RequestControler requestControler;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mediaQuery.width * 0.40,
      child: Container(
        //textfield and dropdown menu combined
        padding: const EdgeInsets.symmetric(
            horizontal: 8.0, vertical: 3.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: const BorderRadius.all(
                Radius.circular(15))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IntrinsicWidth(
              child: TextFormField(
                readOnly: false,
                controller: requestControler
                    .requestedUserTextController,
                onChanged: (changeTextValue) {
                  requestControler
                      .filterUsers(changeTextValue);
                  //to show dropdown
                  requestControler.updateShowDropdown(true);
                },
                onFieldSubmitted: (value) {
                  requestControler
                      .updateShowDropdown(false);
                  if (requestControler
                      .filteredRequestedUsers.isNotEmpty) {
                    showMenu(
                      context: context,
                      position: const RelativeRect.fromLTRB(
                          1, 320, 100, 100),
                      items: requestControler
                          .filteredRequestedUsers
                          .map((String user) {
                        return PopupMenuItem<String>(
                          value: user,
                          child: Text(user),
                        );
                      }).toList(),
                    ).then((value) {
                      if (value != null) {
                        requestControler
                            .updateSelectedUser(value);
                        requestControler
                            .requestedUserTextController
                            .text = value;
                      }
                    });
                  }
                },
                decoration: InputDecoration(
                  constraints: BoxConstraints(
                      maxWidth: mediaQuery.width * 0.25),
                  border: InputBorder.none,
                  hintText: 'Enter to search',
                  label: const Text("Requested User"),
                  hintStyle: TextStyle(
                      color: Colors.grey.shade300),
                ),
              ),
            ),
            Consumer<RequestControler>(builder:
                (context, requestControler, child) {
              return DropdownButtonHideUnderline(
                child: SizedBox(
                  width: 24,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    isDense: true,
                    iconDisabledColor: Colors.red,
                    menuWidth: 130.w,
                    // menuMaxHeight: 200.h,
                    items: requestControler
                        .filteredRequestedUsers
                        .map((String user) {
                      return DropdownMenuItem<String>(
                        value: user,
                        child: Text(user),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      // if (value != null) {
                      //   requestControler.requestedUserTextController.text =
                      //       value;
                      // }
    
                      requestControler.updateSelectedUser(
                          value); // set selected user
                      requestControler
                          .requestedUserTextController
                          .text = value ?? '';
                    },
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}