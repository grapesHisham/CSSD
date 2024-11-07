import 'package:json_annotation/json_annotation.dart';

part 'department_list_data.g.dart';

@JsonSerializable()
class DepartmentListData {
  String? subID;
  String? subName;

  DepartmentListData({this.subID, this.subName});

  // DepartmentListData.fromJson(Map<String, dynamic> json) {
  //   subID = json['Sub_ID'];
  //   subName = json['SubName'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['Sub_ID'] = this.subID;
  //   data['SubName'] = this.subName;
  //   return data;
  // }

  factory DepartmentListData.fromJson(Map<String, dynamic> json) =>
      _$DepartmentListDataFromJson(json);
  Map<String, dynamic> toJson() => _$DepartmentListDataToJson(this);
}
