import 'package:chain_app/tools/services.dart';
import 'package:dio/dio.dart';

class Uri {
  static const register = 'user/register.json';

  static const login = 'user/login.json';

  static const pay_list = 'pay/all.json';

  static const pay_update = 'pay/list/';

  static const news_list = 'news/list.json';

  static const pay_bank = 'pay/bank.json';

  static const pay_ali = 'pay/ali.json';

  /// news task
  static const task_check = 'news/check.json';

  static const news_task = 'news/task.json';

  /// machine
  static const machine_list = 'machine/list.json';

  static const machine_order = 'machine/order.json';

  static const machine_mine = 'machine/mine.json';

  static const person_identifier = 'user/identify.json';

  static const person_summary = 'user/summary.json';

  static const coins_record = 'coins/record.json';

  /// trade sell / buy / sell_mine / sell_buy /

  static const buy_list = 'trade/buy/list.json';

  static const sell_list = 'trade/sell/list.json';

  static const buy_mine = 'trade/buy/mine.json';

  static const sell_mine = 'trade/sell/mine.json';

  static const sell_item = 'trade/sell/item.json';

  static const buy_item = 'trade/buy/item.json';

  static const sell_order_mine = 'trade/sell/order/mine.json';

  static const buy_order_mine = 'trade/buy/order/mine.json';
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
    return NServices.request(Uri.news_list,
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

  static Future<Response> pays(
      {int p = 1, int s = 30, bool bank = false}) async {
//    var parameters = {
//      page: '$p',
//      size: '$s',
//    };
//    return NServices.request(Uri.pay_list, queryParameters: parameters);
    if (bank) {
      return NServices.request(Uri.pay_bank);
    } else {
      return NServices.request(Uri.pay_ali);
    }
  }

  static Future<Response> addPay(
      {String type, String name, String number, bool bank = false}) async {
    var parameters = {
      'number': number,
    };

    return NServices.request(bank ? Uri.pay_bank : Uri.pay_ali,
        queryParameters: parameters, method: NServices.method_post);

//    if (bank) {
//    } else {
//      return NServices.request(Uri.pay_alipay, queryParameters: parameters, method: )
//    }
//    return NServices.request(Uri.pay_list,
//        queryParameters: parameters, method: NServices.method_post);
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

    return NServices.request(
      Uri.pay_update + "$id.json",
      queryParameters: parameters,
      method: NServices.method_patch,
    );
  }

  static Future<Response> delPay(int id) async {
    return NServices.request(
      Uri.pay_update + "$id.json",
      queryParameters: {'use': false},
      method: NServices.method_patch,
    );
  }

  static Future<Response> taskCheck() async {
    return NServices.request(
      Uri.task_check,
    );
  }

  static Future<Response> newsTask(String date) async {
    return NServices.request(
      Uri.news_task,
      queryParameters: {'date': date},
      method: NServices.method_post,
    );
  }

  static Future<Response> newsTaskList({int p = 1, int s = 30}) async {
    return NServices.request(
      Uri.news_task,
      queryParameters: {page: p, size: s},
    );
  }

  static Future<Response> machineList() async {
    return NServices.request(
      Uri.machine_list,
    );
  }

  static Future<Response> machineOrder(String serialNo) async {
    return NServices.request(
      Uri.machine_order,
      queryParameters: {"s_no": serialNo},
      method: NServices.method_post,
    );
  }

  // all 0, 1 未过期， 2 已过期
  static Future<Response> myMachine({int s = 0}) async {
    return NServices.request(
      Uri.machine_mine,
      queryParameters: {status: s},
    );
  }

  static Future<Response> machineAll() async {
    return myMachine();
  }

  static Future<Response> machineExpired() async {
    return myMachine(s: 2);
  }

  static Future<Response> machineUsed() async {
    return myMachine(s: 1);
  }

  /// 获取信息
  static Future<Response> identifier() async {
    return NServices.request(Uri.person_identifier);
  }

  static Future<Response> fillIdentifier(String name, String number) async {
    return NServices.request(Uri.person_identifier,
        method: NServices.method_post,
        queryParameters: {'name': name, 'number': number});
  }

  static Future<Response> personSummary() async {
    return NServices.request(Uri.person_summary);
  }

  static Future<Response> coinsRecord({int p = 1, int s = 30}) async {
    var parameter = {
      page: '$p',
      size: '$s',
    };
    return NServices.request(Uri.coins_record, queryParameters: parameter);
  }
}
