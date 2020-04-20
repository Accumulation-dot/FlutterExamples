import 'dart:developer';

import 'package:chain_app/models/user_info.dart';
import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/global.dart';
import 'package:chain_app/tools/routes.dart';
import 'package:chain_app/tools/services.dart';
import 'package:chain_app/tools/webservices.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _checkStr;
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();

  int _loginState = 0;

  bool _checkPhone() {
  return (_phone.text.isNotEmpty &&
      _phone.text.trim().length == 11);
  }

  bool _checkPwd() {
    return (_password.text.isNotEmpty &&
        _password.text.trim().length >= 6 &&
        _password.text.trim().length <= 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loginState == 0 ? '极速登录' : '极速注册'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              setState(() {
                _loginState = _loginState == 1 ? 0 : 1;
              });
            },
            child: Text(
              _loginState == 0 ? '极速注册' : '极速登陆',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 15.0),
                child: Stack(
                  alignment: Alignment(1.0, 1.0),
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                            child: Icon(Icons.account_box),
                          ),
                          Expanded(
                            child: TextField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(11),
                                WhitelistingTextInputFormatter.digitsOnly,
                              ],
                              controller: _phone,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: '请输入手机号码',
                              ),
                            ),
                          ),
                        ]),
                    IconButton(
                      icon: Icon(Icons.clear, color: Colors.black45),
                      onPressed: () {
                        _phone.clear();
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 40.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                        child: Icon(Icons.vpn_key),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _password,
                          decoration: InputDecoration(
                            hintText: '请输入密码',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear, color: Colors.black45),
                              onPressed: () {
                                _password.clear();
                              },
                            ),
                          ),
                          obscureText: true,
                        ),
                      ),
                    ]),
              ),
              Container(
                width: 340.0,
                child: Card(
                  color: Colors.blue,
                  elevation: 16.0,
                  child: FlatButton(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        _loginState == 0 ? '极速登陆' : '极速注册',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      var _validation1 = _checkPhone();
                      var _validation2 = _checkPwd();
                      if (_validation1 && _validation2) {
                        final request = _loginState == 0
                            ? WebServices.login(
                                _phone.text.trim(),
                                _password.text.trim(),
                              ).then((value) {
                                _loginSuccess(value);
                              }).catchError((e) {
                                _showError("$e");
                              })
                            : WebServices.register(
                                _phone.text.trim(),
                                _password.text.trim(),
                              ).then((value) {
                                _loginSuccess(value);
                              }).catchError((e) {
                                _showError("$e");
                              });
                      } else {
                        if (!_validation1) {
                          _checkStr = '请输入11位手机号！';
                        } else if (!_validation2) {
                          _checkStr = '请输入6-10位密码！';
                        }

                        alertDialog(context, content: _checkStr);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _loginSuccess(Response value) {
    print(value);
    UserInfo userInfo = UserInfo.fromJson(value.data);
    Global.userInfo = userInfo;
    Global.saveProfile();
    NServices.updateAuthorization(userInfo.token);
    Navigator.of(context).pushReplacementNamed(Routes.tab);
  }

  _showError(String content) {
    alertDialog(context, content: content);
  }
}
