import 'package:chain_app/models/app_version.dart';
import 'package:chain_app/style/w_style.dart';
import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/global.dart';
import 'package:chain_app/tools/routes.dart';
import 'package:chain_app/tools/s_manager.dart';
import 'package:chain_app/tools/services/app_config.dart';
import 'package:chain_app/tools/services/login_services.dart';
import 'package:flutter/material.dart';
import 'package:ota_update/ota_update.dart';
import 'package:package_info/package_info.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String _version;

  // 1 检查版本
  // 0 最新版本
  // -1 需要更新
  int versionStatus = 1;

  AppVersion _versionNew;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initInfo();
    _request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: ListView(
        children: <Widget>[
//          ListTile(
//            title: Text('修改密码'),
//          ),
//          Divider(),

          ListTile(
            title: Text('当前版本: v${_version}'),
            trailing: _trailing(),
          ),
          Center(
            child: RaisedButton(
                color: Colors.green,
                child: Text(
                  '退出登陆',
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

  _initInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    setState(() {
      _version = version;
    });
  }

  _request() async {
    if (_version == null) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;
      setState(() {
        _version = version;
      });
    }

    LoginServices.checkVersion().then((value) {
      _versionNew = AppVersion.fromJson(value.data);
      versionStatus = _version.compareTo(_versionNew.version);
      setState(() {});
    }).catchError((error) {
      versionStatus = 0;
      setState(() {});
      SManager.dioErrorHandle(context, error);
    });
  }

  _trailing() {
    switch (versionStatus) {
      case 0:
        return Text('当前为最新版本');
      case -1:
        return FlatButton(
          onPressed: () {
            _download();
          },
          child: Text(
            '更新',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.orange,
          shape: WStyle.roundedBorder20,
        );
      case 1:
        return FlatButton(
          onPressed: () {
            _request();
          },
          child: Text('检查更新', style: TextStyle(color: Colors.white),),
          color: Colors.orange,
          shape: WStyle.roundedBorder20,
        );
      default:
        return Container();
    }
  }

  _download() {
    if (_versionNew == null) {
      _request();
      return;
    }
    try {
      String download;
      if (_versionNew.app.startsWith("http")) {
        download = _versionNew.app;
      } else {
        if (_versionNew.app.startsWith('/')) {
          download = AppConfig.baseUrl + _versionNew.app.substring(1);
        } else {
          download = AppConfig.baseUrl + _versionNew.app;
        }
      }
      OtaUpdate()
          .execute(download,
              destinationFilename: 'sd-${_versionNew.version}.apk')
          .listen((event) {
            print(event.value);
      });
    } catch (e) {
      alertDialog(context, content: e.toString());
    }
  }
}
