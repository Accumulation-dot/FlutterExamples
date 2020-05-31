import 'dart:io';

import 'package:chain_app/tools/services/services.dart';
import 'package:dio/dio.dart';

import 'app_config.dart';

class NewsServices {
  static const _news_list = 'news/list.json';

  static const _task_check = 'news/check.json';

  static const _news_task = 'news/task.json';

  static const _advert_add = 'advert/add.json';

  static const _advert_list = 'advert/list.json';

  static const _advert_mine = 'advert/mine.json';

  static const _advert_up = 'advert/up.json';

  /// 获取新闻列表
  static Future<Response> newsList({int p = 1, int s = NServices.s}) async {
    return NServices.get(_news_list, parameter: {page: p, size: s});
  }

  /// 检测是否已经还能继续阅读
  static Future<Response> taskCheck() {
    return NServices.get(_task_check);
  }

  static Future<Response> newsTask(String date) async {
    return NServices.post(
      _news_task,
      parameter: {'date': date},
    );
  }

  static Future<Response> advertList() {
    return NServices.get(_advert_list);
  }

  static Future<Response> advertAdd(
      String title, File image, String content) async {
    var imageData = await MultipartFile.fromFile(image.path);
    FormData formData = FormData.fromMap(
        {'img': imageData, 'content': content, 'title': title});

    return NServices.postForm(_advert_add, parameter: formData);
  }

  static Future<Response> advertMine({int p = 1, int s = NServices.s}) {
    return NServices.get(_advert_mine, parameter: {page: '$p', size: '$s'});
  }

  static Future<Response> advertUp(int advert) {
    return NServices.post(_advert_up, parameter: {'advert': advert});
  }
}
