// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pie_chart_request_count_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRequestedCountModel _$GetRequestedCountModelFromJson(
        Map<String, dynamic> json) =>
    GetRequestedCountModel(
      status: (json['status'] as num).toInt(),
      messgae: json['messgae'] as String,
      data: (json['data'] as num).toInt(),
    );

Map<String, dynamic> _$GetRequestedCountModelToJson(
        GetRequestedCountModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'messgae': instance.messgae,
      'data': instance.data,
    };
