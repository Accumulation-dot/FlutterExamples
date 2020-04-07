import 'dart:io';

import 'package:chain_app/tools/global.dart';
import 'package:dio/dio.dart';

class NServices {
  static const baseUrl = 'http://192.168.1.106:8000/';

  static const token = 'access_token';

  static const contentType_json = 'application/json';

  static const method_get = "GET";

  static const method_post = "POST";

  static const method_patch = "PATCH";

  static const method_put = "PUT";

  static Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {HttpHeaders.contentTypeHeader: ContentType.json},
    ),
  );

  static Future<Response<T>> request<T>(
    String url, {
    Map<String, dynamic> queryParameters,
    String method = method_get,
  }) async {
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

  static String urls(
    String path, {
    String base = baseUrl,
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
    dio.options.headers[HttpHeaders.authorizationHeader] = tokenString;
    Global.userInfo.token = token;
    Global.saveProfile();
  }
}
