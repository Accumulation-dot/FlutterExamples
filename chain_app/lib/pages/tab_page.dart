import 'package:chain_app/pages/information/info_page.dart';
import 'package:chain_app/pages/machine/machine_page.dart';
import 'package:chain_app/pages/trade/trade_page.dart';
import 'package:chain_app/pages/user/user_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

@immutable
class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _index = 0;

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
}
