import 'package:chain_app/models/user_info.dart';
import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/de_info.dart';
import 'package:chain_app/tools/global.dart';
import 'package:chain_app/tools/routes.dart';
import 'package:chain_app/tools/services/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SManager {
  static void logout(BuildContext context, {String message = '用户信息过期, 请重新登陆'}) {
    if (Global.logoutSuccess()) {
      NServices.logout();
      showMessage(message);
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Routes.welcome, (route) => false);
    }
  }

  static void login(BuildContext context, dynamic data) {
    UserInfo userInfo = UserInfo.fromJson(data);
    Global.userInfo = userInfo;
    Global.saveProfile();
    NServices.updateAuthorization(userInfo.token);
    Navigator.of(context).pushReplacementNamed(Routes.tab);
  }

  static void showMessage(String content) {
    Fluttertoast.showToast(msg: content, timeInSecForIos: 1);
  }

  static void dioErrorHandle(BuildContext context, DioError error,
      {bool alert = false}) {
    DEInfo info = DEInfo.info(error);
    if (info.code == 401) {
      logout(context);
    } else {
      if (alert) {

        alertDialog(context, content: info.message);
      } else {
        showMessage(info.message);
      }
    }
  }
}
