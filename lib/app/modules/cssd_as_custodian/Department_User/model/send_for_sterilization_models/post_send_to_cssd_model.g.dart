// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_send_to_cssd_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendToCssd _$SendToCssdFromJson(Map<String, dynamic> json) => SendToCssd(
      location: json['location'] as String,
      sendcssditems: (json['sendcssditems'] as List<dynamic>)
          .map((e) => Sendcssditem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SendToCssdToJson(SendToCssd instance) =>
    <String, dynamic>{
      'location': instance.location,
      'sendcssditems': instance.sendcssditems,
    };

Sendcssditem _$SendcssditemFromJson(Map<String, dynamic> json) => Sendcssditem(
      productname: json['Productname'] as String,
      productId: (json['ProductId'] as num).toInt(),
      qty: (json['Qty'] as num).toInt(),
    );

Map<String, dynamic> _$SendcssditemToJson(Sendcssditem instance) =>
    <String, dynamic>{
      'Productname': instance.productname,
      'ProductId': instance.productId,
      'Qty': instance.qty,
    };
