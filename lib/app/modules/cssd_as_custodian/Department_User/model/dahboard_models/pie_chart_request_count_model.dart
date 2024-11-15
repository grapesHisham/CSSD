import 'package:json_annotation/json_annotation.dart';

part 'pie_chart_request_count_model.g.dart';
@JsonSerializable()
class GetRequestedCountModel {
    @JsonKey(name: "status")
    int status;
    @JsonKey(name: "messgae")
    String messgae;
    @JsonKey(name: "data")
    int data;

    GetRequestedCountModel({
        required this.status,
        required this.messgae,
        required this.data,
    });

    factory GetRequestedCountModel.fromJson(Map<String, dynamic> json) => _$GetRequestedCountModelFromJson(json);

    Map<String, dynamic> toJson() => _$GetRequestedCountModelToJson(this);
}
