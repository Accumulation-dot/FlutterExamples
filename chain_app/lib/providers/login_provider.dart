import 'package:chain_app/models/user_info.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  UserInfo userInfo;

  bool get isLogin => token.isNotEmpty;

  String get token => userInfo.token;

  void login(UserInfo userInfo) {
    userInfo = userInfo;
    notifyListeners();
  }

  void logout() {
    if (!isLogin) {
      return;
    }
    userInfo = null;
    notifyListeners();
  }
}
