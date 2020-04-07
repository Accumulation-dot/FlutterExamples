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
  bool _phoneState, _pwdState = false;
  String _checkStr;
  TextEditingController _phonecontroller = new TextEditingController();
  TextEditingController _pwdcontroller = new TextEditingController();

  int _loginState = 0;

  void _checkPhone() {
    if (_phonecontroller.text.isNotEmpty &&
        _phonecontroller.text.trim().length == 11) {
      _phoneState = true;
    } else {
      _phoneState = false;
    }
  }

  void _checkPwd() {
    if (_pwdcontroller.text.isNotEmpty &&
        _pwdcontroller.text.trim().length >= 6 &&
        _pwdcontroller.text.trim().length <= 10) {
      _pwdState = true;
    } else {
      _pwdState = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(_loginState == 0 ? '极速登录' : '注册'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              setState(() {
                _loginState = _loginState == 1 ? 0 : 1;
              });
            },
          )
        ],
      ),
      body: new ListView(
        children: <Widget>[
          new Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Padding(
                padding: new EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 15.0),
                child: new Stack(
                  alignment: new Alignment(1.0, 1.0),
                  //statck
                  children: <Widget>[
                    new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          new Padding(
                            padding:
                                new EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                            child: Icon(Icons.account_box),
                          ),
                          new Expanded(
                            child: new TextField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(11),
                                WhitelistingTextInputFormatter.digitsOnly,
                              ],
                              controller: _phonecontroller,
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                hintText: '请输入用户名',
                              ),
                            ),
                          ),
                        ]),
                    new IconButton(
                      icon: new Icon(Icons.clear, color: Colors.black45),
                      onPressed: () {
                        _phonecontroller.clear();
                      },
                    ),
                  ],
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 40.0),
                child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      new Padding(
                        padding: new EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                        child: Icon(Icons.vpn_key),
                      ),
                      new Expanded(
                        child: new TextField(
                          controller: _pwdcontroller,
                          decoration: new InputDecoration(
                            hintText: '请输入密码',
                            suffixIcon: new IconButton(
                              icon:
                                  new Icon(Icons.clear, color: Colors.black45),
                              onPressed: () {
                                _pwdcontroller.clear();
                              },
                            ),
                          ),
                          obscureText: true,
                        ),
                      ),
                    ]),
              ),
              new Container(
                width: 340.0,
                child: new Card(
                  color: Colors.blue,
                  elevation: 16.0,
                  child: new FlatButton(
                    child: new Padding(
                      padding: new EdgeInsets.all(10.0),
                      child: new Text(
                        '极速登录',
                        style:
                            new TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      _checkPhone();
                      _checkPwd();
                      if (_phoneState && _pwdState) {
                        final request = _loginState == 0
                            ? WebServices.login(
                                _phonecontroller.text.trim(),
                                _pwdcontroller.text.trim(),
                              ).then((value) {
                                _loginSuccess(value);
                              }).catchError((e) {
                                _showError("$e");
                              })
                            : WebServices.register(
                                _phonecontroller.text.trim(),
                                _pwdcontroller.text.trim(),
                              ).then((value) {
                                _loginSuccess(value);
                              }).catchError((e) {
                                _showError("$e");
                              });
                      } else {
                        if (!_phoneState) {
                          _checkStr = '请输入11位手机号！';
                        } else if (!_pwdState) {
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
    cupertinoAlertDialog(context, content: content);
  }
}
