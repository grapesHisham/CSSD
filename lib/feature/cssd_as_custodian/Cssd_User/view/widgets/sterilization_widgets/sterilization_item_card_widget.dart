import 'package:cssd/Widgets/custom_textfield.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/view/widgets/sterilization_widgets/sterilization_delete_button.dart';
import 'package:cssd/util/hex_to_color_with_opacity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SterilizationItemsCardWidget extends StatelessWidget {
  const SterilizationItemsCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: hexToColorWithOpacity(hexColor: "EBF9FF"),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Item name : Item name"),
                    Text("Item ID : 45 "),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    width: 30.w,
                    child: Text("Department name: Operation theator"),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          CustomTextFormField(
                            borderRadius: BorderRadius.circular(5),
                            textFieldSize: Size(0.35.sw, 20),
                            textfieldBorder: true,
                            label: FittedBox(
                              child: Text(
                                'Enter batch no.',
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 9.0.h,
                          ),
                          CustomTextFormField(
                            borderRadius: BorderRadius.circular(5),
                            textFieldSize: Size(0.35.sw, 20),
                            textfieldBorder: true,
                            label: FittedBox(
                              child: Text(
                                'Enter quantity',
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.0.w,
                      ),
                      Flexible(
                        flex: 1,
                        child: FittedBox(child: DeleteButton())),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5.0.h,
            ),
          ],
        ),
      ),
    );
  }
}