import 'dart:math';

import 'package:chain_app/models/user_info.dart';
import 'package:chain_app/pages/login/login.dart';
import 'package:chain_app/pages/login/register.dart';
import 'package:chain_app/pages/login/widgets/login_widget.dart';
import 'package:chain_app/style/w_style.dart';
import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/global.dart';
import 'package:chain_app/tools/routes.dart';
import 'package:chain_app/tools/s_manager.dart';
import 'package:chain_app/tools/services/services.dart';
import 'package:chain_app/tools/services/login_services.dart';
import 'package:chain_app/tools/tools.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _loginState = 0;

  String _random = Tools.randomString();

  TextEditingController _randomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(_loginState == 0 ? '极速登录' : '极速注册'),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.headset_mic),
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.cs);
              }),
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
                ))
          ]),
      body: Builder(builder: (context) {
//        final progress = ProgressHUD.of(context);
        return InkWell(
          child: Column(
            children: [
              Container(
                margin: WStyle.symmetric(v: 30),
                alignment: Alignment.center,
                child: Image.asset('images/icon.jpg', width: 80, height: 80,),
              ),
              Container(
                child: _loginState == 0
                    ? Login(
                    callback: (String mobile, String password, String inviter) {
                      _showDialog(
                          context: context,
                          callback: () {
                            LoginServices.loginT(mobile, password,
                                callback2: (int code, dynamic data) {
                                  if (code == 201) {
                                    SManager.login(context, data);
                                  } else {
                                    alertDialog(context, content: data.toString());
                                  }
                                });
                          });
                    })
                    : Register(
                  callback: (String mobile, String password, String inviter) {
                    _showDialog(
                        context: context,
                        callback: () {
//                      progress.show();
                          LoginServices.registerT(mobile, password, inviter,
                              callback2: (int code, dynamic data) {
//                            progress.dismiss();
                                if (code == 201) {
                                  SManager.login(context, data);
                                } else {
                                  alertDialog(context, content: data.toString());
                                }
                              });
                        });
                  },
                ),
              ),
            ],
          ),
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
        );
      }),
    );
  }

  _showDialog({BuildContext context, VoidCallback callback}) {
    _random = Tools.randomString();
    _randomController.clear();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text('提示'),
          ),
          content: SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    width: 80,
                    child: LoginWidget.validateWidget(
                        _randomController, Tools.randomLength)),
                SizedBox(
                    width: 80,
                    child: Center(
                      child:
                          Text('$_random', style: TextStyle(color: Colors.red)),
                    ))
              ],
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('取消'),
            ),
            FlatButton(
              child: Text('确定'),
              onPressed: () {
                String random = _randomController.text;
                if (random.toLowerCase().compareTo(_random.toLowerCase()) ==
                    0) {
                  Navigator.of(context).pop();
                  callback();
                } else {
                  Navigator.of(context).pop();
                  alertDialog(context, content: '请输入正确的验证码');
                }
              },
            )
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _randomController.dispose();
    super.dispose();
  }
}
