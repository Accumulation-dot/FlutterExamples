import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:myapp/service/cache_object.dart';

class NetCache extends Interceptor {
  /// property
  /// 缓存
  var cache = LinkedHashMap<String, CacheObject>();

  @override
  Future onRequest(RequestOptions options) {
    // TODO: implement onRequest
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    // TODO: implement onResponse
    return super.onResponse(response);
  }


  _saveCache(Response response) {
    RequestOptions options = response.request;
    if (options.extra['noCache'] != true && options.method.toLowerCase() == "get") {
      
    } else {
    }
  }
}