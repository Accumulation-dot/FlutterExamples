import 'package:chain_app/tools/services/app_config.dart';
import 'package:chain_app/tools/services/services.dart';
import 'package:dio/dio.dart';

class UserServices {
  static const _team = 'user/team.json';

  static Future<Response> team({int p = 1, int s = 30}) {
    return NServices.get(_team, parameter: {page: '$p', size: '$s'});
  }
}
