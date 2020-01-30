import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Uri {
  /// base url
  static String baseUrl = bool.fromEnvironment('dart.vm.product') ? "http://" : "http://127.0.0.1:8000";

  /// 获取所有的分类
  static const category = "category_list";

  /// 获取商品
  static const commodity = "commodity";
}

///
class API {
  BuildContext context;

  ///
  Options _options;

  static Dio dio = Dio(BaseOptions(
    baseUrl: Uri.baseUrl,
    headers: {
      HttpHeaders.acceptHeader: "application/vnd.github.squirrel-girl-preview,"
          "application/vnd.github.symmetra-preview+json",
    },
  ));

  API([this.context]) {
    _options = Options(extra: {"context": context});
  }

  static void init() {
    // dio.interceptors.add(Global)
  }
}

Future getCommoditiesByCategory(int category_id) async {
  final base = Uri.baseUrl;
  final uri = Uri.category;
}
