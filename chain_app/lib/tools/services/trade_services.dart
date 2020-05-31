import 'dart:io';

import 'package:chain_app/tools/services/services.dart';
import 'package:dio/dio.dart';

import 'app_config.dart';

/// 交易部分的接口
class TradeService {
  /// trade sell / buy / sell_mine / sell_buy /

  static const _buy_list = 'trade/buy/list.json';

  ///
  static const _sell_list = 'trade/sell/list.json';

  ///
  static const _buy_mine = 'trade/buy/mine.json';

  ///
  static const _sell_mine = 'trade/sell/mine.json';

  ///
  static const _sell_item = 'trade/sell/item.json';

  ///
  static const _sell_order = 'trade/sell/order.json';

  ///
  static const _sell_cancel = 'trade/sell/cancel.json';

  ///
  static const _buy_order = 'trade/buy/order.json';

  ///
  static const _buy_item = 'trade/buy/item.json';


  static const _buy_cancel = 'trade/buy/cancel.json';

  ///
  static const _sell_order_mine = 'trade/sell/order/mine.json';

  ///
  static const _buy_order_mine = 'trade/buy/order/mine.json';

  ///
  static const _sell_order_fill = 'trade/sell/order/fill.json';

  ///
  static const _sell_confirm = 'trade/sell/confirm.json';

  ///
  static const _buy_fill = 'trade/buy/fill.json';

  ///
  static const _buy_order_confirm = 'trade/buy/order/confirm.json';

  static const _price = 'trade/price.json';

  /// 添加收购
  /// num: 数量
  /// pri: 单价
  static Future<Response> addBuy({int num, int pri}) async {
    return NServices.request(
      _buy_item,
      queryParameters: {number: '$num', price: '$pri'},
      method: method_post,
    );
  }

  /// 添加出售
  /// num: 数量
  /// pri: 单价
  static Future<Response> addSell({int num, int pri}) async {
    return NServices.request(
      _sell_item,
      queryParameters: {number: '$num', price: '$pri'},
      method: method_post,
    );
  }

  static Future<Response> sellOrder(String serialNo) async {
    var parameter = {'s_no': serialNo};
    return NServices.request(_sell_order,
        queryParameters: parameter, method: method_post);
  }

  static Future<Response> sellCancel(String serialNo) {
    var parameter = {'s_no': serialNo};
    return NServices.request(_sell_cancel,
        queryParameters: parameter, method: method_post);
  }

  /// 获取我的预定: 出售订单
  static Future<Response> sellOrdered(int ss, {int p = 1, int s = NServices.s}) async {
    var parameter = {
      page: '$p',
      size: '$s',
    };
    if (status != null) {
      parameter[status] = '$ss';
    }
    return NServices.request(_sell_order_mine, queryParameters: parameter);
  }

  static Future<Response> buyCancel(String serialNo) {
    var parameter = {'s_no': serialNo};
    return NServices.request(_buy_cancel,
        queryParameters: parameter, method: method_post);
  }

  /// 获取我的预定: 求购订单
  static Future<Response> buyOrdered(int ss, {int p = 1, int s = NServices.s}) async {
    var parameter = {
      page: '$p',
      size: '$s',
    };
    if (status != null) {
      parameter[status] = '$ss';
    }
    return NServices.request(_buy_order_mine, queryParameters: parameter);
  }

  /// 收购信息 其他人的收购信息
  static Future<Response> tradeBuy({
    int p = 1,
    int s = NServices.s,
  }) async {
    var parameter = {
      page: '$p',
      size: '$s',
    };
    return NServices.request(
      _buy_list,
      queryParameters: parameter,
    );
  }

  /// 出售信息信息 其他人的出售信息
  static Future<Response> tradeSell({int p = 1, int s = NServices.s}) async {
    var parameter = {
      page: '$p',
      size: '$s',
    };
    return NServices.request(
      _sell_list,
      queryParameters: parameter,
    );
  }

  /// 我的求购信息
  static Future<Response> buyMine({int stus, int p = 1, int s = NServices.s}) async {
    var parameter = {
      page: '$p',
      size: '$s',
    };
    if (stus != null) {
      parameter[status] = '$stus';
    }
    return NServices.request(
      _buy_mine,
      queryParameters: parameter,
    );
  }

  /// 我的出售信息
  static Future<Response> sellMine({int stus, int p = 1, int s = NServices.s}) async {
    var parameter = {
      page: '$p',
      size: '$s',
    };
    if (stus != null) {
      parameter[status] = '$stus';
    }
    return NServices.request(
      _sell_mine,
      queryParameters: parameter,
    );
  }

  static Future<Response> tradeMine(String uri,
      {int ss, int p = 1, int s = NServices.s}) async {
    var parameter = {
      page: '$p',
      size: '$s',
    };
    if (ss != null) {
      parameter[status] = '$ss';
    }
    return NServices.request(
      uri,
      queryParameters: parameter,
    );
  }

//  static Future<Response> sellFill(String serialNo, String ali) async {
//    var parameter = {
//      's_no': serialNo,
//      'order': ali,
//    };
//
//    return NServices.request(_sell_order_fill, queryParameters: parameter, method: NServices.method_post);
//  }

  static Future<Response> sellFillImage(String serialNo, File image) async {
    var imageData = await MultipartFile.fromFile(image.path);
    FormData formData = FormData.fromMap({
      's_no': serialNo,
      'img': imageData,
      'order': '',
    });

    return NServices.formRequest(_sell_order_fill, formData);
  }

  ///
  static Future<Response> sellConfirm(String serialNo) async {
    var parameter = {
      's_no': serialNo,
    };

    return NServices.request(_sell_confirm,
        queryParameters: parameter, method: method_put);
  }

  ///
  static Future<Response> buyOrder(String serialNo) async {
    var parameter = {'s_no': serialNo};
    return NServices.request(_buy_order,
        queryParameters: parameter, method: method_post);
  }

  static Future<Response> buyFill(String serialNo, String ali) async {
    var parameter = {
      's_no': serialNo,
      'order': ali,
    };

    return NServices.request(_buy_fill,
        queryParameters: parameter, method: method_post);
  }

  static Future<Response> buyFillImage(String serialNo, File image) async {
    var imageData = await MultipartFile.fromFile(image.path);
    FormData formData = FormData.fromMap({
      's_no': serialNo,
      'img': imageData,
      'order': '',
    });
    return NServices.formRequest(_buy_fill, formData);
  }

  static Future<Response> buyOrderConfirm(String serialNo) async {
    var parameter = {
      's_no': serialNo,
    };

    return NServices.request(_buy_order_confirm,
        queryParameters: parameter, method: method_put);
  }

  static Future<Response> queryPrice() async {
    return NServices.request(_price);
  }
}
