import 'dart:io';

import 'package:chain_app/tools/de_info.dart';
import 'package:chain_app/tools/services/app_config.dart';
import 'package:dio/dio.dart';

class WServices {
  Dio _dio;

  static WServices get instance => _getInstance();

  static WServices _instance;

  WServices._internal() {
    if (_dio == null) {
      _dio = Dio(BaseOptions(
        baseUrl: AppConfig.baseUrl,
        headers: {HttpHeaders.contentTypeHeader: ContentType.json},
      ));
      _dio.interceptors
          .add(LogInterceptor(responseBody: true, responseHeader: false));
    }
  }

  static WServices _getInstance() {
    if (_instance == null) {
      _instance = WServices._internal();
    }
    return _instance;
  }

  static Future<Response> post(String uri,
      {Map<String, dynamic> parameter = const {}}) {
    Dio dio = instance._dio;
    return dio.post(uri, data: parameter, cancelToken: CancelToken());
  }

  static Future<Response> get(String uri,
      {Map<String, dynamic> parameter = const {}}) {
    Dio dio = instance._dio;
    return dio.get(uri, queryParameters: parameter, cancelToken: CancelToken());
  }

  static Future<Response> postForm(String uri, {FormData parameter}) {
    Dio dio = instance._dio;
    return dio.post(uri, data: parameter, cancelToken: CancelToken());
  }

  static void postR(String uri,
      {Map<String, dynamic> parameter = const {},
      ResponseCallback2 callback2}) async {
    post(uri, parameter: parameter).then((value) {
      callback2(value.statusCode, value.data);
    }).catchError((DioError onError) {
      DEInfo info = DEInfo.info(onError);
      callback2(info.code, info.message);
    });
  }

  static void getR(String uri,
      {Map<String, dynamic> parameter = const {},
      ResponseCallback2 callback2}) {
    get(uri, parameter: parameter).then((value) {
      callback2(value.statusCode, value.data);
    }).catchError((onError) {
      DEInfo info = DEInfo.info(onError);
      callback2(info.code, info.message);
    });
  }

  static void postFormR(String uri,
      {FormData parameter, ResponseCallback2 callback2}) {
    postForm(uri, parameter: parameter)
        .then((value) => callback2(value.statusCode, value.data))
        .catchError((onError) {
      DEInfo info = DEInfo.info(onError);
      callback2(info.code, info.message);
    });
  }
}
