import 'dart:developer';

import 'package:cssd/util/local_storage_manager.dart';
import 'package:dio/dio.dart';

class AdminTokenInterceptor extends Interceptor {
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
}
