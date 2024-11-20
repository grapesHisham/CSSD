import 'dart:developer';
import 'package:cssd/app/api/model/api_client.dart';
import 'package:cssd/app/api/model/api_links.dart';
import 'package:cssd/main.dart';
import 'package:cssd/util/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/*  
   
   Size mediaQuery = MediaQuery.of(context).size; 

   Scaffold(
        backgroundColor: StaticColors.scaffoldBackgroundcolor,
        appBar: AppBar(
          title:
              Text('Sterilization Request', style: FontStyles.appBarTitleStyle),
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10.0.h, vertical: 10.0.h),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: Colors.white),
            child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisSize: MainAxisSize.max, children: [])))));
   
   */

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

  /* static Future<ApiClient> createAdminTokenApiClient() async {
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
  } */
}

showSnackBar(
    {required BuildContext context,
    required bool isError,
    required String msg,
    String? errorHead}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 1250),
      backgroundColor: isError == true
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
              Text(isError == true ? errorHead ?? "" : "Error" ,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  )),
            ],
          ),
          Text(msg,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ))
        ],
      )));
}

void showSnackBarNoContext({
  required bool isError,
  required String msg,
}) {
  final scaffoldMessenger = scaffoldMessengerKey.currentState;
  if (scaffoldMessenger != null) {
    scaffoldMessenger.showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: isError == true ? Colors.red : Colors.green,
      duration: const Duration(seconds: 3),
    ));
  } else {
    log("ScaffoldMessenger is not available.");
  }
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
