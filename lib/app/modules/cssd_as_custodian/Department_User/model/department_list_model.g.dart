// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartmentListModel _$DepartmentListModelFromJson(Map<String, dynamic> json) =>
    DepartmentListModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DepartmentListData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DepartmentListModelToJson(
        DepartmentListModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
