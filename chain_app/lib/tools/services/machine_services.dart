import 'package:chain_app/tools/services/services.dart';
import 'package:dio/dio.dart';

import 'app_config.dart';

class MUri {
  /// machine
  static const machine_list = 'machine/list.json';

  static const machine_order = 'machine/order.json';

  static const machine_mine = 'machine/mine.json';
}

class MachineServices {
  static Future<Response> machineList() async {
    return NServices.request(
      MUri.machine_list,
    );
  }

  static Future<Response> machineOrder(String serialNo) async {
    return NServices.request(
      MUri.machine_order,
      queryParameters: {"s_no": serialNo},
      method: method_post,
    );
  }

  // all 0, 1 未过期， 2 已过期
  static Future<Response> myMachine({int s = 0}) async {
    return NServices.request(
      MUri.machine_mine,
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
}
