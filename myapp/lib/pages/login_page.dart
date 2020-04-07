import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  String userName;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册/登陆'),
      ),
      body: InkWell(
        onTap: () {
          print('inkwel tap');
          Dio dio = Dio();
          dio.options.contentType = ContentType.json.toString();
          max(10, 11);
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: <Widget>[
            Center(),
            Container(
              decoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50), side: BorderSide())),
              padding: const EdgeInsets.all(20),
              child: Form(
                key: loginKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: '请输入账号/邮箱/手机号'),
                      onSaved: (value) {
                        userName = value;
                      },
                      onFieldSubmitted: (value) {},
                      validator: (value) {
                        return value.trim().length > 0 ? null : '用户名不能位空';
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: '请输入密码'),
                      obscureText: true,
                      onSaved: (value) {
                        password = value;
                      },
                      onChanged: (value) {
                        print(value);
                      },
                      validator: (value) {
                        return value.length < 6 ? "密码长度不能小于6位" : null;
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'test',),
                      onChanged: (value) {},
                      onSubmitted: (value) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ),
                    ListView.separated(itemBuilder: null, separatorBuilder:(context, index) => Divider(), itemCount: null),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 100,
              height: 40,
              child: RaisedButton(
                onPressed: login,
                child: Text('登陆'),
              ),
            )
          ],
        ),
      ),
    );
  }

  login() {
    var loginState = loginKey.currentState;
    if (loginState.validate()) {
      loginState.save();
      FocusScope.of(context).requestFocus(FocusNode());
    } else {}
  }
}
