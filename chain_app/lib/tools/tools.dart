import 'dart:io';
import 'dart:math';

import 'package:date_format/date_format.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class Tools {
  static const randomLength = 6;

  static const _alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';

  static const _digits = '1234567890';

  static const _lower = 'abcdefghijklmnopqrstuvwxyz';

  static final _upper = _lower.toUpperCase();

  static String randomString({int length = Tools.randomLength}) {
    String alphabet = 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
    String left = '';
    for (var i = 0; i < length; i++) {
      left = left + alphabet[Random().nextInt(alphabet.length)];
    }
    return left;
  }

  static String datetime(DateTime date, {List<String>format = const [yyyy,mm,dd,HH,nn,ss,SSS,uuu]}) {
    return formatDate(date, format);
  }

  static String random({int length = 10, String alphabet = _lower}) {
    String left = '';
    for (var i = 0; i < length; i++) {
      left = left + alphabet[Random().nextInt(alphabet.length)];
    }
    return left;
  }

  static String advertRandom(String code) {
    String alphabet = _lower + _upper + _digits;
    String rand = random(length: 10, alphabet: alphabet);
    return datetime(DateTime.now()) + code + rand;
  }

  static final RegExp _mobile = RegExp(
      '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$');

  static final RegExp _password =
      RegExp(r"(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$");

  /*
  * 判断mobile是否为手机号码
  * */
  static bool mobileReg(String mobile) {
    return Tools._mobile.hasMatch(mobile);
  }

  static bool passwordReg(String password) {
    return Tools._password.hasMatch(password);
  }

  static bool bankCard(String card) {
    return true;
  }

  static Future<File> imageCompress(File file, String tempName) async {
    String targetPath =
        Directory.systemTemp.path + '/userava' + tempName + '.jpg';
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 20,
    );
    return result;
  }

  /// 隐藏手机号码中的4位
  static String hideMobile(String target) {
    if (mobileReg(target)) {
      return target.replaceRange(3, 7, '*' * 4);
    }
    return target;
  }
}
