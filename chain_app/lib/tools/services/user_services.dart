import 'package:chain_app/tools/services/app_config.dart';
import 'package:chain_app/tools/services/services.dart';
import 'package:dio/dio.dart';

class UserServices {
  static const _team = 'user/team.json';

  static const _change_password = 'user/password.json';

  static Future<Response> team({int p = 1, int s = NServices.s}) {
    return NServices.get(_team, parameter: {page: '$p', size: '$s'});
  }

  /// para: op 原密码
  /// para: np 新密码
  static Future<Response> modifyPassword(String op, String np) {
    return NServices.post(_change_password, parameter: {'op': op, 'np': np});
  }
}
