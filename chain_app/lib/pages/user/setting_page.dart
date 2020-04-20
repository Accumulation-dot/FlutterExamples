import 'package:chain_app/models/user_info.dart';
import 'package:chain_app/providers/login_provider.dart';
import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/global.dart';
import 'package:chain_app/tools/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('修改密码'),
          ),
          Divider(),
          Center(
            child: RaisedButton(
                color: Colors.green,
                child: Text(
                  '注销',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  alertDialog(context, content: '是否要注销当前用户?', actions: [
                    FlatButton(
                        onPressed: () {
//                          Navigator.of(context).pop();
//                          Global
                          Global.logout();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              Routes.welcome, (route) => false);
                        },
                        child: Text('确定')),
                  ]);
                }),
          ),
          Divider(),
        ],
      ),
    );
  }
}
