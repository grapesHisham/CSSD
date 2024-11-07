import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/department_list_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'department_list_model.g.dart';

@JsonSerializable()
class DepartmentListModel {
  int? status;
  String? message;
  List<DepartmentListData>? data;

  DepartmentListModel({this.status, this.message, this.data});

  // DepartmentListModel.fromJson(Map<String, dynamic> json) {
  //   status = json['status'];
  //   message = json['message'];
  //   if (json['data'] != null) {
  //     data = <DepartmentListData>[];
  //     json['data'].forEach((v) {
  //       data!.add(new DepartmentListData.fromJson(v));
  //     });
  //   }
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   data['message'] = this.message;
  //   if (this.data != null) {
  //     data['data'] = this.data!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }

  factory DepartmentListModel.fromJson(Map<String, dynamic> json) =>
      _$DepartmentListModelFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentListModelToJson(this);
}
