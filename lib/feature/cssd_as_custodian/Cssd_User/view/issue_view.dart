import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/custom_textfield.dart';
import 'package:cssd/Widgets/endDrawer.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/model/sampleItemsList.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/view/widgets/issue_widgets.dart/dropdown_menu_widget.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/view/widgets/pickup_widgets/items_list_card_container_widget.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IssueViewCssdCussCssdLogin extends StatelessWidget {
  const IssueViewCssdCussCssdLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: StaticColors.scaffoldBackgroundcolor,
      endDrawer: endDrawer(),
      appBar: AppBar(
        title: Text('Issue', style: FontStyles.appBarTitleStyle),
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Wrap(
                    runSpacing: 0,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomDropDownMenuWidget(
                          dropdownMenuEntries: sampleSterilizableItemsEntries,
                          onSelected: (selectedValue) {
                            print(selectedValue);
                          },
                          label: 'Item name'),
                      SizedBox(
                        width: 10.h,
                      ),
                      SizedBox(
                        width: mediaQuery.width / 4,
                        height: 100,
                        child: const CustomTextFormField(
                          textfieldBorder: true,
                          label: Text("Quantity"),
                        ),
                      ),
                      SizedBox(
                        width: 10.h,
                      ),
                      CustomDropDownMenuWidget(
                        dropdownMenuEntries: sampleUsersDropDownEntries,
                        onSelected: (selectedValue) {
                          print(selectedValue);
                        },
                        label: 'Issued User',
                      ),
                      SizedBox(
                        width: 10.h,
                      ),
                      ButtonWidget(
                        buttonLabel: "Show",
                        onPressed: () {},
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Items for issue",
                        style: FontStyles.bodyPieTitleStyle,
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                  ItemsListCardContainerWidget(mediaQuery: mediaQuery),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonWidget(
                        buttonLabel: "Issue",
                        onPressed: () {},
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
