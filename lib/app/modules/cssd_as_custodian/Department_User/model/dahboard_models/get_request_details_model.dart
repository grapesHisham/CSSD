import 'package:json_annotation/json_annotation.dart';
//request details or pending request details
part 'get_request_details_model.g.dart';
@JsonSerializable()
class GetRequestDetailsModel {
    @JsonKey(name: "status")
    int status;
    @JsonKey(name: "message")
    String message;
    @JsonKey(name: "data")
    List<RequestDetailsData> data;

    GetRequestDetailsModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetRequestDetailsModel.fromJson(Map<String, dynamic> json) => _$GetRequestDetailsModelFromJson(json);

    Map<String, dynamic> toJson() => _$GetRequestDetailsModelToJson(this);
}

@JsonSerializable()
class RequestDetailsData {
    @JsonKey(name: "ReqID")
    int reqId;
    @JsonKey(name: "Sub")
    String sub;
    @JsonKey(name: "Priority")
    String priority;
    @JsonKey(name: "Remarks")
    String remarks;
    @JsonKey(name: "RTime")
    DateTime rTime;
    @JsonKey(name: "RUser")
    String rUser;
    @JsonKey(name: "TransferredUser")
    String? transferredUser;
    @JsonKey(name: "ISAccept")
    int isAccept;
    @JsonKey(name: "AcceptedUser")
    String? acceptedUser;

    RequestDetailsData({
        required this.reqId,
        required this.sub,
        required this.priority,
        required this.remarks,
        required this.rTime,
        required this.rUser,
        required this.transferredUser,
        required this.isAccept,
        required this.acceptedUser,
    });

    factory RequestDetailsData.fromJson(Map<String, dynamic> json) => _$RequestDetailsDataFromJson(json);

    Map<String, dynamic> toJson() => _$RequestDetailsDataToJson(this);
}
