import 'package:chain_app/pages/information/info_page.dart';
import 'package:chain_app/pages/market_page.dart';
import 'package:chain_app/pages/trade/trade_page.dart';
import 'package:chain_app/pages/user/user_page.dart';
import 'package:flutter/material.dart';

@immutable
class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _index = 0;

  List<Widget> body = [InfoPage(), TradePage(), MarketPage(), UserPage()];

  List<BottomNavigationBarItem> bottom = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('资讯'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shop),
      title: Text('ECO交易区'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.attach_money),
      title: Text('交易市场'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      title: Text('我的'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _getBody(body), bottomNavigationBar: _getBottom(bottom));
  }

  _getBottom(List<BottomNavigationBarItem> items) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: items,
      currentIndex: _index,
      onTap: (index) {
        setState(() {
          _index = index;
        });
      },
    );
  }

  _getBody(List<Widget> children) {
    return IndexedStack(
      index: _index,
      children: children,
    );
  }
}
