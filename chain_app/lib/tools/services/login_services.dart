import 'package:chain_app/tools/services/app_config.dart';
import 'package:chain_app/tools/services/w_services.dart';
import 'package:dio/dio.dart';

class LoginServices {

  static const _register = 'user/register.json';

  static const _login = 'user/login.json';

  static const _cs = 'machine/cs.json';

  static const _version = 'version.json';

  static Future<Response> login(String u, String p) {
    return WServices.post(_login, parameter: {username: u, password: p});
  }

  static Future<Response> registerF(String u, String p, String i) {
    return WServices.post(_login, parameter: {username: u, password: p});
  }

  static Future<Response> cs() {
    return WServices.get(_cs);
  }

  static void loginT(String u, String p, {ResponseCallback2 callback2}) {
    WServices.postR(_login,
        parameter: {username: u, password: p}, callback2: callback2);
  }

  static void registerT(String u, String p, String i,
      {ResponseCallback2 callback2}) {
    WServices.postR(_register,
        parameter: {username: u, password: p, inviter: i},
        callback2: callback2);
  }


  static Future<Response> checkVersion() async {
    return WServices.get(_version);
  }

}
