import 'package:chain_app/tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef LoginCallback = void Function(
    String mobile, String password, String inviter);

class LoginWidget {
  static Widget mobileWidget(TextEditingController textEditingController) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: '11位手机号',
      ),
      enableInteractiveSelection: false,
      inputFormatters: [
        LengthLimitingTextInputFormatter(11),
        WhitelistingTextInputFormatter.digitsOnly,
      ],
      keyboardType: TextInputType.phone,
    );
  }

  static Widget passwordWidget(TextEditingController textEditingController) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: '密码',
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(16),
      ],
      obscureText: true,
      keyboardType: TextInputType.text,
      enableInteractiveSelection: false,
    );
  }

  static Widget validateWidget(
      TextEditingController textEditingController, int length) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: '请输入验证码',
      ),
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp('[a-zA-Z]')),
        LengthLimitingTextInputFormatter(length)
      ],
    );
  }

  static Widget inviterWidget(TextEditingController textEditingController,
      {int length = 12}) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: '选填，请输入邀请码',
      ),
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp('[a-zA-Z0-9]')),
        LengthLimitingTextInputFormatter(length)
      ],
    );
  }
}
