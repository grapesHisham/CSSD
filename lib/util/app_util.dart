import 'package:cssd/app/api/model/api_client.dart';
import 'package:cssd/app/api/model/api_links.dart';
import 'package:dio/dio.dart';

class AppUtil {

  //api client
  static Future<ApiClient> createApiClient() async {
    String baseUrl = ApiLinks.baseIp;

    Dio dioclient = Dio(BaseOptions(contentType: "application/json"));

    final client = ApiClient(dioclient, baseUrl: baseUrl);
    return client;
  }

  
}
