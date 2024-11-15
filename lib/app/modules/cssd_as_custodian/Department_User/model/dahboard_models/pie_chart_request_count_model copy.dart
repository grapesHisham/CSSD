import 'package:json_annotation/json_annotation.dart';

part 'pie_chart_request_count_model copy.g.dart';
@JsonSerializable()
class GetRequestedCountModelCopy {
    @JsonKey(name: "status")
    int status;
    @JsonKey(name: "messgae")
    String messgae;
    @JsonKey(name: "data")
    int data;

    GetRequestedCountModelCopy({
        required this.status,
        required this.messgae,
        required this.data,
    });

    factory GetRequestedCountModelCopy.fromJson(Map<String, dynamic> json) => _$GetRequestedCountModelCopyFromJson(json);

    Map<String, dynamic> toJson() => _$GetRequestedCountModelCopyToJson(this);
}
