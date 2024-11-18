// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pie_chart_pending_request_count_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPendingRequestModel _$GetPendingRequestModelFromJson(
        Map<String, dynamic> json) =>
    GetPendingRequestModel(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as num).toInt(),
    );

Map<String, dynamic> _$GetPendingRequestModelToJson(
        GetPendingRequestModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
