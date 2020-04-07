import 'dart:ffi';

import 'package:chain_app/tools/services.dart';
import 'package:dio/dio.dart';

final username = "username";

final password = "password";

final page = 'page';

final size = 'size';

final number = 'number';

class Uri {
  static const register = 'user/register.json';

  static const login = 'user/login.json';

  static const buy_list = 'trade/buy/list.json';

  static const sell_list = 'trade/sell/list.json';

  static const buy_mine = 'trade/buy/mine.json';

  static const sell_mine = 'trade/sell/mine.json';

  static const pay_list = 'pay/list.json';

  static const pay_update = 'pay/list/';
}

class WebServices {
  /// 登陆
  static Future<Response> login(String u, String p) async {
    return NServices.request(Uri.login,
        queryParameters: {username: u, password: p},
        method: NServices.method_post);
  }

  /// 注册
  static Future<Response> register(String u, String p) async {
    return NServices.request('user/register.json',
        queryParameters: {username: u, password: p},
        method: NServices.method_post);
  }

  /// 获取新闻列表
  static Future<Response> newsList({int p = 1, int s = 30}) async {
    return NServices.request('news/list.json',
        queryParameters: {page: p, size: s});
  }

  /// 获取广告列表
  static Future<Response> advertList({int p = 1, int s = 30}) async {
    return NServices.request('advert/list.json',
        queryParameters: {page: p, size: s});
  }

  /// 查看广告记录
  /// 如果存在username 查询的就是usename下的所有信息
  /// 如果不存在查询的就是当前用户auth对应的用户名称
  static Future<Response> advertRecord(
      {int p = 1, int s = 30, String u}) async {
    var parameter = {page: '$p', size: '$s'};
    if (u != null && u.length > 0) {
      parameter[username] = u;
    }
    return NServices.request(
      'advert/records.json',
      queryParameters: parameter,
    );
  }

  /// 收购信息
  static Future<Response> tradeInRecord({
    int p = 1,
    int s = 30,
  }) async {
    var parameter = {
      page: '$p',
      size: '$s',
    };
    return NServices.request(
      'trade/buy/list.json',
      queryParameters: parameter,
    );
  }

  /// 出售信息信息
  static Future<Response> tradeOutRecord({int p = 1, int s = 30}) async {
    var parameter = {
      page: '$p',
      size: '$s',
    };
    return NServices.request(
      'trade/sell/list.json',
      queryParameters: parameter,
    );
  }

  static Future<Response> myBuyRecords({int p = 1, int s = 30}) async {
    var parameter = {
      page: '$p',
      size: '$s',
    };
    return NServices.request(
      Uri.buy_mine,
      queryParameters: parameter,
    );
  }

  static Future<Response> addInRecord({double n = 10.0}) async {
    return NServices.request(
      'trade/buy/item.json',
      queryParameters: {number: n},
      method: NServices.method_post,
    );
  }

  static Future<Response> pays({int p = 1, int s = 30}) async {
    var parameters = {
      page: '$p',
      size: '$s',
    };
    return NServices.request(Uri.pay_list, queryParameters: parameters);
  }

  static Future<Response> addPay({
    String type,
    String name,
    String number,
  }) async {
    var parameters = {
      'type': type,
      'name': name,
      'number': number,
    };
    return NServices.request(Uri.pay_list,
        queryParameters: parameters, method: NServices.method_post);
  }

  static Future<Response> updatePay(
      {int id, String type, String name, String number}) async {
    var parameters = <String, String>{};
    if (type != null) {
      parameters['type'] = type;
    }
    if (name != null) {
      parameters['name'] = name;
    }
    if (number != null) {
      parameters['number'] = number;
    }

    return NServices.request(Uri.pay_update + "$id.json",
        queryParameters: parameters, method: NServices.method_patch);
  }

  static Future<Response> delPay(int id) async {
    return NServices.request(Uri.pay_update + "$id.json",
        queryParameters: {'use': false}, method: NServices.method_patch);
  }
}
