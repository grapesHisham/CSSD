import 'dart:math';

import 'package:cssd/feature/cssd_as_custodian/Cssd_User/model/sampleRequestList.dart';

class SamplebBatchNo {
  List<String> sampleBatchNo =
      List.generate(sampleHighPriorityRequestsList.length, (index) {
    final Random random = Random();
    return "${random.nextInt(2314) + 20}";
  });

  List<int> sampleQuantityList =
      List.generate(sampleHighPriorityRequestsList.length, (index) {
    final Random random = Random();
    return random.nextInt(10) + 5;
  });
}
