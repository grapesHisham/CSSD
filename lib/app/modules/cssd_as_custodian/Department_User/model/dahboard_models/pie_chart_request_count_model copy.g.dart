// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pie_chart_request_count_model copy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRequestedCountModelCopy _$GetRequestedCountModelCopyFromJson(
        Map<String, dynamic> json) =>
    GetRequestedCountModelCopy(
      status: (json['status'] as num).toInt(),
      messgae: json['messgae'] as String,
      data: (json['data'] as num).toInt(),
    );

Map<String, dynamic> _$GetRequestedCountModelCopyToJson(
        GetRequestedCountModelCopy instance) =>
    <String, dynamic>{
      'status': instance.status,
      'messgae': instance.messgae,
      'data': instance.data,
    };
