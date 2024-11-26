import 'package:json_annotation/json_annotation.dart';

part 'post_send_to_cssd_model.g.dart';
@JsonSerializable()
class PostSendToCssd {
    @JsonKey(name: "status")
    int status;
    @JsonKey(name: "message")
    String message;
    @JsonKey(name: "data")
    List<PostSendToCssdData> data;

    PostSendToCssd({
        required this.status,
        required this.message,
        required this.data,
    });

    factory PostSendToCssd.fromJson(Map<String, dynamic> json) => _$PostSendToCssdFromJson(json);

    Map<String, dynamic> toJson() => _$PostSendToCssdToJson(this);
}

@JsonSerializable()
class PostSendToCssdData {
    @JsonKey(name: "ProductName")
    String productName;
    @JsonKey(name: "UprodId")
    int uprodId;
    @JsonKey(name: "ProductId")
    int productId;
    @JsonKey(name: "UsedQty")
    int usedQty;

    PostSendToCssdData({
        required this.productName,
        required this.uprodId,
        required this.productId,
        required this.usedQty,
    });

    factory PostSendToCssdData.fromJson(Map<String, dynamic> json) => _$PostSendToCssdDataFromJson(json);

    Map<String, dynamic> toJson() => _$PostSendToCssdDataToJson(this);
}


/* 
{
  "location": "string",
  "sendcssditems": [
    {
      "Productname": "string",
      "ProductId": 0,
      "Qty": 0
    }
  ]
} */