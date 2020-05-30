import 'package:chain_app/tools/services/services.dart';
import 'package:dio/dio.dart';

class CoinServices {
  static const _rule = 'coins/rules.json';

  static Future<Response> ruleQuery() {
    return NServices.get(_rule);
  }
}