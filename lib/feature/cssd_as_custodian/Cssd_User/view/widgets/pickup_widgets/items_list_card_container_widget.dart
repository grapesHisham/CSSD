import 'package:cssd/Widgets/rounded_container.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/model/sampleBatchNoQuantity.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/model/sampleRequestList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemsListCardContainerWidget extends StatelessWidget {
  const ItemsListCardContainerWidget({
    super.key,
    required this.mediaQuery,
  });

  final Size mediaQuery;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      containerHeight: mediaQuery.height * 0.30,
        containerBody: Scrollbar(
      child: ListView.builder(
        itemCount: sampleHighPriorityRequestsList.length,
        itemBuilder: (context, index) {
          final request = sampleHighPriorityRequestsList[index];
          final quantity =
              SamplebBatchNo().sampleQuantityList[index];
          final batch = SamplebBatchNo().sampleBatchNo[index];
          return Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Checkbox(
                    value: true,
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  flex: 6,
                  child: Text(request.requestSubTitle),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          'Batch no. : $batch',
                        ),
                      ),
                      SizedBox(
                        height: 9.0.h,
                      ),
                      FittedBox(
                        child: Text(
                          'Quantity : $quantity',
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    ));
  }
}