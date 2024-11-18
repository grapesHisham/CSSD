import 'package:cssd/app/api/model/api_links.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/dahboard_models/get_request_details_model.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/dahboard_models/pie_chart_pending_request_count_model.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/dahboard_models/pie_chart_request_count_model.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/sterilization_models/department_list_model.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/sterilization_models/items_list_model.dart';
import 'package:cssd/app/modules/login_module/model/login_model.dart';
import 'package:cssd/app/modules/login_module/model/pre_login_authentication_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  // cssd user
  @POST(ApiLinks.preLoginAuth)
  Future<PreLoginAuthenticationModel> submitPhoneForHospitalIds(
      @Query("PhoneNumber") String phoneNumber);

  @POST(ApiLinks.login)
  Future<LoginModel> login(@Body() Map<String, dynamic> body);

  //department user
  @GET(ApiLinks.departementList)
  Future<GetDepartmentListModel> getDepartementListData();

  @GET(ApiLinks.getItemName)
  Future<GetItemNameModel> getItemName(@Query("department") String department,
      @Query("itemname") String itemname);

  @GET(ApiLinks.getRequestedCount) //piechart
  Future<GetRequestedCountModel> getRequestedCount(
      @Query("department") String department);

  @GET(ApiLinks.getPendingRequestCount) //piechart
  Future<GetPendingRequestModel> getPendingRequestCount(
      //just because there is a conflict in the item name -message which is messgae in getRequestCount
      @Query("department") String department);

  @GET(ApiLinks.getRequestDetails)
  Future<GetRequestDetailsModel> getRequestDetails(
      @Query("department") String department);
}
