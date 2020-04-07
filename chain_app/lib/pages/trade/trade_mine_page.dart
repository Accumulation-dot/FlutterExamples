import 'package:chain_app/pages/information/widgets/info_widget.dart';
import 'package:chain_app/pages/trade/choice.dart';
import 'package:chain_app/tools/webservices.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class TradeMinePage extends StatefulWidget {
  @override
  _TradeMinePageState createState() => _TradeMinePageState();
}

class _TradeMinePageState extends State<TradeMinePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  List<Tab> tabs = Choice.tradeList().map((e) {
    return Tab(
      text: e.title,
      icon: Icon(e.iconData),
    );
  }).toList();

  @override
  void initState() {
    _controller = TabController(vsync: this, length: tabs.length);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('我的交易信息'),
          bottom: TabBar(
            tabs: tabs,
            controller: _controller,
          )),
      body: TabBarView(
        children: [
          BuyMinePage(),
          SellMinePage(),
        ],
        controller: _controller,
      ),
    );
  }
}

class SellMinePage extends StatefulWidget {
  final bool navigator;

  final String title;

  const SellMinePage({Key key, this.navigator = false, this.title})
      : super(key: key);

  @override
  _SellMinePageState createState() => _SellMinePageState();
}

class _SellMinePageState extends State<SellMinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.navigator
          ? AppBar(
              title: Text(widget.title),
              centerTitle: true,
            )
          : null,
      body: InfiniteListView(
          loadingBuilder: (context) => InfoWidget.loadingWidget(),
          onRetrieveData: (p, items, refresh) {
            return WebServices.myBuyRecords(p: p).then((value) {
              if (refresh) {
                items.clear();
              }
              print(value);
              items.addAll([1, 2, 3, 4, 5, 6, 7, 8, 8, 9]);
              return true;
            });
          },
          itemBuilder: (list, index, context) {
            return ListTile(
              title: Text('${index}'),
            );
          }),
    );
  }
}

class BuyMinePage extends StatefulWidget {
  final bool navigator;

  final String title;

  const BuyMinePage({Key key, this.navigator = false, this.title = ''}) : super(key: key);

  @override
  _BuyMinePageState createState() => _BuyMinePageState();
}

class _BuyMinePageState extends State<BuyMinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.navigator
          ? AppBar(
              title: Text(widget.title),
              centerTitle: true,
            )
          : null,
      body: InfiniteListView(
          loadingBuilder: (context) => InfoWidget.loadingWidget(),
          onRetrieveData: (p, items, refresh) {
            return WebServices.myBuyRecords(p: p).then((value) {
              if (refresh) {
                items.clear();
              }
              items.addAll([1, 2, 3, 4, 5, 6, 7, 8, 8, 9]);
              return false;
            });
          },
          itemBuilder: (list, index, context) {
            return ListTile(
              title: Text('${index}'),
            );
          }),
    );
  }
}
