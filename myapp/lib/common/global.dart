import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/models/cache_config.dart';
import 'package:myapp/models/profile.dart';
import 'package:myapp/service/net_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';


const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];





class Global {

  static final String profileKey = "profile";

  static SharedPreferences preferences; 

  static Profile profile = Profile();
  
  static NetCache netCache = NetCache();

  static List<MaterialColor> get themes => _themes;

  static bool get isRelease => bool.fromEnvironment('dart.vm.product');

  static Future init() async {
    preferences = await SharedPreferences.getInstance();
    var _profile = preferences.getString(Global.profileKey);
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        preferences.remove('profile');
        print(e);
      }
    }
    profile.cache = profile.cache ?? CacheConfig(true, 3600, 100);
    

  }

  static saveProfile() => preferences.setString(Global.profileKey, jsonEncode(profile.toJson()));
}