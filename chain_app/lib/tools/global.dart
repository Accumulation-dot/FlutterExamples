import 'dart:convert';

import 'package:chain_app/models/user_info.dart';
import 'package:chain_app/tools/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static String profileKey = '__profile_key';

  static UserInfo userInfo;

  static SharedPreferences _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    var _userInfo = _prefs.get(profileKey);
    if (_userInfo != null) {
      try {
        userInfo = UserInfo.fromJson(jsonDecode(_userInfo));
        NServices.updateAuthorization(userInfo.token);
      } catch (e) {
        print(e);
      }
    }
  }

  static saveProfile() =>
      _prefs.setString(profileKey, jsonEncode(userInfo.toJson()));

  static get token => userInfo != null ? userInfo.token : null;

}
