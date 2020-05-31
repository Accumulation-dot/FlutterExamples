import 'package:chain_app/models/app_version.dart';
import 'package:chain_app/pages/information/info_page.dart';
import 'package:chain_app/pages/machine/machine_page.dart';
import 'package:chain_app/pages/trade/trade_page.dart';
import 'package:chain_app/pages/user/user_page.dart';
import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/services/app_config.dart';
import 'package:chain_app/tools/services/login_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:ota_update/ota_update.dart';
import 'package:package_info/package_info.dart';

@immutable
class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _request();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: Scaffold(body: _body(), bottomNavigationBar: _bottom()));
  }

  _bottom() {
    return BottomNavigationBar(
      currentIndex: _index,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('资讯'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shop),
          title: Text('SD交易区'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money),
          title: Text('SD节点'),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), title: Text('SD商城')),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          title: Text('我的'),
        ),
      ],
      onTap: (index) {
        _index = index;
        setState(() {});
      },
      type: BottomNavigationBarType.fixed,
    );
  }

  _body() {
    switch (_index) {
      case 0:
        return InfoPage();
        break;
      case 1:
        return TradePage();
        break;
      case 2:
        return MachinePage();
        break;
      case 3:
        return Center(
          child: Text('等待开发'),
        );
        break;
      case 4:
        return UserPage();
        break;
    }
  }

  _request() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    LoginServices.checkVersion().then((value) {
      try {
        AppVersion appVersion = AppVersion.fromJson(value.data);
        int comapre = version.compareTo(appVersion.version);

        if (comapre == -1) {
          alertDialog(context,
              title: '新版本更新',
              content: '新版本 v${appVersion.version}发布了！',
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('取消')),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _download(appVersion.version, appVersion.app);
                    },
                    child: Text('去下载')),
              ]);
        }
      } catch (e) {}
    }).catchError((error) {});
  }

  _download(String version, String app) {
    try {
      String download;
      if (app.startsWith("http")) {
        download = app;
      } else {
        if (app.startsWith('/')) {
          download = AppConfig.baseUrl + app.substring(1);
        } else {
          download = AppConfig.baseUrl + app;
        }
      }
      OtaUpdate()
          .execute(download, destinationFilename: 'sd-$version.apk')
          .listen((event) {
        print(event.value);
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
