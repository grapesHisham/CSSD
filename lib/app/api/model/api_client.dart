import 'package:cssd/app/api/model/api_links.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/dahboard_models/get_request_details_model.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/dahboard_models/pie_chart_request_count_model.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/dahboard_models/pie_dept_stock_model.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/send_for_sterilization_models/department_list_model.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/send_for_sterilization_models/get_used_items_for_search.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/used_item_model/items_list_model.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/used_item_model/get_quantity_validation_model.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/used_item_model/post_used_items_body_model.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/used_item_model/used_items_model.dart';
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
  Future<GetRequestCountModel> getRequestedCount(
      @Query("department") String department);

  @GET(ApiLinks.getPendingRequestCount) //piechart
  Future<GetRequestCountModel> getPendingRequestCount(
      @Query("department") String department);

  @GET(ApiLinks.getRequestDetails)
  Future<GetRequestDetailsModel> getRequestDetails(
      @Query("department") String department);

  @GET(ApiLinks.getPendingRequestdetails)
  Future<GetRequestDetailsModel> getPendingRequestdetails(
      @Query("department") String department);

  @GET(ApiLinks.getDepartmentwiseStockDetails)
  Future<GetDepartmentwiseStockDetailsModel> getDepartmentwiseStockDetails(
      @Query("department") String department);

  @GET(ApiLinks.qtyValidation) //general response
  Future<GetQtyValidationModel> getQtyValidation(
      @Query("Qty") int qty,
      @Query("Productid") int productid,
      @Query("location") String location,
      @Query("IsPckg") String isPckg);

  @POST(ApiLinks.usedItemEntry)
  Future<GetDepartmentwiseUsedItemListModel> postUsedItemsEntry(
      @Body() PostUsedItemsEntryModel body);

  @POST(ApiLinks.getUsedItemNames)
  Future<GetUsedItemsForSearchModel> getUsedItemNamesSearch(
      @Query("productname") String productname,
      @Query("location") String location);

    /* @POST(ApiLinks.sendToCssd)
  Future<> sendToCssd(
      @Body() PostSendToCssd body); */
  
}
