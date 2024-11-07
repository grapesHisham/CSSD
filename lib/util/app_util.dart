import 'package:cssd/app/api/dio_interceptors/dio_interceptor.dart';
import 'package:cssd/app/api/model/api_client.dart';
import 'package:cssd/app/api/model/api_links.dart';
import 'package:cssd/util/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AppUtil {
  //api client
  static Future<ApiClient> createApiClient() async {
    String baseUrl = ApiLinks.baseIp;

    Dio dioclient = Dio(BaseOptions(contentType: "application/json"));

    /*if live pls comment this*/
    dioclient.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    final client = ApiClient(dioclient, baseUrl: baseUrl);
    return client;
  }

  static Future<ApiClient> createAdminTokenApiClient() async {
    String baseUrl = ApiLinks.baseIp;

    Dio dioclient = Dio(BaseOptions(contentType: "application/json"));

    dioclient.interceptors.clear();
    /*if live pls comment this*/
    dioclient.interceptors.addAll([
      AdminTokenInterceptor(dioclient),
      PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          error: true,
          compact: true,
          maxWidth: 90)
    ]);
    final client = ApiClient(dioclient, baseUrl: baseUrl);
    return client;
  }
}

showSnackBar(BuildContext c, String type, String msg) {
  return ScaffoldMessenger.of(c).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 1250),
      backgroundColor: type == "Error"
          ? StaticColors.requestContainerNumberBackground
          : const Color.fromARGB(255, 38, 80, 39),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.add_alert,
                color: Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(type == "Error" ? "Error" : type,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  )),
            ],
          ),
          Text("$msg",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ))
        ],
      )));
}

void showToast(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2), // Duration the message is visible
      behavior: SnackBarBehavior.floating, // Makes it float above other UI
      backgroundColor: Colors.black, // Background color of the snack bar
      // Text color
    ),
  );
}
