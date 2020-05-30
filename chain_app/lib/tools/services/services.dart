import 'dart:io';

import 'package:chain_app/tools/de_info.dart';
import 'package:chain_app/tools/global.dart';
import 'package:dio/dio.dart';

import 'app_config.dart';

class NServices {
  Dio _dio;

  factory NServices() => _getInstance();

  static NServices get instance => _getInstance();

  static NServices _instance;

  NServices._internal() {
    if (_dio == null) {
      _dio = Dio(
        BaseOptions(
          baseUrl: AppConfig.baseUrl,
          headers: {HttpHeaders.contentTypeHeader: ContentType.json},
        ),
      );
      _dio.interceptors
          .add(LogInterceptor(responseBody: true, responseHeader: false, error: true));
    }
  }

  static NServices _getInstance() {
    if (_instance == null) {
      _instance = NServices._internal();
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

  static Future<Response<T>> request<T>(
    String url, {
    Map<String, dynamic> queryParameters,
    String method = method_get,
  }) async {
    Dio dio = NServices.instance._dio;
    if (method == method_get) {
      return dio.get<T>(
        url,
        queryParameters: queryParameters,
        cancelToken: CancelToken(),
      );
    } else if (method == method_post) {
      return dio.post<T>(
        url,
        data: queryParameters,
        cancelToken: CancelToken(),
      );
    } else if (method == method_patch) {
      return dio.patch<T>(
        url,
        data: queryParameters,
        cancelToken: CancelToken(),
      );
    } else {
      return dio.put<T>(
        url,
        data: queryParameters,
        cancelToken: CancelToken(),
      );
    }
  }

  static Future<Response<T>> formRequest<T>(String uri, FormData parameters) {
    Dio dio = NServices.instance._dio;
    return dio.post<T>(
      uri,
      data: parameters,
      cancelToken: CancelToken(),
    );
  }

  static String urls(
    String path, {
    String base = AppConfig.baseUrl,
  }) {
    final url = base + path;
    print(url);
    return base + path;
  }

  static updateAuthorization(String token) {
    var tokenString = token;
    if (!token.startsWith('Bearer')) {
      tokenString = 'Bearer ' + token;
    }
    NServices.instance._dio.options.headers[HttpHeaders.authorizationHeader] =
        tokenString;
    Global.userInfo.token = token;
    Global.saveProfile();
  }

  static logout() {
    NServices.instance._dio.options.headers[HttpHeaders.authorizationHeader] =
        null;
  }

  static imageUrl(String url) {
    if (url == null) {
      return '';
    }
    if (url.startsWith('http')) {
      return url;
    } else if (url.startsWith('/')) {
      return AppConfig.baseUrl + url.substring(1);
    } else {
      return AppConfig.baseUrl + url;
    }
  }
}
