import 'package:json_annotation/json_annotation.dart';

part 'post_send_to_cssd_model.g.dart';
@JsonSerializable()
class SendToCssd {
    @JsonKey(name: "location")
    String location;
    @JsonKey(name: "sendcssditems")
    List<Sendcssditem> sendcssditems;

    SendToCssd({
        required this.location,
        required this.sendcssditems,
    });

    factory SendToCssd.fromJson(Map<String, dynamic> json) => _$SendToCssdFromJson(json);

    Map<String, dynamic> toJson() => _$SendToCssdToJson(this);
}

@JsonSerializable()
class Sendcssditem {
    @JsonKey(name: "Productname")
    String productname;
    @JsonKey(name: "ProductId")
    int productId;
    @JsonKey(name: "Qty")
    int qty;

    Sendcssditem({
        required this.productname,
        required this.productId,
        required this.qty,
    });

    factory Sendcssditem.fromJson(Map<String, dynamic> json) => _$SendcssditemFromJson(json);

    Map<String, dynamic> toJson() => _$SendcssditemToJson(this);
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