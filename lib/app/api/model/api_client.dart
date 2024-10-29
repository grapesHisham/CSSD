
import 'package:cssd/app/api/model/api_links.dart';
import 'package:cssd/app/modules/login_module/model/pre_login_authentication_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST(ApiLinks.preLoginAuth)
  Future<PreLoginAuthenticationModel> submitPhoneForHospitalIds(
     @Query("PhoneNumber") String phoneNumber);
  
}