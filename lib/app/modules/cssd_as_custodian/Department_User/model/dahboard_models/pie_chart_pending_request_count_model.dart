import 'package:json_annotation/json_annotation.dart';

part 'pie_chart_pending_request_count_model.g.dart';
@JsonSerializable()
class GetPendingRequestModel {
    @JsonKey(name: "status")
    int status;
    @JsonKey(name: "message")
    String message;
    @JsonKey(name: "data")
    int data;

    GetPendingRequestModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetPendingRequestModel.fromJson(Map<String, dynamic> json) => _$GetPendingRequestModelFromJson(json);

    Map<String, dynamic> toJson() => _$GetPendingRequestModelToJson(this);
}
