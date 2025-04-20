import 'package:chat/core/api/routes.dart';
import 'package:chat/data/storage/shared_preferences_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Api {
  var headers = {
    "Content-Type": "application/json",
    'accept': '*/*',
    // 'Authorization': "Bearer $token",
  };

  Api() {
    headers['Authorization'] = "Bearer ${AuthTokenStorage.getToken()}";
    _dio.options.headers = headers;
  }

  final Dio _dio = Dio(BaseOptions(
    baseUrl: Routes.BASE_URL,
    connectTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    responseType: ResponseType.json,
  ))
    ..interceptors.add(PrettyDioLogger(enabled: kDebugMode && !kIsWeb));

  Dio get dio => _dio;
}
