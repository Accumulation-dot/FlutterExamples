import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/routes.dart';
import 'package:flutter/material.dart';

class MarketPage extends StatefulWidget {
  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('交易市场'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.record);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              alert(context, message: '提示信息');
            },
          ),
        ],
      ),
      body: Center(
        child: Text('交易大厅'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text('挂卖'),
      ),
    );
  }
}
