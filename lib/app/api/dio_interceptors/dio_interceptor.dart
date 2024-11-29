import 'dart:developer';
import 'dart:io';

import 'package:cssd/app/api/model/api_client.dart';
import 'package:cssd/app/api/model/api_links.dart';
import 'package:cssd/util/app_util.dart';
import 'package:cssd/util/local_storage_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:dio/dio.dart';

class DioUtilAuthorized {
  DioUtilAuthorized._internal();
  static Future<ApiClient> createApiClient() async {
    String baseUrl = "${ApiLinks.baseIp}${ApiLinks.baseurl}";

    try {
      final dioClient = Dio(
        BaseOptions(
          contentType: "application/json",
          receiveDataWhenStatusError: true,
          connectTimeout: const Duration(milliseconds: 10000),
        ),
      );

      // Add Pretty Dio Logger
      dioClient.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          compact: true,
          maxWidth: 90,
        ),
      );

      // Custom Interceptor for Authorization
      dioClient.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            options.headers['accept'] = "*/*";
            String? token =
                LocalStorageManager.getString(StorageKeys.loginToken);
                log("Token is : Bearer $token");
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            } else {
              log("Admin token not received");
            }
            return handler.next(options); // Continue with the request
          },
          onError: (error, handler) async {
            if (error.response?.statusCode == 401) {
              log('Authorization failed: ${error.response?.statusCode}');
              showSnackBarNoContext(
                  isError: true, msg: "Please RELOGIN, authorization failed.");
            } else if (error.response?.statusCode == 206) {
              showSnackBarNoContext(
                  isError: true, msg: "Partial Data error, status 206");
            }
            if (error.type == DioExceptionType.connectionError ||
                error.type == DioExceptionType.connectionTimeout || error.error is SocketException) {
              log('Connection error or timeout');
              // Show Snackbar with connection error message
              showSnackBarNoContext(
                  isError: true,
                  msg: "No internet connection. Please check your network.");
            } else if (error.error == 'No internet connection') {
              log('No internet connection');
            } else {
              log('Server error: ${error.requestOptions.uri}');
              showSnackBarNoContext(isError: true, msg: "Something went wrong");
            }

            log('Error: ${error.toString()}');
            return handler.next(error); // Continue with the error handling
          },
        ),
      );

      final client = ApiClient(dioClient, baseUrl: baseUrl);
      return client;
    } catch (error) {
      log("Error creating Dio client: $error");
      rethrow;
    }
  }
}

/* class AdminTokenInterceptor extends Interceptor {
  final Dio dio;
  AdminTokenInterceptor(this.dio);

  String? adminToken;

  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    adminToken = LocalStorageManager.getString(StorageKeys.loginToken);
    if (adminToken != null) {
      options.headers['Authorization'] = 'Bearer $adminToken';
    } else {
      log("admin token not received");
    }
    super.onRequest(options, handler);
  }
} */

// /* class DioUtilAuthorized {
//   DioUtilAuthorized._internal();
//   static Future<ApiClient> createApiClient() async {
//     String baseUrl = "${ApiLinks.baseIp}${ApiLinks.baseurl}";

//     ///  print("Constructed URL: $baseUrl${ApiLinks.preloginAuthentication}");

//     try {
//       final dioClient = Dio(
//         BaseOptions(
//           contentType: "application/json",
//           receiveDataWhenStatusError: true,
//           connectTimeout: const Duration(milliseconds: 10000),
//         ),
//       );
//       dioClient.interceptors
//           .add(InterceptorsWrapper(onRequest: (options, handler) async {
//         // bool hasConnection = await InternetConnectionChecker().hasConnection;
//         // if (!hasConnection) {
//         //   AppMessage.showMessage(
//         //     text: 'No internet connection. Please check your connection.',
//         //     backgroundColor: AppColors.appRed,
//         //   );
//         //   MyAppRoute.router.pushNamed(MyAppConstants.internetView);
//         //   return handler.reject(DioException(
//         //     requestOptions: options,
//         //     error: 'No internet connection',
//         //     type: DioExceptionType.unknown,
//         //   ));
//         // }

//         options.headers['accept'] = "*/*";
//         final data =  LocalStorageManager.getString(StorageKeys.loginToken);
//         String? token = data;
//         log('$token');
//         options.headers['Authorization'] = 'Bearer $token';
//         log('Data--: ${options.data}');

//         return handler.next(options);
//       }, onError: (error, handler) async {
//         if (error.response?.statusCode == 401) {
//           // await AuthServiceSingleton.deleteData();
//           // AppMessage.showMessage(
//           //   text: 'Authorization failed, please relogin',
//           // );
//           // MyAppRoute.router.goNamed(MyAppConstants.appFlashScreen);
//         } else if (error.type == DioExceptionType.connectionTimeout) {
//           // AppMessage.showMessage(
//           //   text: 'Connection timed out. Please try again.',
//           //   backgroundColor: AppColors.appRed,
//           // );
//         } else if (error.error == 'No internet connection') {
//           // Specific handling for no internet connection error

//           // AppMessage.showMessage(
//           //   text: 'Oops! No internet connection. Please check your connection.',
//           //   backgroundColor: AppColors.appRed,
//           // );
//         } else {
//           log('${error.requestOptions.uri}');
//           // AppMessage.showMessage(
//           //   text: 'Server failed: ${error.response?.statusCode}',
//           // );
//         }
//         log(error.toString());
//         log(error.toString());
//       }));
//       final client = ApiClient(dioClient, baseUrl: baseUrl);
//       return client;
//     } catch (error) {
//       log("Error creating Dio client: $error");
//       rethrow; // Rethrow for further handling
//     }
//   }
// } */




