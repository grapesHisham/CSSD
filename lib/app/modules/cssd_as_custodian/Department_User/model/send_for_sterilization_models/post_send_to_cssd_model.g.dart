// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_send_to_cssd_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSendToCssd _$PostSendToCssdFromJson(Map<String, dynamic> json) =>
    PostSendToCssd(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => PostSendToCssdData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostSendToCssdToJson(PostSendToCssd instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

PostSendToCssdData _$PostSendToCssdDataFromJson(Map<String, dynamic> json) =>
    PostSendToCssdData(
      productName: json['ProductName'] as String,
      uprodId: (json['UprodId'] as num).toInt(),
      productId: (json['ProductId'] as num).toInt(),
      usedQty: (json['UsedQty'] as num).toInt(),
    );

Map<String, dynamic> _$PostSendToCssdDataToJson(PostSendToCssdData instance) =>
    <String, dynamic>{
      'ProductName': instance.productName,
      'UprodId': instance.uprodId,
      'ProductId': instance.productId,
      'UsedQty': instance.usedQty,
    };
